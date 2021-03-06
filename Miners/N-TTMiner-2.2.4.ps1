
$M = @{
    Path       = "TT-Miner.exe"
    Uri        = "https://tradeproject.de/download/Miner/TT-Miner-2.2.4.zip"
    SHA256     = "0AE33562BCE63901A56C759E87AC356C3B10CDC7208269C58D7ED63D3D2D10E3"
    Type       = "NVIDIA"
    Arguments  = @(
        "-o #Protocol#://#Server#:#Port#"
        "-u #Login#"
        "-p #Password#"
        "-worker #WorkerName#"
        "--nvidia"
        "-nui"
        "-d #Devices#"
        "-b 127.0.0.1:#APIPort#"
        "#CustomParameters#"
    )
    API        = "Claymore"
    Fee        = 0.01
    Algorithms = [PSCustomObject]@{
        Ethash     = @{
            Params = "-a ETHASH"
            Mem    = 3
        }
        # Lyra2v3  = "-a LYRA2V3"
        MTP        = @{
            Params = "-a MTP"
            Mem    = 4.5
        }
        ProgPOW    = "-a PROGPOW"
        ProgPOWZ   = "-a PROGPOWZ"
        ProgPOWH   = "-a PROGPOWH"
        ProgPOW092 = "-a PROGPOW092"
        Tethash    = "-a TETHASHV1"
        Ubqhash    = @{
            Params = "-a UBQHASH"
            Mem    = 3
        }
    }
}

if ($SystemInfo.CudaVersion -ge [version]"10.1") {
    $M.Arguments += "#AlgorithmParameters#-101"
    $M.CUDA = 10.1
} elseif ($SystemInfo.CudaVersion -ge [version]"10.0") {
    $M.Arguments += "#AlgorithmParameters#-100"
    $M.CUDA = 10.0
} elseif ($SystemInfo.CudaVersion -ge [version]"9.2") {
    $M.Arguments += "#AlgorithmParameters#-92"
    $M.CUDA = 9.2
} else {
    return
}

return [PSCustomObject]$M
