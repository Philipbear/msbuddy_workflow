#!/usr/bin/env nextflow
nextflow.enable.dsl=2

// msbuddy params
params.input_file = "$baseDir/test/input_file.mgf"
params.ms_instr = "None"
params.halogen = 0
params.ms1_tol = 5
params.ms2_tol = 10


TOOL_FOLDER = "$baseDir/bin"

process performMsbuddy {
    publishDir "./nf_output", mode: 'copy'

    conda "$TOOL_FOLDER/conda_env.yml"

    input:
    path input_file
    val ms_instr
    val halogen
    val ms1_tol
    val ms2_tol

    output:
    path 'msbuddy_output/*'

    script:
    // Determine file extension and adjust command line accordingly
    def file_ext = input_file.getName().toLowerCase().endsWith('.mgf') ? '-mgf' : input_file.getName().toLowerCase().endsWith('.csv') ? '-csv' : ''
    // Include '-hal' if params.halogen is 1
    def halogen_option = halogen == 1 ? '-hal' : ''

    def commandline_call = "${file_ext} ${input_file} -ms ${ms_instr} ${halogen_option} -ms1_tol ${ms1_tol} -ms2_tol ${ms2_tol} -d"

    """
    msbuddy ${commandline_call}
    """
}


workflow {
//     file_ch = Channel.fromPath(params.input_file)

    performMsbuddy(params.input_file, params.ms_instr, params.halogen, params.ms1_tol, params.ms2_tol)
}