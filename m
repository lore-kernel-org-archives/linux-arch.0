From: Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>
Subject: [PATCH v12 21/21] h8300: devicetree source
Date: Mon, 11 May 2015 15:26:40 +0900
Message-ID: <1431325600-12333-22-git-send-email-ysato@users.sourceforge.jp>
References: <1431325600-12333-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431325600-12333-1-git-send-email-ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

- h8300h_sim: GDB H8/300H simulator
- h8s_sim: GDB H8S simulator
- edosk2674: Renesas EDOSK2674R Evalution board

Signed-off-by: Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>
---
 arch/h8300/boot/dts/Makefile       |  11 ++++
 arch/h8300/boot/dts/edosk2674.dts  | 107 +++++++++++++++++++++++++++++++++++++
 arch/h8300/boot/dts/h8300h_sim.dts |  96 +++++++++++++++++++++++++++++++++
 arch/h8300/boot/dts/h8s_sim.dts    |  99 ++++++++++++++++++++++++++++++++++
 4 files changed, 313 insertions(+)
 create mode 100644 arch/h8300/boot/dts/Makefile
 create mode 100644 arch/h8300/boot/dts/edosk2674.dts
 create mode 100644 arch/h8300/boot/dts/h8300h_sim.dts
 create mode 100644 arch/h8300/boot/dts/h8s_sim.dts

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
index 0000000..dfb5c10
--- /dev/null
+++ b/arch/h8300/boot/dts/edosk2674.dts
@@ -0,0 +1,107 @@
+/dts-v1/;
+/ {
+	compatible = "renesas,edosk2674";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&h8intc>;
+
+	chosen {
+		bootargs = "console=ttySC2,38400";
+		stdout-path = <&sci2>;
+	};
+	aliases {
+		serial0 = &sci0;
+		serial1 = &sci1;
+		serial2 = &sci2;
+	};
+
+	xclk: oscillator {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <33333333>;
+		clock-output-names = "xtal";
+	};
+	pllclk: pllclk {
+		compatible = "renesas,h8s2678-pll-clock";
+		clocks = <&xclk>;
+		#clock-cells = <0>;
+		reg = <0xfee03b 2>, <0xfee045 2>;
+	};
+	core_clk: core_clk {
+		compatible = "renesas,h8300-div-clock";
+		clocks = <&pllclk>;
+		#clock-cells = <0>;
+		reg = <0xfee03b 2>;
+		renesas,width = <3>;
+	};
+	fclk: fclk {
+		compatible = "fixed-factor-clock";
+		clocks = <&core_clk>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+	};
+
+	memory@400000 {
+		device_type = "memory";
+		reg = <0x400000 0x800000>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu@0 {
+			compatible = "renesas,h8300";
+			clock-frequency = <33333333>;
+		};
+	};
+
+	h8intc: interrupt-controller@fffe00 {
+		compatible = "renesas,h8s-intc", "renesas,h8300-intc";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0xfffe00 24>;
+	};
+
+	bsc: memory-controller@fffec0 {
+		compatible = "renesas,h8s-bsc", "renesas,h8300-bsc";
+		reg = <0xfffec0 24>;
+	};
+
+	tpu: timer@ffffe0 {
+		compatible = "renesas,tpu";
+		reg = <0xffffe0 16>, <0xfffff0 12>;
+		clocks = <&fclk>;
+		clock-names = "fck";
+	};
+
+	timer8: timer@ffffb0 {
+		compatible = "renesas,8bit-timer";
+		reg = <0xffffb0 10>;
+		interrupts = <72 0>;
+		clocks = <&fclk>;
+		clock-names = "fck";
+	};
+
+	sci0: serial@ffff78 {
+		compatible = "renesas,sci";
+		reg = <0xffff78 8>;
+		interrupts = <88 0>, <89 0>, <90 0>, <91 0>;
+		clocks = <&fclk>;
+		clock-names = "sci_ick";
+	};
+	sci1: serial@ffff80 {
+		compatible = "renesas,sci";
+		reg = <0xffff80 8>;
+		interrupts = <92 0>, <93 0>, <94 0>, <95 0>;
+		clocks = <&fclk>;
+		clock-names = "sci_ick";
+	};
+	sci2: serial@ffff88 {
+		compatible = "renesas,sci";
+		reg = <0xffff88 8>;
+		interrupts = <96 0>, <97 0>, <98 0>, <99 0>;
+		clocks = <&fclk>;
+		clock-names = "sci_ick";
+	};
+};
diff --git a/arch/h8300/boot/dts/h8300h_sim.dts b/arch/h8300/boot/dts/h8300h_sim.dts
new file mode 100644
index 0000000..545bfb5
--- /dev/null
+++ b/arch/h8300/boot/dts/h8300h_sim.dts
@@ -0,0 +1,96 @@
+/dts-v1/;
+/ {
+	compatible = "gnu,gdbsim";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&h8intc>;
+
+	chosen {
+		bootargs = "earlyprintk=h8300-sim";
+		stdout-path = <&sci0>;
+	};
+	aliases {
+		serial0 = &sci0;
+		serial1 = &sci1;
+	};
+
+	xclk: oscillator {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <20000000>;
+		clock-output-names = "xtal";
+	};
+	core_clk: core_clk {
+		compatible = "renesas,h8300-div-clock";
+		clocks = <&xclk>;
+		#clock-cells = <0>;
+		reg = <0xfee01b 2>;
+		renesas,width = <2>;
+	};
+	fclk: fclk {
+		compatible = "fixed-factor-clock";
+		clocks = <&core_clk>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+	};
+
+	memory@400000 {
+		device_type = "memory";
+		reg = <0x400000 0x400000>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu@0 {
+			compatible = "renesas,h8300";
+			clock-frequency = <20000000>;
+		};
+	};
+
+	h8intc: interrupt-controller@fee012 {
+		compatible = "renesas,h8300h-intc", "renesas,h8300-intc";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0xfee012 7>;
+	};
+
+	bsc: memory-controller@fee01e {
+		compatible = "renesas,h8300h-bsc", "renesas,h8300-bsc";
+		reg = <0xfee01e 8>;
+	};
+
+	timer8: timer@ffff80 {
+		compatible = "renesas,8bit-timer";
+		reg = <0xffff80 10>;
+		interrupts = <36 0>;
+		clocks = <&fclk>;
+		clock-names = "fck";
+	};
+
+	timer16: timer@ffff68 {
+		compatible = "renesas,16bit-timer";
+		reg = <0xffff68 8>, <0xffff60 8>;
+		interrupts = <24 0>;
+		renesas,channel = <0>;
+		clocks = <&fclk>;
+		clock-names = "fck";
+	};
+
+	sci0: serial@ffffb0 {
+		compatible = "renesas,sci";
+		reg = <0xffffb0 8>;
+		interrupts = <52 0>, <53 0>, <54 0>, <55 0>;
+		clocks = <&fclk>;
+		clock-names = "sci_ick";
+	};
+
+	sci1: serial@ffffb8 {
+		compatible = "renesas,sci";
+		reg = <0xffffb8 8>;
+		interrupts = <56 0>, <57 0>, <58 0>, <59 0>;
+		clocks = <&fclk>;
+		clock-names = "sci_ick";
+	};
+};
diff --git a/arch/h8300/boot/dts/h8s_sim.dts b/arch/h8300/boot/dts/h8s_sim.dts
new file mode 100644
index 0000000..bcedba5
--- /dev/null
+++ b/arch/h8300/boot/dts/h8s_sim.dts
@@ -0,0 +1,99 @@
+/dts-v1/;
+/ {
+	compatible = "gnu,gdbsim";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&h8intc>;
+
+	chosen {
+		bootargs = "earlyprintk=h8300-sim";
+		stdout-path = <&sci0>;
+	};
+	aliases {
+		serial0 = &sci0;
+		serial1 = &sci1;
+	};
+
+	xclk: oscillator {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <33333333>;
+		clock-output-names = "xtal";
+	};
+	pllclk: pllclk {
+		compatible = "renesas,h8s2678-pll-clock";
+		clocks = <&xclk>;
+		#clock-cells = <0>;
+		reg = <0xfee03b 2>, <0xfee045 2>;
+	};
+	core_clk: core_clk {
+		compatible = "renesas,h8300-div-clock";
+		clocks = <&pllclk>;
+		#clock-cells = <0>;
+		reg = <0xfee03b 2>;
+		renesas,width = <3>;
+	};
+	fclk: fclk {
+		compatible = "fixed-factor-clock";
+		clocks = <&core_clk>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+	};
+
+	memory@400000 {
+		device_type = "memory";
+		reg = <0x400000 0x800000>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu@0 {
+			compatible = "renesas,h8300";
+			clock-frequency = <33333333>;
+		};
+	};
+
+	h8intc: interrupt-controller@fffe00 {
+		compatible = "renesas,h8s-intc", "renesas,h8300-intc";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0xfffe00 24>;
+	};
+
+	bsc: memory-controller@fffec0 {
+		compatible = "renesas,h8s-bsc", "renesas,h8300-bsc";
+		reg = <0xfffec0 24>;
+	};
+
+	tpu: timer@ffffe0 {
+		compatible = "renesas,tpu";
+		reg = <0xffffe0 16>, <0xfffff0 12>;
+		clocks = <&fclk>;
+		clock-names = "fck";
+	};
+
+	timer8: timer@ffffb0 {
+		compatible = "renesas,8bit-timer";
+		reg = <0xffffb0 10>;
+		interrupts = <72 0>;
+		clocks = <&fclk>;
+		clock-names = "fck";
+	};
+
+	sci0: serial@ffff78 {
+		compatible = "renesas,sci";
+		reg = <0xffff78 8>;
+		interrupts = <88 0>, <89 0>, <90 0>, <91 0>;
+		clocks = <&fclk>;
+		clock-names = "sci_ick";
+	};
+	sci1: serial@ffff80 {
+		compatible = "renesas,sci";
+		reg = <0xffff80 8>;
+		interrupts = <92 0>, <93 0>, <94 0>, <95 0>;
+		clocks = <&fclk>;
+		clock-names = "sci_ick";
+	};
+};
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
