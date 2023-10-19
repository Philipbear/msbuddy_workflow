#!/usr/bin/env nextflow
nextflow.enable.dsl=2

// msbuddy params
params.input = "README.md"
params.details = 1
params.ms_instr = "orbitrap"
params.halogen = 1
params.timeout_secs = 600
params.ppm = 1
params.ms1_tol = 5
params.ms2_tol = 10
params.top_n_candidate = 500
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
params.ms2_denoise = 1
params.rel_int_denoise = 1
params.rel_int_denoise_cutoff = 0.01
params.max_noise_frag_ratio = 0.90
params.max_noise_rsd = 0.20
params.max_frag_reserved = 50
params.use_all_frag = 0



TOOL_FOLDER = "$baseDir/bin"

process performMsbuddy {
    publishDir "./nf_output", mode: 'copy'

    conda "$TOOL_FOLDER/conda_env.yml"

    input:
    file input 

    output:
    file 'python_output.tsv'

    """
    python $TOOL_FOLDER/python_script.py $input python_output.tsv
    """
}

workflow {
    data = Channel.fromPath(params.input_mgf)
    
    // Outputting Python
    processDataPython(data)

}