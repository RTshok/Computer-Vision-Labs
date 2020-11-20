import numpy as np
import scipy.ndimage.filters as filters

def adpmedian(image, maxSize = 7):
	'''Perform adaptive median filtering
	   image - image to process
	   maxSize - maximum filter size
	'''
	if (maxSize < 3):
		maxSize = 3
	
	f = np.copy(image)
	alreadyProcessed = np.zeros(image.shape, 'bool')
	for s in range(3, maxSize, 2):
		z_min = filters.minimum_filter(image, size = (s, s))
		z_med = filters.median_filter(image, size = (s, s))
		z_max = filters.minimum_filter(image, size = (s, s))
		
		levelB = np.logical_and(np.logical_and((z_min < z_med), (z_med < z_max)),
		                        np.logical_not(alreadyProcessed))
		zB = np.logical_and((image > z_min), (z_max > image))
		outZxy  = np.logical_and(levelB, zB)					# Output as is
		outZmed = np.logical_and(levelB, np.logical_not(zB))	# Output median
		
		f[outZxy]  = image[outZxy]
		f[outZmed] = image[outZmed]
		
		alreadyProcessed = np.logical_or(alreadyProcessed, levelB)
		
	f[np.logical_not(alreadyProcessed)] = z_med[np.logical_not(alreadyProcessed)];

	return f