import subprocess

benchmarks_to_take = [
            "dft-data-bench",
            "dft-control-bench",
            "fft-data-bench",
            "fft-control-bench"
        ]

cores_to_test = [4, 8, 16, 32]

for bench in benchmarks_to_take:
    for cores in cores_to_test:
        subprocess.run(["./" + bench, "--csv", bench + ".csv", "+RTS", "-N" + str(cores), "-H100M", "-A50M", "-K0M")])
