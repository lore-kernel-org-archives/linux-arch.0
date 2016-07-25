From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 01/14] exceptions: fork exception table content from module.h into extable.h
Date: Sun, 24 Jul 2016 23:42:34 -0400
Message-ID: <20160725034247.109173-2-paul.gortmaker@windriver.com>
References: <20160725034247.109173-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160725034247.109173-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

For historical reasons (i.e. pre-git) the exception table stuff was
buried in the middle of the module.h file.  I noticed this while
doing an audit for needless includes of module.h and found core
kernel files (both arch specific and arch independent) were just
including module.h for this.

The converse is also true, in that conventional drivers, be they
for filesystems or actual hardware peripherals or similar, do not
normally care about the exception tables.

Here we fork the exception table content out of module.h into a
new file called extable.h -- and temporarily include it into the
module.h itself.

Then we will work our way across the arch independent and arch
specific files needing just exception table content, and move
them off module.h and onto extable.h

Once that is done, we can remove the extable.h from module.h
and in doing it like this, we avoid introducing build failures
into the git history.

The gain here is that module.h gets a bit smaller, across all
modular drivers that we build for allmodconfig.  Also the core
files that only need exception table stuff don't have an include
of module.h that brings in lots of extra stuff and just looks
generally out of place.

Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 include/linux/extable.h | 30 ++++++++++++++++++++++++++++++
 include/linux/module.h  | 27 ++-------------------------
 2 files changed, 32 insertions(+), 25 deletions(-)
 create mode 100644 include/linux/extable.h

diff --git a/include/linux/extable.h b/include/linux/extable.h
new file mode 100644
index 000000000000..2c71dccd1bc3
--- /dev/null
+++ b/include/linux/extable.h
@@ -0,0 +1,30 @@
+#ifndef _LINUX_EXTABLE_H
+#define _LINUX_EXTABLE_H
+
+struct module;
+struct exception_table_entry;
+
+const struct exception_table_entry *
+search_extable(const struct exception_table_entry *first,
+	       const struct exception_table_entry *last,
+	       unsigned long value);
+void sort_extable(struct exception_table_entry *start,
+		  struct exception_table_entry *finish);
+void sort_main_extable(void);
+void trim_init_extable(struct module *m);
+
+/* Given an address, look for it in the exception tables */
+const struct exception_table_entry *search_exception_tables(unsigned long add);
+
+#ifdef CONFIG_MODULES
+/* For extable.c to search modules' exception tables. */
+const struct exception_table_entry *search_module_extables(unsigned long addr);
+#else
+static inline const struct exception_table_entry *
+search_module_extables(unsigned long addr)
+{
+	return NULL;
+}
+#endif /*CONFIG_MODULES*/
+
+#endif /* _LINUX_EXTABLE_H */
diff --git a/include/linux/module.h b/include/linux/module.h
index f777164c238b..f95ed243a4de 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -18,6 +18,7 @@
 #include <linux/moduleparam.h>
 #include <linux/jump_label.h>
 #include <linux/export.h>
+#include <linux/extable.h>	/* only as arch move module.h -> extable.h */
 #include <linux/rbtree_latch.h>
 
 #include <linux/percpu.h>
@@ -37,6 +38,7 @@ struct modversion_info {
 };
 
 struct module;
+struct exception_table_entry;
 
 struct module_kobject {
 	struct kobject kobj;
@@ -155,18 +157,6 @@ extern void cleanup_module(void);
 #define __INITRODATA_OR_MODULE __INITRODATA
 #endif /*CONFIG_MODULES*/
 
-/* Archs provide a method of finding the correct exception table. */
-struct exception_table_entry;
-
-const struct exception_table_entry *
-search_extable(const struct exception_table_entry *first,
-	       const struct exception_table_entry *last,
-	       unsigned long value);
-void sort_extable(struct exception_table_entry *start,
-		  struct exception_table_entry *finish);
-void sort_main_extable(void);
-void trim_init_extable(struct module *m);
-
 /* Generic info of form tag = "info" */
 #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
 
@@ -268,9 +258,6 @@ extern const typeof(name) __mod_##type##__##name##_device_table		\
  * files require multiple MODULE_FIRMWARE() specifiers */
 #define MODULE_FIRMWARE(_firmware) MODULE_INFO(firmware, _firmware)
 
-/* Given an address, look for it in the exception tables */
-const struct exception_table_entry *search_exception_tables(unsigned long add);
-
 struct notifier_block;
 
 #ifdef CONFIG_MODULES
@@ -630,9 +617,6 @@ const char *module_address_lookup(unsigned long addr,
 int lookup_module_symbol_name(unsigned long addr, char *symname);
 int lookup_module_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name);
 
-/* For extable.c to search modules' exception tables. */
-const struct exception_table_entry *search_module_extables(unsigned long addr);
-
 int register_module_notifier(struct notifier_block *nb);
 int unregister_module_notifier(struct notifier_block *nb);
 
@@ -657,13 +641,6 @@ static inline bool is_livepatch_module(struct module *mod)
 
 #else /* !CONFIG_MODULES... */
 
-/* Given an address, look for it in the exception tables. */
-static inline const struct exception_table_entry *
-search_module_extables(unsigned long addr)
-{
-	return NULL;
-}
-
 static inline struct module *__module_address(unsigned long addr)
 {
 	return NULL;
-- 
2.8.4
