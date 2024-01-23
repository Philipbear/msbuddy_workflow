#!/usr/bin/env nextflow
nextflow.enable.dsl=2

// msbuddy params
params.input_file = "$baseDir/test/input_file.mgf"
params.ms_instr = "None"
params.halogen = 0
params.timeout_secs = 600
params.ppm = 1
params.ms1_tol = 5
params.ms2_tol = 10
params.batch_size = 5000
params.c_min = 0
params.c_max = 80
params.h_min = 0
params.h_max = 150
params.n_min = 0
params.n_max = 20
params.o_min = 0
params.o_max = 30
params.p_min = 0
params.p_max = 10
params.s_min = 0
params.s_max = 15
params.f_min = 0
params.f_max = 20
params.cl_min = 0
params.cl_max = 15
params.br_min = 0
params.br_max = 10
params.i_min = 0
params.i_max = 10
params.isotope_bin_mztol = 0.02
params.max_isotope_cnt = 4
params.rel_int_denoise_cutoff = 0.01
params.top_n_per_50_da = 6
params.parallel = 0
params.n_cpu = 1


TOOL_FOLDER = "$baseDir/bin"

process performMsbuddy {
    publishDir "./nf_output", mode: 'copy'

    conda "$TOOL_FOLDER/conda_env.yml"

    input:
    file input_file

    output:
    path 'msbuddy_output/*'

    """
    python $TOOL_FOLDER/msbuddy/main_nextflow.py -input $input_file \
    -ms $params.ms_instr -hal $params.halogen \
    -timeout_secs $params.timeout_secs \
    -ppm $params.ppm -ms1_tol $params.ms1_tol -ms2_tol $params.ms2_tol \
    -bs $params.batch_size \
    -c_min $params.c_min -c_max $params.c_max \
    -h_min $params.h_min -h_max $params.h_max \
    -n_min $params.n_min -n_max $params.n_max \
    -o_min $params.o_min -o_max $params.o_max \
    -p_min $params.p_min -p_max $params.p_max \
    -s_min $params.s_min -s_max $params.s_max \
    -f_min $params.f_min -f_max $params.f_max \
    -cl_min $params.cl_min -cl_max $params.cl_max \
    -br_min $params.br_min -br_max $params.br_max \
    -i_min $params.i_min -i_max $params.i_max \
    -isotope_bin_mztol $params.isotope_bin_mztol \
    -max_isotope_cnt $params.max_isotope_cnt \
    -rel_int_denoise_cutoff $params.rel_int_denoise_cutoff \
    -top_n_per_50_da $params.top_n_per_50_da \
    -parallel $params.parallel \
    -n_cpu $params.n_cpu
    """
}

workflow {
    file_ch = Channel.fromPath("$params.input_file")
    
    // Outputting Python
    performMsbuddy(file_ch)

}