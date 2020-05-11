From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic-WFhQfpSGs3bR7s880joybQ@public.gmane.org>
Subject: [PATCH v17 04/10] landlock: Add ptrace restrictions
Date: Mon, 11 May 2020 21:21:50 +0200
Message-ID: <20200511192156.1618284-5-mic@digikod.net>
References: <20200511192156.1618284-1-mic@digikod.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200511192156.1618284-1-mic-WFhQfpSGs3bR7s880joybQ@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic-WFhQfpSGs3bR7s880joybQ@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Casey Schaufler <casey-iSGtlc1asvQWG2LlvL+J4A@public.gmane.org>, James Morris <jmorris-gx6/JNMH7DfYtjvyW6yDsg@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Michael Kerrisk <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mickael.salaun-D9rjmswh09VWj0EZb7rXcA@public.gmane.org>, "Serge E . Hallyn" <serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org>, Shuah Khan <shuah-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vincent Dagonneau <vincent.dagonneau-D9rjmswh09VWj0EZb7rXcA@public.gmane.org>, kernel-hardening-ZwoEplunGu1jrUoiu81ncdBPR1lH4CV8@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kselftest-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-security-
List-Id: linux-arch.vger.kernel.org

Using ptrace(2) and related debug features on a target process can lead
to a privilege escalation.  Indeed, ptrace(2) can be used by an attacker
to impersonate another task and to remain undetected while performing
malicious activities.  Thanks to  ptrace_may_access(), various part of
the kernel can check if a tracer is more privileged than a tracee.

A landlocked process has fewer privileges than a non-landlocked process
and must then be subject to additional restrictions when manipulating
processes. To be allowed to use ptrace(2) and related syscalls on a
target process, a landlocked process must have a subset of the target
process' rules (i.e. the tracee must be in a sub-domain of the tracer).

Signed-off-by: Mickaël Salaün <mic-WFhQfpSGs3bR7s880joybQ@public.gmane.org>
Cc: James Morris <jmorris-gx6/JNMH7DfYtjvyW6yDsg@public.gmane.org>
Cc: Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Serge E. Hallyn <serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org>
---

Changes since v14:
* Constify variables.

Changes since v13:
* Make the ptrace restriction mandatory, like in the v10.
* Remove the eBPF dependency.

Previous changes:
https://lore.kernel.org/lkml/20191104172146.30797-5-mic-WFhQfpSGs3bR7s880joybQ@public.gmane.org/
---
 security/landlock/Makefile |   2 +-
 security/landlock/ptrace.c | 120 +++++++++++++++++++++++++++++++++++++
 security/landlock/ptrace.h |  14 +++++
 security/landlock/setup.c  |   2 +
 4 files changed, 137 insertions(+), 1 deletion(-)
 create mode 100644 security/landlock/ptrace.c
 create mode 100644 security/landlock/ptrace.h

diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index 041ea242e627..f1d1eb72fa76 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -1,4 +1,4 @@
 obj-$(CONFIG_SECURITY_LANDLOCK) := landlock.o
 
 landlock-y := setup.o object.o ruleset.o \
