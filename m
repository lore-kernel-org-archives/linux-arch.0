From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v2 22/35] nds32: Device tree support
Date: Mon, 27 Nov 2017 20:28:09 +0800
Message-ID: <1055af0e8b98571b4461d6f899d043fe7f17408b.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime@andestech.com>

This patch adds support for device tree.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/boot/dts/Makefile   |    8 ++++++
 arch/nds32/boot/dts/ae3xx.dts  |   55 ++++++++++++++++++++++++++++++++++++
 arch/nds32/boot/dts/ag101p.dts |   60 ++++++++++++++++++++++++++++++++++++++++
 arch/nds32/kernel/devtree.c    |   45 ++++++++++++++++++++++++++++++
 4 files changed, 168 insertions(+)
 create mode 100644 arch/nds32/boot/dts/Makefile
 create mode 100644 arch/nds32/boot/dts/ae3xx.dts
 create mode 100644 arch/nds32/boot/dts/ag101p.dts
 create mode 100644 arch/nds32/kernel/devtree.c

diff --git a/arch/nds32/boot/dts/Makefile b/arch/nds32/boot/dts/Makefile
new file mode 100644
index 0000000..d31faa8
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
index 0000000..4181060
--- /dev/null
+++ b/arch/nds32/boot/dts/ae3xx.dts
@@ -0,0 +1,55 @@
+/dts-v1/;
+/ {
+	compatible = "nds32 ae3xx";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&intc>;
+
+	chosen {
+		bootargs = "earlycon console=ttyS0,38400n8 debug loglevel=7";
+		stdout-path = &serial0;
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x40000000>;
+	};
+
+	cpu {
+		device_type = "cpu";
+		compatible = "andestech,n13", "andestech,nds32v3";
+		clock-frequency = <60000000>;
+	};
+
+	intc: interrupt-controller {
+		compatible = "andestech,ativic32";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+	};
+
+	serial0: serial@f0300000 {
+		compatible = "andestech,uart16550", "ns16550a";
+		reg = <0xf0300000 0x1000>;
+		interrupts = <8>;
+		clock-frequency = <14745600>;
+		reg-shift = <2>;
+		reg-offset = <32>;
+		no-loopback-test = <1>;
+	};
+
+	timer0: timer@f0400000 {
+		compatible = "andestech,atcpit100";
+		reg = <0xf0400000 0x1000>;
+		interrupts = <2>;
+		clock-frequency = <30000000>;
+		cycle-count-offset = <0x38>;
+		cycle-count-down;
+	};
+
+	mac0: mac@e0100000 {
+		compatible = "andestech,atmac100";
+		reg = <0xe0100000 0x1000>;
+		interrupts = <18>;
+	};
+
+};
diff --git a/arch/nds32/boot/dts/ag101p.dts b/arch/nds32/boot/dts/ag101p.dts
new file mode 100644
index 0000000..f1cb540
--- /dev/null
+++ b/arch/nds32/boot/dts/ag101p.dts
@@ -0,0 +1,60 @@
+/dts-v1/;
+/ {
+	compatible = "nds32 ag101p";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&intc>;
+
+	chosen {
+		bootargs = "earlycon console=ttyS0,38400n8 debug loglevel=7";
+		stdout-path = &serial0;
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x40000000>;
+	};
+
+	cpu@0 {
+		device_type = "cpu";
+		compatible = "andestech,n13";
+		clock-frequency = <60000000>;
+		next-level-cache = <&L2>;
+	};
+
+	intc: interrupt-controller {
+		compatible = "andestech,ativic32";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+	};
+
+	serial0: serial@99600000 {
+		compatible = "andestech,uart16550", "ns16550a";
+		reg = <0x99600000 0x1000>;
+		interrupts = <7 4>;
+		clock-frequency = <14745600>;
+		reg-shift = <2>;
+		no-loopback-test = <1>;
+	};
+
+	timer0: timer@98400000 {
+		compatible = "andestech,atftmr010";
+		reg = <0x98400000 0x1000>;
+		interrupts = <19 4>;
+		clock-frequency = <15000000>;
+		cycle-count-offset = <0x20>;
+	};
+
+	mac0: mac@90900000 {
+		compatible = "andestech,atmac100";
+		reg = <0x90900000 0x1000>;
+		interrupts = <25 4>;
+	};
+
+	L2: l2-cache {
+		compatible = "andestech,atl2c";
+		reg = <0x90f00000 0x1000>;
+		cache-unified;
+		cache-level = <2>;
+	};
+};
diff --git a/arch/nds32/kernel/devtree.c b/arch/nds32/kernel/devtree.c
new file mode 100644
index 0000000..2af0f1c
--- /dev/null
+++ b/arch/nds32/kernel/devtree.c
@@ -0,0 +1,45 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/memblock.h>
+#include <linux/of_fdt.h>
+#include <linux/bootmem.h>
+
+void __init early_init_dt_add_memory_arch(u64 base, u64 size)
+{
+	size &= PAGE_MASK;
+	memblock_add_node(base, size, 0);
+}
+
+void *__init early_init_dt_alloc_memory_arch(u64 size, u64 align)
+{
+	return alloc_bootmem_align(size, align);
+}
+
+void __init early_init_devtree(void *params)
+{
+	if (!params || !early_init_dt_scan(params)) {
+		pr_crit("\n"
+			"Error: invalid device tree blob at (virtual address 0x%p)\n"
+			"The dtb must be 8-byte aligned and must not exceed 8 KB in size\n"
+			"\nPlease check your bootloader.", params);
+
+		while (true)
+			cpu_relax();
+	}
+
+	dump_stack_set_arch_desc("%s (DT)", of_flat_dt_get_machine_name());
+}
-- 
1.7.9.5
