import numpy as np
import sounddevice as sd
import time

def generate_harmonic_wave(frequency, duration, sample_rate=44100, harmonics=[1, 0.5, 0.3, 0.2]):
    t = np.linspace(0, duration, int(sample_rate * duration), endpoint=False)
    wave = sum(amplitude * np.sin(2 * np.pi * frequency * (i + 1) * t) for i, amplitude in enumerate(harmonics))
    return wave

# Tần số của các nốt nhạc
notes = {
    'C': 261.63,
    'D': 293.66,
    'E': 329.63,
    'F': 349.23,
    'G': 392.00,
    'A': 440.00,
    'B': 493.88
}

# Giai điệu của bài "Happy Birthday"
melody = [
    ('G', 0.5), ('G', 0.5), ('A', 1), ('G', 1), ('C', 1), ('B', 2), # "Happy Birthday to You"
    ('G', 0.5), ('G', 0.5), ('A', 1), ('G', 1), ('D', 1), ('C', 2), # "Happy Birthday to You"
    ('G', 0.5), ('G', 0.5), ('G', 1), ('E', 1), ('C', 1), ('B', 1), ('A', 2), # "Happy Birthday Dear [Name]"
    ('F', 0.5), ('F', 0.5), ('E', 1), ('C', 1), ('D', 1), ('C', 2) # "Happy Birthday to You"
]

# Phát giai điệu
sample_rate = 44100
for note, duration in melody:
    frequency = notes[note]
    wave = generate_harmonic_wave(frequency, duration)
    sd.play(wave, samplerate=sample_rate)
    sd.wait()  # Đợi cho âm thanh hiện tại kết thúc
    time.sleep(0.1)  # Khoảng nghỉ giữa các nốt
