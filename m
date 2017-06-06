From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 12/17] tty: New RISC-V SBI Console Driver
Date: Tue,  6 Jun 2017 16:00:02 -0700
Message-ID: <20170606230007.19101-13-palmer@dabbelt.com>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606230007.19101-1-palmer@dabbelt.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net
Cc: albert@sifive.com, patches@groups.riscv.org, Palmer Dabbelt <palmer@dabbelt.com>
List-Id: linux-arch.vger.kernel.org

This patch adds a new driver for the console availiable via the RISC-V
SBI.  This console is specified to be used for early boot messages, and
is designed to be a very simple (albiet somewhat slow) console that is
always availiable.  All RISC-V systems have an SBI console.

The SBI console is made availiable for early printk messages and is also
availiable as a regular console.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 drivers/tty/hvc/Kconfig   |  11 +++++
 drivers/tty/hvc/Makefile  |   1 +
 drivers/tty/hvc/hvc_sbi.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+)
 create mode 100644 drivers/tty/hvc/hvc_sbi.c

diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index 574da15fe618..f3774adab240 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -114,4 +114,15 @@ config HVCS
 	  which will also be compiled when this driver is built as a
 	  module.
 
+config HVC_SBI
+	bool "SBI console support"
+	depends on RISCV
+	select HVC_DRIVER
+	default y
+	help
+	  This enables support for console output via RISC-V SBI calls, which
+	  is normally used only during boot to output printk.
+
+	  If you don't know what do to here, say Y.
+
 endif # TTY
diff --git a/drivers/tty/hvc/Makefile b/drivers/tty/hvc/Makefile
index 6a2702be76d1..2d63bfe4a96b 100644
--- a/drivers/tty/hvc/Makefile
+++ b/drivers/tty/hvc/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_HVC_IUCV)		+= hvc_iucv.o
 obj-$(CONFIG_HVC_UDBG)		+= hvc_udbg.o
 obj-$(CONFIG_HVC_BFIN_JTAG)	+= hvc_bfin_jtag.o
 obj-$(CONFIG_HVCS)		+= hvcs.o
+obj-$(CONFIG_HVC_SBI)		+= hvc_sbi.o
diff --git a/drivers/tty/hvc/hvc_sbi.c b/drivers/tty/hvc/hvc_sbi.c
new file mode 100644
index 000000000000..e70293fb7b35
--- /dev/null
+++ b/drivers/tty/hvc/hvc_sbi.c
@@ -0,0 +1,102 @@
+/*
+ * RISC-V SBI interface to hvc_console.c
+ *  based on drivers-tty/hvc/hvc_udbg.c
+ *
+ * Copyright (C) 2008 David Gibson, IBM Corporation
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/moduleparam.h>
+#include <linux/types.h>
+#include <linux/irq.h>
+
+#include <asm/sbi.h>
+
+#include "hvc_console.h"
+
+static int hvc_sbi_tty_put(uint32_t vtermno, const char *buf, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		sbi_console_putchar(buf[i]);
+
+	return i;
+}
+
+static int hvc_sbi_tty_get(uint32_t vtermno, char *buf, int count)
+{
+	int i, c;
+
+	for (i = 0; i < count; i++) {
+		if ((c = sbi_console_getchar()) < 0)
+			break;
+		buf[i] = c;
+	}
+
+	return i;
+}
+
+static const struct hv_ops hvc_sbi_ops = {
+	.get_chars = hvc_sbi_tty_get,
+	.put_chars = hvc_sbi_tty_put,
+};
+
+static int __init hvc_sbi_init(void)
+{
+	return PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_ops, 16));
+}
+device_initcall(hvc_sbi_init);
+
+static int __init hvc_sbi_console_init(void)
+{
+	hvc_instantiate(0, 0, &hvc_sbi_ops);
+	add_preferred_console("hvc", 0, NULL);
+
+	return 0;
+}
+console_initcall(hvc_sbi_console_init);
+
+#ifdef CONFIG_EARLY_PRINTK
+static void sbi_console_write(struct console *co, const char *buf,
+			      unsigned int n)
+{
+	int i;
+
+	for (i = 0; i < n; ++i) {
+		if (buf[i] == '\n')
+			sbi_console_putchar('\r');
+		sbi_console_putchar(buf[i]);
+	}
+}
+
+static struct console early_console_dev __initdata = {
+	.name	= "early",
+	.write	= sbi_console_write,
+	.flags	= CON_PRINTBUFFER | CON_BOOT,
+	.index	= -1
+};
+
+static int __init setup_early_printk(char *str)
+{
+	if (early_console == NULL) {
+		early_console = &early_console_dev;
+		register_console(early_console);
+	}
+	return 0;
+}
+early_param("earlyprintk", setup_early_printk);
+#endif
-- 
2.13.0
