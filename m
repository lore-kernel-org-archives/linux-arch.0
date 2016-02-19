From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [RFC v2 6/7] dynamic_debug: port to use linker tables
Date: Fri, 19 Feb 2016 05:45:58 -0800
Message-ID: <1455889559-9428-7-git-send-email-mcgrof@kernel.org>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc: benh@kernel.crashing.org, ming.lei@canonical.com, masami.hiramatsu.pt@hitachi.com, linux-arch@vger.kernel.org, xen-devel@lists.xensource.com, linux@arm.linux.org.uk, x86@kernel.org, anil.s.keshavamurthy@intel.com, arnd@arndb.de, rusty@rustcorp.com.au, jbaron@akamai.com, boris.ostrovsky@oracle.com, andriy.shevchenko@linux.intel.com, mcb30@ipxe.org, jgross@suse.com, ananth@in.ibm.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, luto@amacapital.net, "Luis R. Rodriguez" <mcgrof@kernel.org>, david.vrabel@citrix.com, dwmw2@infradead.org, davem@davemloft.net
List-Id: linux-arch.vger.kernel.org

This removes the custom vmlinux.lds.h hacks and uses
the generalized solution for .data (SECTION_DATA)
entries.

This is much more potential for further fine tuning here
though in the future. For instance, linker tables enable
an extra postfix for order level annotations, this could
easily be used as the KBUILD_MODNAME and with a bit of
linker table changes we may be able to get a direct O(1)
count of the entries for that KBUILD_MODNAME: it would
just be a count on the number of entries for the given
order level. This should help make dynamic_debug_init()
cleaner and also reduce the amount of time it takes at
boot time. Instead of iterating over each print until we
have all for a KBUILD_MODNAME, we'd instead directly
operate on each KBUILD_MODNAME directly.

Tested dynamic debug with dyndbg query ana debugfs control
and it works as expected.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 include/asm-generic/vmlinux.lds.h |  5 -----
 include/linux/dynamic_debug.h     |  6 ++++--
 kernel/module.c                   |  2 +-
 lib/dynamic_debug.c               | 13 ++++++-------
 4 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 11e1adcbcb24..c5fcac902cbe 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -209,11 +209,6 @@
 	*(.data.unlikely)						\
 	STRUCT_ALIGN();							\
 	*(__tracepoints)						\
-	/* implement dynamic printk debug */				\
-	. = ALIGN(8);							\
-	VMLINUX_SYMBOL(__start___verbose) = .;                          \
-	*(__verbose)                                                    \
-	VMLINUX_SYMBOL(__stop___verbose) = .;				\
 	LIKELY_PROFILE()		       				\
 	BRANCH_PROFILE()						\
 	TRACE_PRINTKS()							\
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 4f1bbc68cd1b..6cd14a22b795 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -1,6 +1,8 @@
 #ifndef _DYNAMIC_DEBUG_H
 #define _DYNAMIC_DEBUG_H
 
+#include <linux/tables.h>
+
 /*
  * An instance of this structure is created in a special
  * ELF section at every dynamic debug callsite.  At runtime,
@@ -40,6 +42,7 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 				const char *modname);
 
 #if defined(CONFIG_DYNAMIC_DEBUG)
+DECLARE_LINKTABLE_DATA(struct _ddebug, __verbose);
 extern int ddebug_remove_module(const char *mod_name);
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);
@@ -61,8 +64,7 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 			  const char *fmt, ...);
 
 #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)		\
-	static struct _ddebug  __aligned(8)			\
-	__attribute__((section("__verbose"))) name = {		\
+	static LINKTABLE_DATA(__verbose, all) name = {		\
 		.modname = KBUILD_MODNAME,			\
 		.function = __func__,				\
 		.filename = __FILE__,				\
diff --git a/kernel/module.c b/kernel/module.c
index 42249ee8e462..22d768abb1ec 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2962,7 +2962,7 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	if (section_addr(info, "__obsparm"))
 		pr_warn("%s: Ignoring obsolete parameters\n", mod->name);
 
-	info->debug = section_objs(info, "__verbose",
+	info->debug = section_objs(info, SECTION_TBL(SECTION_DATA, __verbose,),
 				   sizeof(*info->debug), &info->num_debug);
 
 	return 0;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index fe42b6ec3f0c..ae7b9b4ac022 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -37,8 +37,7 @@
 #include <linux/device.h>
 #include <linux/netdevice.h>
 
-extern struct _ddebug __start___verbose[];
-extern struct _ddebug __stop___verbose[];
+DEFINE_LINKTABLE_DATA(struct _ddebug, __verbose);
 
 struct ddebug_table {
 	struct list_head link;
@@ -971,14 +970,14 @@ static int __init dynamic_debug_init(void)
 	int n = 0, entries = 0, modct = 0;
 	int verbose_bytes = 0;
 
-	if (__start___verbose == __stop___verbose) {
-		pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
+	if (LINKTABLE_EMPTY(__verbose)) {
+		pr_warn("dynamic debug linker table empty on CONFIG_DYNAMIC_DEBUG build\n");
 		return 1;
 	}
-	iter = __start___verbose;
+	iter = LINKTABLE_START(__verbose);
 	modname = iter->modname;
 	iter_start = iter;
-	for (; iter < __stop___verbose; iter++) {
+	LINKTABLE_FOR_EACH(iter, __verbose) {
 		entries++;
 		verbose_bytes += strlen(iter->modname) + strlen(iter->function)
 			+ strlen(iter->filename) + strlen(iter->format);
@@ -1001,7 +1000,7 @@ static int __init dynamic_debug_init(void)
 	ddebug_init_success = 1;
 	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in (readonly) verbose section\n",
 		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
-		 verbose_bytes + (int)(__stop___verbose - __start___verbose));
+		 verbose_bytes + (int)(LINKTABLE_SIZE(__verbose)));
 
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
-- 
2.7.0
