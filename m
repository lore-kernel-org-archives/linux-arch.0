From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v7 27/37] nds32: Device tree support
Date: Tue, 13 Feb 2018 17:09:31 +0800
Message-ID: <a9e28f586833d476a05d4f5258b6db6b8acc639f.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

This patch adds support for device tree.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/nds32/boot/dts/Makefile  |  8 ++++
 arch/nds32/boot/dts/ae3xx.dts | 85 +++++++++++++++++++++++++++++++++++++++++++
 arch/nds32/kernel/devtree.c   | 19 ++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 arch/nds32/boot/dts/Makefile
 create mode 100644 arch/nds32/boot/dts/ae3xx.dts
 create mode 100644 arch/nds32/kernel/devtree.c

diff --git a/arch/nds32/boot/dts/Makefile b/arch/nds32/boot/dts/Makefile
new file mode 100644
index 000000000000..d31faa8a1d50
--- /dev/null
+++ b/arch/nds32/boot/dts/Makefile
@@ -0,0 +1,8 @@
+ifneq '$(CONFIG_NDS32_BUILTIN_DTB)' '""'
+BUILTIN_DTB := $(patsubst "%",%,$(CONFIG_NDS32_BUILTIN_DTB)).dtb.o
+else
+BUILTIN_DTB :=
+endif
+obj-$(CONFIG_OF) += $(BUILTIN_DTB)
+
+clean-files := *.dtb *.dtb.S
diff --git a/arch/nds32/boot/dts/ae3xx.dts b/arch/nds32/boot/dts/ae3xx.dts
new file mode 100644
index 000000000000..bb39749a6673
--- /dev/null
+++ b/arch/nds32/boot/dts/ae3xx.dts
@@ -0,0 +1,85 @@
+/dts-v1/;
+/ {
+	compatible = "andestech,ae3xx";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&intc>;
+
+	chosen {
+		stdout-path = &serial0;
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x40000000>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "andestech,n13", "andestech,nds32v3";
+			reg = <0>;
+			clock-frequency = <60000000>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	intc: interrupt-controller {
+		compatible = "andestech,ativic32";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+	};
+
+	clock: clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <30000000>;
+	};
+
+	apb {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		serial0: serial@f0300000 {
+			compatible = "andestech,uart16550", "ns16550a";
+			reg = <0xf0300000 0x1000>;
+			interrupts = <8>;
+			clock-frequency = <14745600>;
+			reg-shift = <2>;
+			reg-offset = <32>;
+			no-loopback-test = <1>;
+		};
+
+		timer0: timer@f0400000 {
+			compatible = "andestech,atcpit100";
+			reg = <0xf0400000 0x1000>;
+			interrupts = <2>;
+			clocks = <&clock>;
+			clock-names = "PCLK";
+		};
+	};
+
+	ahb {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		L2: cache-controller@e0500000 {
+			compatible = "andestech,atl2c";
+			reg = <0xe0500000 0x1000>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		mac0: ethernet@e0100000 {
+			compatible = "andestech,atmac100";
+			reg = <0xe0100000 0x1000>;
+			interrupts = <18>;
+		};
+	};
+};
diff --git a/arch/nds32/kernel/devtree.c b/arch/nds32/kernel/devtree.c
new file mode 100644
index 000000000000..bdce0fe5af9f
--- /dev/null
+++ b/arch/nds32/kernel/devtree.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/bug.h>
+#include <linux/printk.h>
+#include <linux/of_fdt.h>
+
+void __init early_init_devtree(void *params)
+{
+	if (!params || !early_init_dt_scan(params)) {
+		pr_crit("\n"
+			"Error: invalid device tree blob at (virtual address 0x%p)\n"
+			"\nPlease check your bootloader.", params);
+
+		BUG_ON(1);
+	}
+
+	dump_stack_set_arch_desc("%s (DT)", of_flat_dt_get_machine_name());
+}
-- 
2.16.1
