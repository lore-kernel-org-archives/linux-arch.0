Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:44483 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1759451AbWLBK7S (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:18 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2622816uga
        for <linux-arch@vger.kernel.org>; Sat, 02 Dec 2006 02:59:17 -0800 (PST)
From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [PATCH 01/26] Dynamic kernel command-line - common
Date: Sat, 2 Dec 2006 12:48:22 +0200
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021248.22791.alon.barlev@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


1. Rename saved_command_line into boot_command_line, mark
   as init disposable.
2. Add dynamic allocated saved_command_line.
3. Add dynamic allocated static_command_line.
4. During startup copy:
   boot_command_line into saved_command_line.
   arch command_line into static_command_line.
5. Parse static_command_line and not
   arch command_line, so arch command_line may
   be freed.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/include/linux/init.h linux-2.6.19/include/linux/init.h
--- linux-2.6.19.org/include/linux/init.h	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/include/linux/init.h	2006-12-02 11:31:32.000000000 +0200
@@ -67,7 +67,8 @@ extern initcall_t __con_initcall_start[]
 extern initcall_t __security_initcall_start[], __security_initcall_end[];
 
 /* Defined in init/main.c */
-extern char saved_command_line[];
+extern char __initdata boot_command_line[];
+extern char *saved_command_line;
 extern unsigned int reset_devices;
 
 /* used by init/main.c */
@@ -163,7 +164,7 @@ struct obs_kernel_param {
 #define early_param(str, fn)					\
 	__setup_param(str, fn, fn, 1)
 
-/* Relies on saved_command_line being set */
+/* Relies on boot_command_line being set */
 void __init parse_early_param(void);
 #endif /* __ASSEMBLY__ */
 
diff -urNp linux-2.6.19.org/init/main.c linux-2.6.19/init/main.c
--- linux-2.6.19.org/init/main.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/init/main.c	2006-12-02 11:33:35.000000000 +0200
@@ -116,8 +116,12 @@ extern void time_init(void);
 void (*late_time_init)(void);
 extern void softirq_init(void);
 
-/* Untouched command line (eg. for /proc) saved by arch-specific code. */
-char saved_command_line[COMMAND_LINE_SIZE];
+/* Untouched command line saved by arch-specific code. */
+char __initdata boot_command_line[COMMAND_LINE_SIZE];
+/* Untouched saved command line (eg. for /proc) */
+char *saved_command_line;
+/* Command line for parameter parsing */
+static char *static_command_line;
 
 static char *execute_command;
 static char *ramdisk_execute_command;
@@ -400,6 +404,20 @@ static void __init smp_init(void)
 #endif
 
 /*
+ * We need to store the untouched command line for future reference.
+ * We also need to store the touched command line since the parameter
+ * parsing is performed in place, and we should allow a component to
+ * store reference of name/value for future reference.
+ */
+static void __init setup_command_line(char *command_line)
+{
+	saved_command_line = alloc_bootmem(strlen (boot_command_line)+1);
+	static_command_line = alloc_bootmem(strlen (command_line)+1);
+	strcpy (saved_command_line, boot_command_line);
+	strcpy (static_command_line, command_line);
+}
+
+/*
  * We need to finalize in a non-__init function or else race conditions
  * between the root thread and the init thread may cause start_kernel to
  * be reaped by free_initmem before the root thread has proceeded to
@@ -453,7 +471,7 @@ void __init parse_early_param(void)
 		return;
 
 	/* All fall through to do_early_param. */
-	strlcpy(tmp_cmdline, saved_command_line, COMMAND_LINE_SIZE);
+	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 	parse_args("early options", tmp_cmdline, NULL, 0, do_early_param);
 	done = 1;
 }
@@ -503,6 +521,7 @@ asmlinkage void __init start_kernel(void
 	printk(KERN_NOTICE);
 	printk(linux_banner);
 	setup_arch(&command_line);
+	setup_command_line(command_line);
 	unwind_setup();
 	setup_per_cpu_areas();
 	smp_prepare_boot_cpu();	/* arch-specific boot-cpu hooks */
@@ -520,9 +539,9 @@ asmlinkage void __init start_kernel(void
 	preempt_disable();
 	build_all_zonelists();
 	page_alloc_init();
-	printk(KERN_NOTICE "Kernel command line: %s\n", saved_command_line);
+	printk(KERN_NOTICE "Kernel command line: %s\n", boot_command_line);
 	parse_early_param();
-	parse_args("Booting kernel", command_line, __start___param,
+	parse_args("Booting kernel", static_command_line, __start___param,
 		   __stop___param - __start___param,
 		   &unknown_bootoption);
 	sort_main_extable();
