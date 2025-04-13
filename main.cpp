#include "inlin_api.h"
#include <pybind11/embed.h>
#include <iostream>
using namespace std;
namespace py = pybind11;

int main(int argc, char* argv[]) {
    if (argc < 2) {
        cerr << "Usage: " << argv[0] << " <python_script.py>" << endl;
        return 1;
    }
    
    // Start the embedded Python interpreter.
    py::scoped_interpreter guard{};
    
    try {
        // Evaluate the specified Python script.
        py::eval_file(argv[1]);
    }
    catch (py::error_already_set &e) {
        cerr << "Python error: " << e.what() << endl;
        return 1;
    }
    
    return 0;
}