From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 16/19] csky: Device tree
Date: Mon, 19 Mar 2018 03:51:38 +0800
Message-ID: <b86f173b8333cb6cc1c7e32ec2ab1e38fae4ecf8.1521399976.git.ren_guo@c-sky.com>
References: <cover.1521399976.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1521399976.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1521399976.git.ren_guo@c-sky.com>
References: <cover.1521399976.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/boot/dts/gx6605s.dts         | 159 +++++++++++++++++++++++++++++++++
 arch/csky/boot/dts/include/dt-bindings |   1 +
 arch/csky/boot/dts/qemu.dts            |  87 ++++++++++++++++++
 3 files changed, 247 insertions(+)
 create mode 100644 arch/csky/boot/dts/gx6605s.dts
 create mode 120000 arch/csky/boot/dts/include/dt-bindings
 create mode 100644 arch/csky/boot/dts/qemu.dts

diff --git a/arch/csky/boot/dts/gx6605s.dts b/arch/csky/boot/dts/gx6605s.dts
new file mode 100644
index 0000000..0d34d22
--- /dev/null
+++ b/arch/csky/boot/dts/gx6605s.dts
@@ -0,0 +1,159 @@
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Nationalchip gx6605s ck610";
+	compatible = "nationalchip,gx6605s,ck610";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	memory {
+		device_type = "memory";
+		reg = <0x10000000 0x04000000>;
+	};
+
+	cpus {
+		#address-cells = <0>;
+		#size-cells = <0>;
+
+		cpu {
+			device_type = "cpu";
+			ccr	= <0x7d>;
+			hint	= <0x1c>;
+		};
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+
+		intc: interrupt-controller {
+			compatible = "nationalchip,intc-v1,ave";
+			reg = <0x00500000 0x400>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		timer0 {
+			compatible = "nationalchip,timer-v1";
+			reg = <0x0020a000 0x400>;
+			clock-frequency = <1000000>;
+			interrupts = <10>;
+			interrupt-parent = <&intc>;
+		};
+
+		ehci: ehci-hcd {
+			compatible = "generic-ehci";
+			reg = <0x00900000 0x400>;
+			interrupt-parent = <&intc>;
+			interrupts = <59>;
+		};
+
+		ohci0: ohci-hcd0 {
+			compatible = "generic-ohci";
+			reg = <0x00a00000 0x400>;
+			interrupt-parent = <&intc>;
+			interrupts = <58>;
+		};
+
+		ohci1: ohci-hcd1 {
+			compatible = "generic-ohci";
+			reg = <0x00b00000 0x400>;
+			interrupt-parent = <&intc>;
+			interrupts = <57>;
+		};
+
+		uart0: serial {
+			compatible = "ns16550a";
+			reg = <0x00403000 0x400>;
+			interrupt-parent = <&intc>;
+			interrupts = <15>;
+			clock-frequency = <29491200>;
+			baud = <115200>;
+			reg-shift = <2>;
+			reg-io-width = <1>;
+		};
+
+		gpio0: gpio {
+			compatible = "wd,mbl-gpio";
+			reg-names = "dirout", "dat", "set", "clr";
+			reg = <0x305000 4>, <0x305004 4>, <0x305008 4>, <0x30500c 4>;
+			bgpio-base = <0>;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		gpio_buttons {
+			compatible = "gpio-keys-polled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			poll-interval = <100>;
+			autorepeat;
+
+			button0 {
+				label = "button8";
+				linux,code = <KEY_LEFT>;
+				gpios = <&gpio0 8 GPIO_ACTIVE_LOW>;
+			};
+
+			button1 {
+				label = "button6";
+				linux,code = <KEY_RIGHT>;
+				gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
+			};
+
+			button2 {
+				label = "button5";
+				linux,code = <KEY_UP>;
+				gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
+			};
+
+			button3 {
+				label = "button9";
+				linux,code = <KEY_DOWN>;
+				gpios = <&gpio0 9 GPIO_ACTIVE_LOW>;
+			};
+
+			button4 {
+				label = "button7";
+				linux,code = <KEY_ENTER>;
+				gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
+			};
+		};
+
+		gpio_leds {
+			compatible = "gpio-leds";
+
+			led0 {
+				label = "led10";
+				gpios = <&gpio0 10 GPIO_ACTIVE_LOW>;
+				linux,default-trigger = "heartbeat";
+			};
+
+			led1 {
+				label = "led11";
+				gpios = <&gpio0 11 GPIO_ACTIVE_LOW>;
+				linux,default-trigger = "timer";
+			};
+
+			led2 {
+				label = "led12";
+				gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
+				linux,default-trigger = "default-on";
+			};
+
+			led3 {
+				label = "led13";
+				gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
+				linux,default-trigger = "default-on";
+			};
+		};
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 init=/sbin/init root=/dev/sda2 rw rootwait";
+	};
+};
diff --git a/arch/csky/boot/dts/include/dt-bindings b/arch/csky/boot/dts/include/dt-bindings
new file mode 120000
index 0000000..08c00e4
--- /dev/null
+++ b/arch/csky/boot/dts/include/dt-bindings
@@ -0,0 +1 @@
+../../../../../include/dt-bindings
\ No newline at end of file
diff --git a/arch/csky/boot/dts/qemu.dts b/arch/csky/boot/dts/qemu.dts
new file mode 100644
index 0000000..59e1c83
--- /dev/null
+++ b/arch/csky/boot/dts/qemu.dts
@@ -0,0 +1,87 @@
+/dts-v1/;
+
+/ {
+	model = "qemu.csky";
+	compatible = "csky";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x40000000>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+
+		intc: interrupt-controller {
+			compatible = "csky,intc-v1";
+			reg = <0xfffff000 0x1000>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		/* clockevent */
+		timer0 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0xffffd000 0x1000>;
+			clocks = <&dummy_apb>;
+			clock-names = "timer";
+			interrupts = <1>;
+			interrupt-parent = <&intc>;
+		};
+
+		/* clocksource */
+		timer1 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0xffffd014 0x800>;
+			clocks = <&dummy_apb>;
+			clock-names = "timer";
+			interrupts = <2>;
+			interrupt-parent = <&intc>;
+		};
+
+		serial0 {
+			compatible = "ns16550a";
+			reg = <0xffffe000 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <3>;
+			clocks = <&dummy_apb>;
+			baud = <115200>;
+			reg-shift = <2>;
+			reg-io-width = <1>;
+		};
+
+		dummy_apb: apb-clock {
+			compatible = "fixed-clock";
+			clock-frequency = <40000000>;
+			clock-output-names = "dummy_apb";
+			#clock-cells = <0>;
+		};
+
+		gmac: ethernet {
+			compatible = "snps,dwmac";
+			reg = <0xffffa000 0x2000>;
+			interrupt-parent = <&intc>;
+			interrupts = <4>;
+			interrupt-names = "macirq";
+			clocks = <&dummy_apb>;
+			clock-names = "stmmaceth";
+			phy-mode = "mii";
+			snps,pbl = <32>;
+			snps,fixed-burst;
+		};
+
+		qemu-exit {
+			compatible = "csky,qemu-exit";
+			reg = <0xffffc000 0x1000>;
+		};
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 rdinit=/sbin/init root=/dev/ram0";
+	};
+};
-- 
2.7.4
