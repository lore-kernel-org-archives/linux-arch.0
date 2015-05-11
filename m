From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v12 09/21] h8300: kernel startup
Date: Mon, 11 May 2015 15:26:28 +0900
Message-ID: <1431325600-12333-10-git-send-email-ysato@users.sourceforge.jp>
References: <1431325600-12333-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431325600-12333-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 Documentation/devicetree/bindings/h8300/cpu.txt    |  13 ++
 .../memory-controllers/renesas,h8300-bsc.txt       |  12 +
 arch/h8300/kernel/setup.c                          | 255 +++++++++++++++++++++
 3 files changed, 280 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/h8300/cpu.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.txt
 create mode 100644 arch/h8300/kernel/setup.c

diff --git a/Documentation/devicetree/bindings/h8300/cpu.txt b/Documentation/devicetree/bindings/h8300/cpu.txt
new file mode 100644
index 0000000..70cd586
--- /dev/null
+++ b/Documentation/devicetree/bindings/h8300/cpu.txt
@@ -0,0 +1,13 @@
+* H8/300 CPU bindings
+
+Required properties:
+
+- compatible: Compatible property value should be "renesas,h8300".
+- clock-frequency: Contains the clock frequency for CPU, in Hz.
+
+Example:
+
+		cpu@0 {
+			compatible = "renesas,h8300";
+			clock-frequency = <20000000>;
+		};
diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.txt b/Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.txt
new file mode 100644
index 0000000..cdf406c
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.txt
@@ -0,0 +1,12 @@
+* H8/300 bus controller
+
+Required properties:
+  - compatible: Must be "renesas,h8300-bsc".
+  - reg: Base address and length of BSC registers.
+
+Example.
+	bsc: memory-controller@fee01e {
+		compatible = "renesas,h8300h-bsc", "renesas,h8300-bsc";
+		reg = <0xfee01e 8>;
+	};
+
diff --git a/arch/h8300/kernel/setup.c b/arch/h8300/kernel/setup.c
new file mode 100644
index 0000000..0fd1fe6
--- /dev/null
+++ b/arch/h8300/kernel/setup.c
@@ -0,0 +1,255 @@
+/*
+ *  linux/arch/h8300/kernel/setup.c
+ *
+ *  Copyright (C) 2001-2014 Yoshinori Sato <ysato@users.sourceforge.jp>
+ */
+
+/*
+ * This file handles the architecture-dependent parts of system setup
+ */
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/mm.h>
+#include <linux/fs.h>
+#include <linux/console.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/bootmem.h>
+#include <linux/seq_file.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/clk-provider.h>
+#include <linux/memblock.h>
+#include <linux/screen_info.h>
+
+#include <asm/setup.h>
+#include <asm/irq.h>
+#include <asm/pgtable.h>
+#include <asm/sections.h>
+#include <asm/page.h>
+
+#if defined(CONFIG_CPU_H8300H)
+#define CPU "H8/300H"
+#elif defined(CONFIG_CPU_H8S)
+#define CPU "H8S"
+#else
+#define CPU "Unknown"
+#endif
+
+unsigned long memory_start;
+unsigned long memory_end;
+EXPORT_SYMBOL(memory_end);
+static unsigned long freq;
+extern char __dtb_start[];
+
+#ifdef CONFIG_VT
+struct screen_info screen_info;
+#endif
+
+char __initdata command_line[COMMAND_LINE_SIZE];
+
+void sim_console_register(void);
+
+void __init h8300_fdt_init(void *fdt, char *bootargs)
+{
+	if (!fdt)
+		fdt = __dtb_start;
+	else
+		strcpy(command_line, bootargs);
+
+	early_init_dt_scan(fdt);
+	memblock_allow_resize();
+}
+
+static void __init bootmem_init(void)
+{
+	int bootmap_size;
+	unsigned long ram_start_pfn;
+	unsigned long free_ram_start_pfn;
+	unsigned long ram_end_pfn;
+	struct memblock_region *region;
+
+	memory_end = memory_start = 0;
+
+	/* Find main memory where is the kernel */
+	for_each_memblock(memory, region) {
+		memory_start = region->base;
+		memory_end = region->base + region->size;
+	}
+
+	if (!memory_end)
+		panic("No memory!");
+
+	ram_start_pfn = PFN_UP(memory_start);
+	/* free_ram_start_pfn is first page after kernel */
+	free_ram_start_pfn = PFN_UP(__pa(_end));
+	ram_end_pfn = PFN_DOWN(memblock_end_of_DRAM());
+
+	max_pfn = ram_end_pfn;
+
+	/*
+	 * give all the memory to the bootmap allocator,  tell it to put the
+	 * boot mem_map at the start of memory
+	 */
+	bootmap_size = init_bootmem_node(NODE_DATA(0),
+					 free_ram_start_pfn,
+					 0,
+					 ram_end_pfn);
+	/*
+	 * free the usable memory,  we have to make sure we do not free
+	 * the bootmem bitmap so we then reserve it after freeing it :-)
+	 */
+	free_bootmem(PFN_PHYS(free_ram_start_pfn),
+		     (ram_end_pfn - free_ram_start_pfn) << PAGE_SHIFT);
+	reserve_bootmem(PFN_PHYS(free_ram_start_pfn), bootmap_size,
+			BOOTMEM_DEFAULT);
+
+	for_each_memblock(reserved, region) {
+		reserve_bootmem(region->base, region->size, BOOTMEM_DEFAULT);
+	}
+}
+
+void __init setup_arch(char **cmdline_p)
+{
+	unflatten_and_copy_device_tree();
+
+	init_mm.start_code = (unsigned long) _stext;
+	init_mm.end_code = (unsigned long) _etext;
+	init_mm.end_data = (unsigned long) _edata;
+	init_mm.brk = (unsigned long) 0;
+
+	pr_notice("\r\n\nuClinux " CPU "\n");
+	pr_notice("Flat model support (C) 1998,1999 Kenneth Albanowski, D. Jeff Dionne\n");
+
+	if (*command_line)
+		strcpy(boot_command_line, command_line);
+	*cmdline_p = boot_command_line;
+
+	parse_early_param();
+
+	bootmem_init();
+#if defined(CONFIG_H8300H_SIM) || defined(CONFIG_H8S_SIM)
+	sim_console_register();
+#endif
+
+	early_platform_driver_probe("earlyprintk", 1, 0);
+	/*
+	 * get kmalloc into gear
+	 */
+	paging_init();
+}
+
+/*
+ *	Get CPU information for use by the procfs.
+ */
+
+static int show_cpuinfo(struct seq_file *m, void *v)
+{
+	char *cpu;
+
+	cpu = CPU;
+
+	seq_printf(m,  "CPU:\t\t%s\n"
+		   "Clock:\t\t%lu.%1luMHz\n"
+		   "BogoMips:\t%lu.%02lu\n"
+		   "Calibration:\t%lu loops\n",
+		   cpu,
+		   freq/1000, freq%1000,
+		   (loops_per_jiffy*HZ)/500000,
+		   ((loops_per_jiffy*HZ)/5000)%100,
+		   (loops_per_jiffy*HZ));
+
+	return 0;
+}
+
+static void *c_start(struct seq_file *m, loff_t *pos)
+{
+	return *pos < num_possible_cpus() ?
+		((void *) 0x12345678) : NULL;
+}
+
+static void *c_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	++*pos;
+	return c_start(m, pos);
+}
+
+static void c_stop(struct seq_file *m, void *v)
+{
+}
+
+const struct seq_operations cpuinfo_op = {
+	.start	= c_start,
+	.next	= c_next,
+	.stop	= c_stop,
+	.show	= show_cpuinfo,
+};
+
+static int __init device_probe(void)
+{
+	of_platform_populate(NULL, NULL, NULL, NULL);
+
+	return 0;
+}
+
+device_initcall(device_probe);
+
+#if defined(CONFIG_CPU_H8300H)
+#define get_wait(base, addr) ({		\
+	int baddr;			\
+	baddr = ((addr) / 0x200000 * 2);			     \
+	w *= (ctrl_inw((unsigned long)(base) + 2) & (3 << baddr)) + 1;	\
+	})
+#endif
+#if defined(CONFIG_CPU_H8S)
+#define get_wait(base, addr) ({		\
+	int baddr;			\
+	baddr = ((addr) / 0x200000 * 16);			     \
+	w *= (ctrl_inl((unsigned long)(base) + 2) & (7 << baddr)) + 1;	\
+	})
+#endif
+
+static __init int access_timing(void)
+{
+	struct device_node *bsc;
+	void __iomem *base;
+	unsigned long addr = (unsigned long)&__delay;
+	int bit = 1 << (addr / 0x200000);
+	int w;
+
+	bsc = of_find_compatible_node(NULL, NULL, "renesas,h8300-bsc");
+	base = of_iomap(bsc, 0);
+	w = (ctrl_inb((unsigned long)base + 0) & bit)?2:1;
+	if (ctrl_inb((unsigned long)base + 1) & bit)
+		w *= get_wait(base, addr);
+	else
+		w *= 2;
+	return w * 3 / 2;
+}
+
+void __init calibrate_delay(void)
+{
+	struct device_node *cpu;
+	int freq;
+
+	cpu = of_find_compatible_node(NULL, NULL, "renesas,h8300");
+	of_property_read_s32(cpu, "clock-frequency", &freq);
+	loops_per_jiffy = freq / HZ / (access_timing() * 2);
+	pr_cont("%lu.%02lu BogoMIPS (lpj=%lu)\n",
+		loops_per_jiffy / (500000 / HZ),
+		(loops_per_jiffy / (5000 / HZ)) % 100, loops_per_jiffy);
+}
+
+
+void __init time_init(void)
+{
+	of_clk_init(NULL);
+}
-- 
2.1.4
