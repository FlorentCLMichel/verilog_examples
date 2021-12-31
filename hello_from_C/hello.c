#include  <vpi_user.h>

unsigned int sum(unsigned int x, unsigned int y) {
    return x + y;
}

static int hello_compiletf(char* user_data)
{
    return 0;
}

static int hello_calltf(char* user_data)
{

    // get values from Verilog
    vpiHandle tf_obj = vpi_handle (vpiSysTfCall, NULL);
    vpiHandle arg_iter = vpi_iterate (vpiArgument, tf_obj);
    vpiHandle arg_obj;
    s_vpi_value v;
    v.format = vpiIntVal;
    arg_obj = vpi_scan (arg_iter);
    vpi_get_value(arg_obj, &v);
    unsigned int x = v.value.integer;
    arg_obj = vpi_scan (arg_iter);
    vpi_get_value(arg_obj, &v);
    unsigned int y = v.value.integer;
    
    // perform a calculation
    vpi_printf("Hello from C!\n");
    unsigned int z = sum(x, y);
    vpi_printf("Let's compute something: %d + %d = %d\n", x, y, z);

    // return the value to Verilog
    arg_obj = vpi_scan (arg_iter);
    vpi_get_value(arg_obj, &v);
    v.value.integer = z;
    vpi_put_value(arg_obj, &v, NULL, vpiNoDelay);
    
    return 0;
}

void hello_register()
{
    s_vpi_systf_data tf_data;

    tf_data.type      = vpiSysTask;
    tf_data.tfname    = "$hello";
    tf_data.calltf    = hello_calltf;
    tf_data.compiletf = hello_compiletf;
    tf_data.sizetf    = 0;
    tf_data.user_data = 0;
    vpi_register_systf(&tf_data);
}

void (*vlog_startup_routines[])() = {
    hello_register,
    0
};