-	cred.o
+	cred.o ptrace.o
diff --git a/security/landlock/ptrace.c b/security/landlock/ptrace.c
new file mode 100644
index 000000000000..61df38b13f5c
--- /dev/null
+++ b/security/landlock/ptrace.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock LSM - Ptrace hooks
+ *
+ * Copyright © 2017-2020 Mickaël Salaün <mic-WFhQfpSGs3bR7s880joybQ@public.gmane.org>
+ * Copyright © 2020 ANSSI
+ */
+
+#include <asm/current.h>
+#include <linux/cred.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/lsm_hooks.h>
+#include <linux/rcupdate.h>
+#include <linux/sched.h>
+
+#include "common.h"
+#include "cred.h"
+#include "ptrace.h"
+#include "ruleset.h"
+#include "setup.h"
+
+/**
+ * domain_scope_le - Checks domain ordering for scoped ptrace
+ *
+ * @parent: Parent domain.
+ * @child: Potential child of @parent.
+ *
+ * Checks if the @parent domain is less or equal to (i.e. an ancestor, which
+ * means a subset of) the @child domain.
+ */
+static bool domain_scope_le(const struct landlock_ruleset *const parent,
+		const struct landlock_ruleset *const child)
+{
+	const struct landlock_hierarchy *walker;
+
+	if (!parent)
+		return true;
+	if (!child)
+		return false;
+	for (walker = child->hierarchy; walker; walker = walker->parent) {
+		if (walker == parent->hierarchy)
+			/* @parent is in the scoped hierarchy of @child. */
+			return true;
+	}
+	/* There is no relationship between @parent and @child. */
+	return false;
+}
+
+static bool task_is_scoped(const struct task_struct *const parent,
+		const struct task_struct *const child)
+{
+	bool is_scoped;
+	const struct landlock_ruleset *dom_parent, *dom_child;
+
+	rcu_read_lock();
+	dom_parent = landlock_get_task_domain(parent);
+	dom_child = landlock_get_task_domain(child);
+	is_scoped = domain_scope_le(dom_parent, dom_child);
+	rcu_read_unlock();
+	return is_scoped;
+}
+
+static int task_ptrace(const struct task_struct *const parent,
+		const struct task_struct *const child)
+{
+	/* Quick return for non-landlocked tasks. */
+	if (!landlocked(parent))
+		return 0;
+	if (task_is_scoped(parent, child))
+		return 0;
+	return -EPERM;
+}
+
+/**
+ * hook_ptrace_access_check - Determines whether the current process may access
+ *			      another
+ *
+ * @child: Process to be accessed.
+ * @mode: Mode of attachment.
+ *
+ * If the current task has Landlock rules, then the child must have at least
+ * the same rules.  Else denied.
+ *
+ * Determines whether a process may access another, returning 0 if permission
+ * granted, -errno if denied.
+ */
+static int hook_ptrace_access_check(struct task_struct *const child,
+		const unsigned int mode)
+{
+	return task_ptrace(current, child);
+}
+
+/**
+ * hook_ptrace_traceme - Determines whether another process may trace the
+ *			 current one
+ *
+ * @parent: Task proposed to be the tracer.
+ *
+ * If the parent has Landlock rules, then the current task must have the same
+ * or more rules.  Else denied.
+ *
+ * Determines whether the nominated task is permitted to trace the current
+ * process, returning 0 if permission is granted, -errno if denied.
+ */
+static int hook_ptrace_traceme(struct task_struct *const parent)
+{
+	return task_ptrace(parent, current);
+}
+
+static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(ptrace_access_check, hook_ptrace_access_check),
+	LSM_HOOK_INIT(ptrace_traceme, hook_ptrace_traceme),
+};
+
+__init void landlock_add_hooks_ptrace(void)
+{
+	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
+			LANDLOCK_NAME);
+}
diff --git a/security/landlock/ptrace.h b/security/landlock/ptrace.h
new file mode 100644
index 000000000000..6740c6a723de
--- /dev/null
+++ b/security/landlock/ptrace.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock LSM - Ptrace hooks
+ *
+ * Copyright © 2017-2019 Mickaël Salaün <mic-WFhQfpSGs3bR7s880joybQ@public.gmane.org>
+ * Copyright © 2019 ANSSI
+ */
+
+#ifndef _SECURITY_LANDLOCK_PTRACE_H
+#define _SECURITY_LANDLOCK_PTRACE_H
+
+__init void landlock_add_hooks_ptrace(void);
+
+#endif /* _SECURITY_LANDLOCK_PTRACE_H */
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index 39ee1766f175..5e7540fdeefa 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -11,6 +11,7 @@
 
 #include "common.h"
 #include "cred.h"
+#include "ptrace.h"
 #include "setup.h"
 
 struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
@@ -20,6 +21,7 @@ struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
 static int __init landlock_init(void)
 {
 	landlock_add_hooks_cred();
+	landlock_add_hooks_ptrace();
 	pr_info("Up and running.\n");
 	return 0;
 }
-- 
2.26.2
