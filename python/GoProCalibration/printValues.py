import numpy as np

# Load Calibration Coefficients
print('Loading data files')
npz_calib_file = np.load('calibration_data.npz')
distCoeff = npz_calib_file['distCoeff']
intrinsic_matrix = npz_calib_file['intrinsic_matrix']
npz_calib_file.close()
print('Finished loading files')
print(' ')

print("Intrinsic Matrix: ")
print(str(intrinsic_matrix))
print()

print("Dist Coeff: ")
print(str(distCoeff))
print()
