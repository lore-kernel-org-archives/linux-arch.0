From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] earlycon: rework common framework for earlycon declarations
Date: Fri, 12 Feb 2016 18:28:16 +0900
Message-ID: <1455269296-5009-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: linux-arch@vger.kernel.org, devicetree@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Rob Herring <robh+dt@kernel.org>, Jiri Slaby <jslaby@suse.com>, Grant Likely <grant.likely@linaro.org>, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Commit 71f50c6d9a22 ("of: drop symbols declared by _OF_DECLARE() from
modules") fixed the link error introduced by commit b8d20e06eaad
("serial: 8250_uniphier: add earlycon support").

After commit 2eaa790989e0 ("earlycon: Use common framework for
earlycon declarations") was applied, the link error came back
because the commit reworked OF_EARLYCON_DECLARE() to not use
_OF_DECLARE().

This commit reworks OF_EARLYCON_DECLARE() again based on
_OF_DECLARE().  My motivations are:

 - Fix the link error in a generic way (without patching
   drivers/tty/serial/8250/8250_uniphier.c)

 - Delete struct earlycon_id.  This struct is re-inventing the wheel;
   the fields "name", "compatible", "setup" can be implemented in
   struct of_device_id as other framework do.

The difference between OF_EARLYCON_DECLARE() and other users of
_OF_DECLARE is that OF_EARLYCON_DECLARE() needs to fill the "name"
field of struct of_device_id.  To make it easier, a new macro
_OF_DECLARE_WITH_NAME() has been added.  It fills the name field
with the given argument.  On the other hand, _OF_DECLARE() sets the
"name" field to a null string; this is the same behavior as before.

Fixes: 2eaa790989e0 ("earlycon: Use common framework for earlycon declarations")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I confirmed this patch can apply onto "next-20160212" tag of linux-next.

In order to apply it onto the "tty-next" branch of TTY subsytem,
Grag will have to pull v4.5-rc3 in.


 drivers/of/fdt.c                  |  7 ++-----
 drivers/tty/serial/earlycon.c     | 19 +++++++++++++------
 include/asm-generic/vmlinux.lds.h | 12 ++----------
 include/linux/of.h                | 22 +++++++++++++++-------
 include/linux/serial_core.h       | 23 +++++++----------------
 5 files changed, 39 insertions(+), 44 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index e2295b2..ad262e9 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -802,7 +802,7 @@ static int __init early_init_dt_scan_chosen_serial(void)
 	int offset;
 	const char *p, *q, *options = NULL;
 	int l;
-	const struct earlycon_id *match;
+	const struct of_device_id *match;
 	const void *fdt = initial_boot_params;
 
 	offset = fdt_path_offset(fdt, "/chosen");
@@ -829,10 +829,7 @@ static int __init early_init_dt_scan_chosen_serial(void)
 		return 0;
 	}
 
-	for (match = __earlycon_table; match < __earlycon_table_end; match++) {
-		if (!match->compatible[0])
-			continue;
-
+	for (match = __earlycon_of_table; match->compatible[0]; match++) {
 		if (fdt_node_check_compatible(fdt, offset, match->compatible))
 			continue;
 
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 067783f..4888ced 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -38,6 +38,9 @@ static struct earlycon_device early_console_dev = {
 	.con = &early_con,
 };
 
+static const struct of_device_id __earlycon_of_table_sentinel
+	__used __section(__earlycon_of_table_end);
+
 static void __iomem * __init earlycon_map(unsigned long paddr, size_t size)
 {
 	void __iomem *base;
@@ -127,9 +130,10 @@ static int __init parse_options(struct earlycon_device *device, char *options)
 	return 0;
 }
 
-static int __init register_earlycon(char *buf, const struct earlycon_id *match)
+static int __init register_earlycon(char *buf, const struct of_device_id *match)
 {
 	int err;
+	int (*setup)(struct earlycon_device *, const char *options);
 	struct uart_port *port = &early_console_dev.port;
 
 	/* On parsing error, pass the options buf to the setup function */
@@ -142,7 +146,8 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
 		port->membase = earlycon_map(port->mapbase, 64);
 
 	earlycon_init(&early_console_dev, match->name);
-	err = match->setup(&early_console_dev, buf);
+	setup = match->data;
+	err = setup(&early_console_dev, buf);
 	if (err < 0)
 		return err;
 	if (!early_console_dev.con->write)
@@ -172,7 +177,7 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
  */
 int __init setup_earlycon(char *buf)
 {
-	const struct earlycon_id *match;
+	const struct of_device_id *match;
 
 	if (!buf || !buf[0])
 		return -EINVAL;
@@ -180,7 +185,7 @@ int __init setup_earlycon(char *buf)
 	if (early_con.flags & CON_ENABLED)
 		return -EALREADY;
 
-	for (match = __earlycon_table; match < __earlycon_table_end; match++) {
+	for (match = __earlycon_of_table; match->name[0]; match++) {
 		size_t len = strlen(match->name);
 
 		if (strncmp(buf, match->name, len))
@@ -220,12 +225,13 @@ early_param("earlycon", param_setup_earlycon);
 
 #ifdef CONFIG_OF_EARLY_FLATTREE
 
-int __init of_setup_earlycon(const struct earlycon_id *match,
+int __init of_setup_earlycon(const struct of_device_id *match,
 			     unsigned long node,
 			     const char *options)
 {
 	int err;
 	struct uart_port *port = &early_console_dev.port;
+	int (*setup)(struct earlycon_device *, const char *options);
 	const __be32 *val;
 	bool big_endian;
 	u64 addr;
@@ -273,7 +279,8 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
 			sizeof(early_console_dev.options));
 	}
 	earlycon_init(&early_console_dev, match->name);
-	err = match->setup(&early_console_dev, options);
+	setup = match->data;
+	err = setup(&early_console_dev, options);
 	if (err < 0)
 		return err;
 	if (!early_console_dev.con->write)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e9a81a6..699f4a5 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -153,15 +153,6 @@
 #define TRACE_SYSCALLS()
 #endif
 
-#ifdef CONFIG_SERIAL_EARLYCON
-#define EARLYCON_TABLE() STRUCT_ALIGN();			\
-			 VMLINUX_SYMBOL(__earlycon_table) = .;	\
-			 *(__earlycon_table)			\
-			 VMLINUX_SYMBOL(__earlycon_table_end) = .;
-#else
-#define EARLYCON_TABLE()
-#endif
-
 #define ___OF_TABLE(cfg, name)	_OF_TABLE_##cfg(name)
 #define __OF_TABLE(cfg, name)	___OF_TABLE(cfg, name)
 #define OF_TABLE(cfg, name)	__OF_TABLE(config_enabled(cfg), name)
@@ -179,6 +170,7 @@
 #define RESERVEDMEM_OF_TABLES()	OF_TABLE(CONFIG_OF_RESERVED_MEM, reservedmem)
 #define CPU_METHOD_OF_TABLES()	OF_TABLE(CONFIG_SMP, cpu_method)
 #define CPUIDLE_METHOD_OF_TABLES() OF_TABLE(CONFIG_CPU_IDLE, cpuidle_method)
+#define EARLYCON_OF_TABLES()	OF_TABLE(CONFIG_SERIAL_EARLYCON, earlycon)
 
 #ifdef CONFIG_ACPI
 #define ACPI_PROBE_TABLE(name)						\
@@ -525,7 +517,7 @@
 	IRQCHIP_OF_MATCH_TABLE()					\
 	ACPI_PROBE_TABLE(irqchip)					\
 	ACPI_PROBE_TABLE(clksrc)					\
-	EARLYCON_TABLE()
+	EARLYCON_OF_TABLES()
 
 #define INIT_TEXT							\
 	*(.init.text)							\
diff --git a/include/linux/of.h b/include/linux/of.h
index dc6e396..6e57245 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -930,19 +930,27 @@ static inline int of_get_available_child_count(const struct device_node *np)
 }
 
 #if defined(CONFIG_OF) && !defined(MODULE)
-#define _OF_DECLARE(table, name, compat, fn, fn_type)			\
-	static const struct of_device_id __of_table_##name		\
+#define __OF_DECLARE(table, name1, name2, compat, fn, fn_type)		\
+	static const struct of_device_id __UNIQUE_ID(__of_table_##name1)\
 		__used __section(__##table##_of_table)			\
-		 = { .compatible = compat,				\
+		 = { .name = name2,					\
+		     .compatible = compat,				\
 		     .data = (fn == (fn_type)NULL) ? fn : fn  }
 #else
-#define _OF_DECLARE(table, name, compat, fn, fn_type)			\
-	static const struct of_device_id __of_table_##name		\
+#define __OF_DECLARE(table, name1, name2, compat, fn, fn_type)		\
+	static const struct of_device_id __UNIQUE_ID(__of_table_##name1)\
 		__attribute__((unused))					\
-		 = { .compatible = compat,				\
-		     .data = (fn == (fn_type)NULL) ? fn : fn }
+		 = { .name = name2,					\
+		     .compatible = compat,				\
+		     .data = (fn == (fn_type)NULL) ? fn : fn  }
 #endif
 
+#define _OF_DECLARE(table, name, compat, fn, fn_type)	\
+	__OF_DECLARE(table, name, "", compat, fn, fn_type)
+
+#define _OF_DECLARE_WITH_NAME(table, name, compat, fn, fn_type)	\
+	__OF_DECLARE(table, name, __stringify(name), compat, fn, fn_type)
+
 typedef int (*of_init_fn_2)(struct device_node *, struct device_node *);
 typedef void (*of_init_fn_1)(struct device_node *);
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index cbfcf38..0f13160 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -24,6 +24,7 @@
 #include <linux/compiler.h>
 #include <linux/interrupt.h>
 #include <linux/circ_buf.h>
+#include <linux/mod_devicetable.h>
 #include <linux/spinlock.h>
 #include <linux/sched.h>
 #include <linux/tty.h>
@@ -340,26 +341,16 @@ struct earlycon_device {
 	unsigned int baud;
 };
 
-struct earlycon_id {
-	char	name[16];
-	char	compatible[128];
-	int	(*setup)(struct earlycon_device *, const char *options);
-} __aligned(32);
+extern const struct of_device_id __earlycon_of_table[];
 
-extern const struct earlycon_id __earlycon_table[];
-extern const struct earlycon_id __earlycon_table_end[];
+#define OF_EARLYCON_DECLARE(name, compat, fn)				\
+	_OF_DECLARE_WITH_NAME(earlycon, name, compat, fn, void *)
 
-#define OF_EARLYCON_DECLARE(_name, compat, fn)				\
-	static const struct earlycon_id __UNIQUE_ID(__earlycon_##_name)	\
-	     __used __section(__earlycon_table)				\
-		= { .name = __stringify(_name),				\
-		    .compatible = compat,				\
-		    .setup = fn  }
-
-#define EARLYCON_DECLARE(_name, fn)	OF_EARLYCON_DECLARE(_name, "", fn)
+#define EARLYCON_DECLARE(_name, fn)	\
+	OF_EARLYCON_DECLARE(_name, "-earlycon-dummy-compat-string-", fn)
 
 extern int setup_earlycon(char *buf);
-extern int of_setup_earlycon(const struct earlycon_id *match,
+extern int of_setup_earlycon(const struct of_device_id *match,
 			     unsigned long node,
 			     const char *options);
 
-- 
1.9.1
