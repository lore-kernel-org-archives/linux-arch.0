From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v11 19/19] h8300: devicetree source
Date: Sat,  9 May 2015 00:04:39 +0900
Message-ID: <1431097479-21101-20-git-send-email-ysato@users.sourceforge.jp>
References: <1431097479-21101-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431097479-21101-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 Documentation/devicetree/bindings/h8300/cpu.txt    |  17 ++++
 .../interrupt-controller/renesas,h8300h-intc.txt   |  20 ++++
 .../interrupt-controller/renesas,h8s-intc.txt      |  20 ++++
 arch/h8300/boot/dts/Makefile                       |  11 +++
 arch/h8300/boot/dts/edosk2674.dts                  | 109 +++++++++++++++++++++
 arch/h8300/boot/dts/h8300h_sim.dts                 |  95 ++++++++++++++++++
 arch/h8300/boot/dts/h8s_sim.dts                    | 101 +++++++++++++++++++
 7 files changed, 373 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/h8300/cpu.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,h8300h-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,h8s-intc.txt
 create mode 100644 arch/h8300/boot/dts/Makefile
 create mode 100644 arch/h8300/boot/dts/edosk2674.dts
 create mode 100644 arch/h8300/boot/dts/h8300h_sim.dts
 create mode 100644 arch/h8300/boot/dts/h8s_sim.dts

