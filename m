From: David Howells <dhowells@redhat.com>
Subject: [PATCH 3/3] Make get_current() __attribute__((const))
Date: Tue, 18 May 2010 17:45:47 +0100
Message-ID: <20100518164547.6194.94193.stgit@warthog.procyon.org.uk>
References: <20100518164537.6194.73366.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53385 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755771Ab0ERRhI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 18 May 2010 13:37:08 -0400
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o4IHb8ce025104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Tue, 18 May 2010 13:37:08 -0400
In-Reply-To: <20100518164537.6194.73366.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: oleg@redhat.com, linux-arch@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>

get_current() can be made __attribute__((const)) as it's not allowed to change
under you, except in switch_to() (it's fine to violate the constness there
since this switches stacks too, and will almost certainly do this in assembly
code).  This allows the compiler more choices about when it can cache this
pointer.

This doesn't break cached copies of current, whether they're cached by gcc in
registers or on the stack.  switch_to() will save all registers on the stack
before actually switching, then when it switches current, it will also switch
the stack and then pop back what was stored in the 'unclobbered' registers for
the now active task and stack.  Thus the copies of current that were cached
just work.

Note that does not affect all arches under all circumstances.  Some arches, at
least some of the time, keep current in a register, and some use thread_info as
the source of current.

This has been the norm on ARM and MN10300 arches (the latter only when not
using E2 to hold current) for a while now.  I've also tested this on x86_64.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/powerpc/include/asm/current.h |    3 ++-
 arch/x86/include/asm/current.h     |    3 ++-
 include/asm-generic/current.h      |    9 ++++++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/current.h b/arch/powerpc/include/asm/current.h
index 4ca5126..affcbbe 100644
--- a/arch/powerpc/include/asm/current.h
+++ b/arch/powerpc/include/asm/current.h
@@ -15,7 +15,8 @@ struct task_struct;
 #include <linux/stddef.h>
 #include <asm/paca.h>
 
-static inline struct task_struct *get_current(void)
+static inline __attribute_const__
+struct task_struct *get_current(void)
 {
 	struct task_struct *task;
 
diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 4d447b7..defb13c 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -9,7 +9,8 @@ struct task_struct;
 
 DECLARE_PER_CPU(struct task_struct *, current_task);
 
-static __always_inline struct task_struct *get_current(void)
+static __always_inline __attribute_const__
+struct task_struct *get_current(void)
 {
 	return percpu_read_stable(current_task);
 }
diff --git a/include/asm-generic/current.h b/include/asm-generic/current.h
index 5e86f6a..8deb67e 100644
--- a/include/asm-generic/current.h
+++ b/include/asm-generic/current.h
@@ -3,7 +3,14 @@
 
 #include <linux/thread_info.h>
 
-#define get_current() (current_thread_info()->task)
+struct task_struct;
+
+static inline __attribute_const__
+struct task_struct *get_current(void)
+{
+	return current_thread_info()->task;
+}
+
 #define current get_current()
 
 #endif /* __ASM_GENERIC_CURRENT_H */
