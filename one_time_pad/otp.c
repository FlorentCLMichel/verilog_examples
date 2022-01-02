#include <stdlib.h>
#include  <vpi_user.h>

unsigned int otp(unsigned int message, unsigned int pad) {
    return message ^ pad;
}

static int otp_calltf(char* user_data)
{

    // get values from Verilog
    vpiHandle tf_obj = vpi_handle (vpiSysTfCall, NULL);
    vpiHandle arg_iter = vpi_iterate (vpiArgument, tf_obj);
    vpiHandle arg_obj;
    s_vpi_value v;
    v.format = vpiIntVal;
    arg_obj = vpi_scan (arg_iter);
    vpi_get_value(arg_obj, &v);
    unsigned int message = v.value.integer;
    arg_obj = vpi_scan (arg_iter);
    vpi_get_value(arg_obj, &v);
    unsigned int pad = v.value.integer;
    
    // perform the calculation
    unsigned int cipher = otp(message, pad);

    // return the value to Verilog
    arg_obj = vpi_scan (arg_iter);
    vpi_get_value(arg_obj, &v);
    v.value.integer = cipher;
    vpi_put_value(arg_obj, &v, NULL, vpiNoDelay);
    
    return 0;
}

static int rand_calltf(char* user_data)
{
    vpiHandle tf_obj = vpi_handle (vpiSysTfCall, NULL);
    vpiHandle arg_iter = vpi_iterate (vpiArgument, tf_obj);
    vpiHandle arg_obj;
    s_vpi_value v;
    v.format = vpiIntVal;
    arg_obj = vpi_scan (arg_iter);
    vpi_get_value(arg_obj, &v);
    v.value.integer = rand();
    vpi_put_value(arg_obj, &v, NULL, vpiNoDelay);
    
    return 0;
}

static int init_rand_calltf(char* user_data)
{
    time_t t; 
    srand((unsigned) time(&t));
    
    return 0;
}

void otp_register()
{
    s_vpi_systf_data tf_data;

    tf_data.type      = vpiSysTask;
    tf_data.tfname    = "$otp_c";
    tf_data.calltf    = otp_calltf;
    tf_data.compiletf = NULL;
    tf_data.sizetf    = 0;
    tf_data.user_data = 0;
    vpi_register_systf(&tf_data);
}

void rand_register()
{
    s_vpi_systf_data tf_data;

    tf_data.type      = vpiSysTask;
    tf_data.tfname    = "$random_from_c";
    tf_data.calltf    = rand_calltf;
    tf_data.compiletf = NULL;
    tf_data.sizetf    = 0;
    tf_data.user_data = 0;
    vpi_register_systf(&tf_data);
}

void init_rand_register()
{
    s_vpi_systf_data tf_data;

    tf_data.type      = vpiSysTask;
    tf_data.tfname    = "$seed_rng";
    tf_data.calltf    = init_rand_calltf;
    tf_data.compiletf = NULL;
    tf_data.sizetf    = 0;
    tf_data.user_data = 0;
    vpi_register_systf(&tf_data);
}

void (*vlog_startup_routines[])() = {
    otp_register,
    rand_register,
    init_rand_register,
    0
};
