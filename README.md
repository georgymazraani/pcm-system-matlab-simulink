# Pulse Code Modulation (PCM) System — MATLAB Simulink

A complete **Pulse Code Modulation (PCM)** communication system designed and simulated in **MATLAB Simulink**. The project demonstrates the full analog-to-digital and digital-to-analog signal chain: sampling, quantization, encoding, binary transmission, decoding, reconstruction, and performance analysis using **SQNR** and **BER vs SNR** metrics.

> **Academic context.** Coursework project for **ELEN 306 — Telecom Lab**, Faculty of Engineering, University of Balamand, Spring 2025–2026.
>
> **Team:** Marie Lyne Gerges · Georgy Mazraani · Anthony Gemayel
>

## Features

- Complete PCM transmitter and receiver implemented in MATLAB Simulink
- Analog sine-wave input generation
- Sample-and-hold stage controlled by a pulse generator
- Uniform quantization of sampled values
- Binary encoding using integer-to-bit conversion
- Receiver-side bit-to-integer conversion and uniform decoding
- Low-pass reconstruction filter to recover the analog waveform
- Scope-based waveform inspection at each stage of the PCM chain
- MATLAB-based **Signal-to-Quantization-Noise Ratio (SQNR)** calculation
- MATLAB-based **Bit Error Rate (BER) vs Signal-to-Noise Ratio (SNR)** analysis
- Comparison of signal quality for different quantization resolutions

## System Overview

Pulse Code Modulation converts an analog signal into digital form through three main transmitter-side stages:

1. **Sampling** — the continuous-time analog signal is sampled at regular intervals.
2. **Quantization** — each sample is approximated to the nearest discrete amplitude level.
3. **Encoding** — each quantized level is converted into a binary sequence.

At the receiver side, the reverse process is performed:

1. **Decoding** — the binary stream is converted back into numerical values.
2. **Digital-to-analog reconstruction** — the decoded signal is recovered as a staircase-like waveform.
3. **Low-pass filtering** — high-frequency components are removed to smooth the reconstructed signal.

The full system follows this signal flow:

```text
Analog Signal → Sampling → Quantization → Encoding → Transmission → Decoding → Reconstruction
```

## Simulink Architecture

The Simulink model contains both the PCM modulator and demodulator stages.

### Transmitter Side

| Stage | Main Block(s) | Purpose |
|---|---|---|
| Input generation | Sine Wave | Generates the analog test signal |
| Sampling | Sample and Hold, Pulse Generator | Converts the continuous signal into discrete-time samples |
| Quantization | Quantizer | Maps samples to discrete amplitude levels |
| Encoding | Uniform Encoder, Integer to Bit Converter | Converts quantized levels into a binary bitstream |

### Receiver Side

| Stage | Main Block(s) | Purpose |
|---|---|---|
| Decoding | Bit to Integer Converter | Converts binary data back into integer symbols |
| Signal recovery | Uniform Decoder | Reconstructs the quantized signal levels |
| Reconstruction | Low-Pass Filter / Transfer Function | Smooths the signal to approximate the original waveform |

## Waveform Analysis

The system was observed at multiple points using Simulink scopes:

| Signal | Description |
|---|---|
| Input analog signal | Original sinusoidal waveform before PCM processing |
| Sampled signal | Discrete-time version of the analog signal after sample-and-hold |
| Quantized signal | Staircase waveform caused by mapping samples to finite amplitude levels |
| Encoded signal | Binary bitstream representing the quantized samples |
| Reconstructed analog signal | Receiver output after decoding and low-pass filtering |
| Input vs reconstructed comparison | Shows how closely the recovered signal follows the original input |

The reconstructed waveform preserves the overall shape of the original sine wave, with small distortions caused mainly by quantization error.

## SQNR Analysis

The project evaluates signal quality using **Signal-to-Quantization-Noise Ratio (SQNR)**. SQNR compares the power of the sampled signal to the power of the quantization error.

The MATLAB script `SQNR.m` computes:

```text
error = sampled_signal - quantized_signal
SQNR = 10 log10(signal_power / noise_power)
```

For the 8-bit PCM system, the computed SQNR was approximately:

```text
SQNR ≈ 50.3938 dB
```

This confirms that higher quantization resolution reduces quantization noise and improves reconstruction quality.

### Effect of Quantization Levels

| Bits (N) | Quantization Levels (L) | Quantization Interval Δ | SQNR |
|---:|---:|---:|---:|
| 2 | 4 | 0.5 | 14.5904 dB |
| 4 | 16 | 0.125 | 25.8 dB |
| 6 | 64 | 0.03125 | 37.9 dB |
| 8 | 256 | 0.0078125 | 50.3938 dB |

As the number of bits increases, the number of quantization levels increases, the quantization interval decreases, and the reconstructed signal becomes more accurate.

## BER vs SNR Analysis

The script `SNR VS BER.m` evaluates the reliability of the digital bitstream by adding noise to the transmitted binary data and calculating the resulting **Bit Error Rate (BER)** for different SNR values.

The simulation uses:

```matlab
Nbits = 8;
Fs = 8000;
t = 0:1/Fs:0.05;
x = sin(2*pi*100*t);
SNR_dB = 0:2:20;
```

The generated BER curve shows that:

- BER is high when SNR is low.
- BER decreases as SNR increases.
- At higher SNR values, the digital communication link becomes more reliable.

This behavior matches the expected performance of digital transmission over a noisy channel.

## Repository Contents

Only the project source files are included in this repository. The lab report is not required to run the project.

```text
├── PCM Circuit.slx      # Simulink model of the complete PCM system
├── SQNR.m               # MATLAB script for SQNR calculation
├── SNR VS BER.m         # MATLAB script for BER vs SNR analysis
└── README.md            # Project documentation
```

## How to Run

### 1. Open the Simulink Model

Open MATLAB, then open:

```text
PCM Circuit.slx
```

Run the simulation from Simulink to observe the PCM system behavior through the connected scope blocks.

### 2. Run SQNR Analysis

After running the Simulink model, make sure the sampled and quantized signals are exported to the MATLAB workspace. Then run:

```matlab
SQNR
```

The script calculates the quantization error, signal power, noise power, and SQNR value.

### 3. Run BER vs SNR Analysis

Because the filename contains spaces, run it in MATLAB using:

```matlab
run('SNR VS BER.m')
```

This generates a semilog plot of BER versus SNR for the PCM bitstream.

## Key Results

- The PCM system successfully converts an analog sine wave into a digital bitstream and reconstructs it at the receiver.
- The sampled signal preserves the shape of the input waveform when the sampling rate satisfies the Nyquist criterion.
- Quantization introduces staircase distortion and quantization noise.
- 8-bit quantization provides 256 levels and achieves approximately **50.3938 dB SQNR**.
- Increasing the number of bits improves SQNR and reduces quantization error.
- BER decreases as SNR increases, confirming improved digital communication reliability under lower noise conditions.

## Advantages of PCM

- Stronger immunity to noise compared to analog transmission
- Suitable for digital processing, storage, and transmission
- Reliable reconstruction when sufficient quantization resolution is used
- Easy integration with modern digital communication systems

## Limitations

- Requires higher bandwidth than analog transmission
- Introduces quantization noise
- Higher bit depth improves quality but increases data rate and system complexity

## Authors

Developed by **Marie Lyne Gerges**, **Georgy Mazraani**, and **Anthony Gemayel** for **ELEN 306 — Telecom Lab** at the University of Balamand, Faculty of Engineering.

## License

This project can be released under the **MIT License** if all team members agree to open-source it.
