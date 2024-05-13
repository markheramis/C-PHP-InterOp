#include <phpcpp.h>

/**
 *  tell the compiler that the get_module is a pure C function
 */
extern "C"
{

    /**
     *  my_no_parameters_function()
     *  @return Php::Value
     */
    Php::Value my_no_parameters_function()
    {
        return "42";
    }

    /**
     *  Function that is called by PHP right after the PHP process
     *  has started, and that returns an address of an internal PHP
     *  strucure with all the details and features of your extension
     *
     *  @return void*   a pointer to an address that is understood by PHP
     */
    PHPCPP_EXPORT void *get_module()
    {
        // static(!) Php::Extension object that should stay in memory
        // for the entire duration of the process (that's why it's static)
        static Php::Extension extension("examplephpextension", "1.0");

        // add function to extension
        extension.add<my_no_parameters_function>("my_no_parameters_function");

        // return the extension
        return extension;
    }
}