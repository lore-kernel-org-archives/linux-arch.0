From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: [PATCH] modules: don't print out loaded modules too often if
 nothing changed
Date: Fri, 24 Jul 2015 15:55:03 +0300
Message-ID: <20150724125503.4861.77730.stgit@buzz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from forward-corp1o.mail.yandex.net ([37.140.190.172]:50147 "EHLO
	forward-corp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752284AbbGXMzI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 Jul 2015 08:55:08 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Cc: Joe Perches <joe@perches.com>

List of loaded modules is useful but printing it at each splat
adds too much noise. This patch prints place-holder "<unchanged>"
if kernel not in panic, nothing have changed and since last print
passed less then 15 minutes. First warning will have it for sure.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 kernel/module.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/module.c b/kernel/module.c
index 4d2b82e610e2..e185b8d53205 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -101,6 +101,7 @@
 DEFINE_MUTEX(module_mutex);
 EXPORT_SYMBOL_GPL(module_mutex);
 static LIST_HEAD(modules);
+static unsigned long modules_printed;
 
 #ifdef CONFIG_MODULES_TREE_LOOKUP
 
@@ -1005,6 +1006,7 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 
 	/* Store the name of the last unloaded module for diagnostic purposes */
 	strlcpy(last_unloaded_module, mod->name, sizeof(last_unloaded_module));
+	modules_printed = 0;
 
 	free_module(mod);
 	return 0;
@@ -2019,6 +2021,7 @@ static void free_module(struct module *mod)
 	/* Unlink carefully: kallsyms could be walking list. */
 	list_del_rcu(&mod->list);
 	mod_tree_remove(mod);
+	modules_printed = 0;
 	/* Remove this module from bug list, this uses list_del_rcu */
 	module_bug_cleanup(mod);
 	/* Wait for RCU-sched synchronizing before releasing mod->list and buglist. */
@@ -3343,6 +3346,7 @@ again:
 	mod_update_bounds(mod);
 	list_add_rcu(&mod->list, &modules);
 	mod_tree_insert(mod);
+	modules_printed = 0;
 	err = 0;
 
 out:
@@ -3558,6 +3562,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	/* Unlink carefully: kallsyms could be walking list. */
 	list_del_rcu(&mod->list);
 	mod_tree_remove(mod);
+	modules_printed = 0;
 	wake_up_all(&module_wq);
 	/* Wait for RCU-sched synchronizing before releasing mod->list. */
 	synchronize_sched();
@@ -4058,6 +4063,14 @@ void print_modules(void)
 	char buf[8];
 
 	printk(KERN_DEFAULT "Modules linked in:");
+
+	if (!oops_in_progress && modules_printed &&
+	    time_before(jiffies, modules_printed + HZ * 60 * 15)) {
+		pr_cont(" <unchanged>\n");
+		return;
+	}
+	modules_printed = jiffies;
+
 	/* Most callers should already have preempt disabled, but make sure */
 	preempt_disable();
 	list_for_each_entry_rcu(mod, &modules, list) {
