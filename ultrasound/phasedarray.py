#%%
import numpy as np
import math
import matplotlib.pyplot as plt
def ultrasound(delay): #delay time in us
    # Wavelength
    l = 8.5
    # Transmitters Interval
    d =9.8
    # Number of Transmitters
    no_elements = 4

    # Sample points
    theta = np.array([[math.pi*i/180 for i in range(0, 360)]])
    n = np.array(range(1, no_elements+1)).reshape(no_elements, 1)
    print("number is ",n)

    # Phase shift
    
    phaseshift = delay*10**-6*2*4*10**4*math.pi  #radian
    # a = (phaseshift*l)/(2*math.pi*d)
    # print(a)
    angle = math.asin((phaseshift*l)/(2*math.pi*d))*180/math.pi
    print(angle)
    # Phased Array Equation
    A = (n-1)*(1j*(2*math.pi*d*np.cos(theta)/l + phaseshift))
    X = np.exp(-A)
    w = np.mat(np.ones(no_elements).reshape(1, no_elements))
    r = w*X
    r = np.array(np.abs(r)).reshape(-1)

    return r

theta = np.array([[math.pi*i/180 for i in range(0, 360)]])
# r0 = ultrasound(0)


fig, ax = plt.subplots(subplot_kw={'projection': 'polar'})
# ax.plot(theta.reshape(360), np.abs(r0).reshape(360),label = "0°")

# ax.grid(True)
# ax.legend(loc = 'best')
# ax.set_title("Gain of a Uniform Linear Array", va='bottom')
# plt.show()

r1 = ultrasound(-1)
r2 = ultrasound(-2)
r3 = ultrasound(-3)
r4 = ultrasound(-4)
r5 = ultrasound(-5)
r6 = ultrasound(-6)
r7 = ultrasound(-7)
r8 = ultrasound(-8)
r9 = ultrasound(-9)
# r10 = ultrasound(-12)
# r11 = ultrasound(-15)
# r12 = ultrasound(-18)
ax.plot(theta.reshape(360), np.abs(r1).reshape(360),"k",label = "0°")
ax.plot(theta.reshape(360), np.abs(r2).reshape(360),"b",label = "4°")
ax.plot(theta.reshape(360), np.abs(r3).reshape(360),"r",label = "5.5°")
ax.plot(theta.reshape(360), np.abs(r4).reshape(360),"m",label = "7°")
ax.plot(theta.reshape(360), np.abs(r5).reshape(360),"c",label = "10°")
ax.plot(theta.reshape(360), np.abs(r6).reshape(360),"y",label = "12°")
ax.plot(theta.reshape(360), np.abs(r7).reshape(360),"k",label = "14°")
ax.plot(theta.reshape(360), np.abs(r8).reshape(360),"b",label = "16°")
ax.plot(theta.reshape(360), np.abs(r9).reshape(360),"r",label = "18°")
# ax.plot(theta.reshape(360), np.abs(r10).reshape(360),"m",label = "24°")
# ax.plot(theta.reshape(360), np.abs(r11).reshape(360),"c",label = "31°")
# ax.plot(theta.reshape(360), np.abs(r12).reshape(360),"y",label = "37°")

ax.grid(True)
ax.legend(loc = 'best')
ax.set_title("Gain of a Uniform Linear Array", va='bottom')
plt.show()