diff --git a/Documentation/devicetree/bindings/h8300/cpu.txt b/Documentation/devicetree/bindings/h8300/cpu.txt
new file mode 100644
index 0000000..f1287e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/h8300/cpu.txt
@@ -0,0 +1,17 @@
+* H8/300 CPU bindings
+
+Required properties:
+
+- compatible: Compatible property value should be "renesas,h8300".
+- reg: Contains CPU index.
+- clock-frequency: Contains the clock frequency for CPU, in Hz.
+- renesas,bus-width: Contain the memory bus width.
+
+Example:
+
+		cpu@0 {
+			compatible = "renesas,h8300";
+			reg = <0>;
+			clock-frequency = <20000000>;
+			renesas,bus-width = <16>;
+		};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,h8300h-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,h8300h-intc.txt
new file mode 100644
index 0000000..79053dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,h8300h-intc.txt
@@ -0,0 +1,20 @@
+* H8/300H Interrupt controller
+
+Required properties:
+
+- compatible: has to be "renesas,h8300h-intc", "renesas,h8300-intc" as fallback.
+- #interrupt-cells: has to be <1>: an interrupt index and flags, as defined in
+  interrupts.txt in this directory
+
+Optional properties:
+
+- any properties, listed in interrupts.txt, and any standard resource allocation
+  properties
+
+Example:
+
+	h8intc: intc@0 {
+		compatible = "renesas,h8300h-intc", "renesas,h8300-intc";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+	};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,h8s-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,h8s-intc.txt
new file mode 100644
index 0000000..1206191
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,h8s-intc.txt
@@ -0,0 +1,20 @@
+* H8S Interrupt controller
+
+Required properties:
+
+- compatible: has to be "renesas,h8s-intc", "renesas,h8300-intc" as fallback.
+- #interrupt-cells: has to be <1>: an interrupt index and flags, as defined in
+  interrupts.txt in this directory
+
+Optional properties:
+
+- any properties, listed in interrupts.txt, and any standard resource allocation
+  properties
+
+Example:
+
+	h8intc: intc@0 {
+		compatible = "renesas,h8s-intc", "renesas,h8300-intc";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+	};
diff --git a/arch/h8300/boot/dts/Makefile b/arch/h8300/boot/dts/Makefile
new file mode 100644
index 0000000..bb123fa
--- /dev/null
+++ b/arch/h8300/boot/dts/Makefile
@@ -0,0 +1,11 @@
+ifneq '$(CONFIG_H8300_BUILTIN_DTB)' '""'
+BUILTIN_DTB := $(patsubst "%",%,$(CONFIG_H8300_BUILTIN_DTB)).dtb.o
+endif
+
+obj-y += $(BUILTIN_DTB)
+
+dtb-$(CONFIG_H8300H_SIM) := h8300h_sim.dtb
+dtb-$(CONFIG_H8S_SIM) := h8s_sim.dtb
+dtb-$(CONFIG_EDOSK2674) := edosk2674.dtb
+
+clean-files := *.dtb.S
diff --git a/arch/h8300/boot/dts/edosk2674.dts b/arch/h8300/boot/dts/edosk2674.dts
new file mode 100644
index 0000000..60e73b9
--- /dev/null
+++ b/arch/h8300/boot/dts/edosk2674.dts
@@ -0,0 +1,109 @@
+#include <dt-bindings/clock/renesas,8bit-timer.h>
+
+/dts-v1/;
+/ {
+	compatible = "renesas,edosk2674";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&h8intc>;
+
+	chosen {
+		bootargs = "console=ttySC2,38400";
+	};
+	aliases {
+		serial0 = &sci0;
+		serial1 = &sci1;
+		serial2 = &sci2;
+	};
+
+	clocks {
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		xclk: oscillator {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <33333333>;
+			clock-output-names = "xtal";
+		};
+		pllclk: pllclk {
+			compatible = "renesas,h8s2678-pll-clock";
+			clocks = <&xclk>;
+			#clock-cells = <0>;
+			reg = <0xfee03b 2>, <0xfee045 2>;
+		};
+		cclk: cclk {
+			compatible = "renesas,h8300-div-clock";
+			clocks = <&pllclk>;
+			#clock-cells = <0>;
+			reg = <0xfee03b 2>;
+			renesas,width = <3>;
+		};
+		fclk: fclk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cclk>;
+			#clock-cells = <0>;
+			clock-div = <1>;
+			clock-mult = <1>;
+		};
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x400000 0x800000>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu@0 {
+			compatible = "renesas,h8300";
+			reg = <0>;
+			renesas,bus-width = <16>;
+			clock-frequency = <33333333>;
+			bus-width = <16>;
+		};
+	};
+
+	h8intc: interrupt-controller@0 {
+		compatible = "renesas,h8s-intc", "renesas,h8300-intc";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+	};
+	tpu: timer@ffffe0 {
+		compatible = "renesas,tpu";
+		reg = <0xffffe0 16>, <0xfffff0 12>;
+		clocks = <&fclk>;
+		clock-names = "fck";
+	};
+
+	timer8: timer@ffffb0 {
+		compatible = "renesas,8bit-timer";
+		reg = <0xffff80 10>;
+		interrupts = <72 75>;
+		clocks = <&fclk>;
+		clock-names = "fck";
+	};
+
+	sci0: serial@ffff78 {
+		compatible = "renesas,sci";
+		reg = <0xffff78 8>;
+		interrupts = <88 89 90 91>;
+		clocks = <&fclk>;
+		clock-names = "sci_ick";
+	};
+	sci1: serial@ffff80 {
+		compatible = "renesas,sci";
+		reg = <0xffff80 8>;
+		interrupts = <92 93 94 95>;
+		clocks = <&fclk>;
+		clock-names = "sci_ick";
+	};
+	sci2: serial@ffff88 {
+		compatible = "renesas,sci";
+		reg = <0xffff88 8>;
+		interrupts = <96 97 98 99>;
+		clocks = <&fclk>;
+		clock-names = "sci_ick";
+	};
+};
diff --git a/arch/h8300/boot/dts/h8300h_sim.dts b/arch/h8300/boot/dts/h8300h_sim.dts
new file mode 100644
index 0000000..08c3e35
--- /dev/null
+++ b/arch/h8300/boot/dts/h8300h_sim.dts
@@ -0,0 +1,95 @@
+#include <dt-bindings/clock/renesas,8bit-timer.h>
+
+/dts-v1/;
+/ {
+	compatible = "gnu,gdbsim";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&h8intc>;
+
+	chosen {
+		bootargs = "console=ttySC0";
+	};
+	aliases {
+		serial0 = &sci0;
+		serial1 = &sci1;
+	};
+
+	clocks {
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		xclk: oscillator {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <20000000>;
+			clock-output-names = "xtal";
+		};
+		cclk: cclk {
+			compatible = "renesas,h8300-div-clock";
+			clocks = <&xclk>;
+			#clock-cells = <0>;
+			reg = <0xfee01b 2>;
+			renesas,width = <2>;
+		};
+		fclk: fclk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cclk>;
+			#clock-cells = <0>;
+			clock-div = <1>;
+			clock-mult = <1>;
+		};
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x400000 0x400000>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu@0 {
+			compatible = "renesas,h8300";
+			reg = <0>;
+			clock-frequency = <20000000>;
+			renesas,bus-width = <16>;
+		};
+	};
+
+	h8intc: interrupt-controller@0 {
+		compatible = "renesas,h8300h-intc", "renesas,h8300-intc";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+	};
+	timer8: timer@ffff80 {
+		compatible = "renesas,8bit-timer";
+		reg = <0xffff80 10>;
+		interrupts = <36>;
+		clocks = <&fclk>;
+		clock-names = "fck";
+	};
+	timer16: timer@ffff68 {
+		compatible = "renesas,16bit-timer";
+		reg = <0xffff68 8>, <0xffff60 8>;
+		interrupts = <24>;
+		renesas,channel = <0>;
+		clocks = <&fclk>;
+		clock-names = "fck";
+	};
+
+	sci0: serial@ffffb0 {
+		compatible = "renesas,sci";
+		reg = <0xffffb0 8>;
+		interrupts = <52 53 54 55>;
+		clocks = <&fclk>;
+		clock-names = "sci_ick";
+	};
+	sci1: serial@ffffb8 {
+		compatible = "renesas,sci";
+		reg = <0xffffb8 8>;
+		interrupts = <56 57 58 59>;
+		clocks = <&fclk>;
+		clock-names = "sci_ick";
+	};
+};
diff --git a/arch/h8300/boot/dts/h8s_sim.dts b/arch/h8300/boot/dts/h8s_sim.dts
new file mode 100644
index 0000000..4f93eb6
--- /dev/null
+++ b/arch/h8300/boot/dts/h8s_sim.dts
@@ -0,0 +1,101 @@
+#include <dt-bindings/clock/renesas,8bit-timer.h>
+
+/dts-v1/;
+/ {
+	compatible = "gnu,gdbsim";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&h8intc>;
+
+	chosen {
+		bootargs = "earlyprintk=h8300-sim console=ttySC0";
+	};
+	aliases {
+		serial0 = &sci0;
+		serial1 = &sci1;
+	};
+
+	clocks {
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		xclk: oscillator {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <33333333>;
+			clock-output-names = "xtal";
+		};
+		pllclk: pllclk {
+			compatible = "renesas,h8s2678-pll-clock";
+			clocks = <&xclk>;
+			#clock-cells = <0>;
+			reg = <0xfee03b 2>, <0xfee045 2>;
+		};
+		cclk: cclk {
+			compatible = "renesas,h8300-div-clock";
+			clocks = <&pllclk>;
+			#clock-cells = <0>;
+			reg = <0xfee03b 2>;
+			renesas,width = <3>;
+		};
+		fclk: fclk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cclk>;
+			#clock-cells = <0>;
+			clock-div = <1>;
+			clock-mult = <1>;
+		};
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x400000 0x800000>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu@0 {
+			compatible = "renesas,h8300";
+			reg = <0>;
+			renesas,bus-width = <16>;
+			clock-frequency = <33333333>;
+			bus-width = <16>;
+		};
+	};
+
+	h8intc: interrupt_controler@0 {
+		compatible = "renesas,h8s-intc", "renesas,h8300-intc";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+	};
+	tpu: timer@ffffe0 {
+		compatible = "renesas,tpu";
+		reg = <0xffffe0 16>, <0xfffff0 12>;
+		clocks = <&fclk>;
+		clock-names = "fck";
+	};
+
+	timer8: timer@ffffb0 {
+		compatible = "renesas,8bit-timer";
+		reg = <0xffff80 10>;
+		interrupts = <72 75>;
+		clocks = <&fclk>;
+		clock-names = "fck";
+	};
+
+	sci0: serial@ffff78 {
+		compatible = "renesas,sci";
+		reg = <0xffff78 8>;
+		interrupts = <88 89 90 91>;
+		clocks = <&fclk>;
+		clock-names = "sci_ick";
+	};
+	sci1: serial@ffff80 {
+		compatible = "renesas,sci";
+		reg = <0xffff80 8>;
+		interrupts = <92 93 94 95>;
+		clocks = <&fclk>;
+		clock-names = "sci_ick";
+	};
+};
-- 
2.1.4
