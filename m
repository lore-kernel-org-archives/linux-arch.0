Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f73.google.com ([209.85.215.73]:40860 "EHLO
	mail-la0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965726AbaKNQXK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Nov 2014 11:23:10 -0500
Received: by mail-la0-f73.google.com with SMTP id q1so1475310lam.0
        for <linux-arch@vger.kernel.org>; Fri, 14 Nov 2014 08:23:08 -0800 (PST)
From: David Drysdale <drysdale@google.com>
Subject: [PATCHv8 3/4] sparc: Hook up execveat system call.
Date: Fri, 14 Nov 2014 16:23:02 +0000
Message-ID: <1415982183-20525-4-git-send-email-drysdale@google.com>
In-Reply-To: <1415982183-20525-1-git-send-email-drysdale@google.com>
References: <1415982183-20525-1-git-send-email-drysdale@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>, Andy Lutomirski <luto@amacapital.net>, Alexander Viro <viro@zeniv.linux.org.uk>, Meredydd Luff <meredydd@senatehouse.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>
Cc: Oleg Nesterov <oleg@redhat.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@aerifal.cx>, Christoph Hellwig <hch@infradead.org>, x86@kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, sparclinux@vger.kernel.org, David Drysdale <drysdale@google.com>
Message-ID: <20141114162302.y4s_6yBGCR4D3errXTae0pFCjEF2v3-LeYRVIdX1--w@z>

Signed-off-by: David Drysdale <drysdale@google.com>
---
 arch/sparc/include/uapi/asm/unistd.h | 3 ++-
 arch/sparc/kernel/systbls_32.S       | 1 +
 arch/sparc/kernel/systbls_64.S       | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/uapi/asm/unistd.h b/arch/sparc/include/uapi/asm/unistd.h
index 46d83842eddc..6f35f4df17f2 100644
--- a/arch/sparc/include/uapi/asm/unistd.h
+++ b/arch/sparc/include/uapi/asm/unistd.h
@@ -415,8 +415,9 @@
 #define __NR_getrandom		347
 #define __NR_memfd_create	348
 #define __NR_bpf		349
+#define __NR_execveat		350

-#define NR_syscalls		350
+#define NR_syscalls		351

 /* Bitmask values returned from kern_features system call.  */
 #define KERN_FEATURE_MIXED_MODE_STACK	0x00000001
diff --git a/arch/sparc/kernel/systbls_32.S b/arch/sparc/kernel/systbls_32.S
index ad0cdf497b78..e31a9056a303 100644
--- a/arch/sparc/kernel/systbls_32.S
+++ b/arch/sparc/kernel/systbls_32.S
@@ -87,3 +87,4 @@ sys_call_table:
 /*335*/	.long sys_syncfs, sys_sendmmsg, sys_setns, sys_process_vm_readv, sys_process_vm_writev
 /*340*/	.long sys_ni_syscall, sys_kcmp, sys_finit_module, sys_sched_setattr, sys_sched_getattr
 /*345*/	.long sys_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create, sys_bpf
+/*350*/	.long sys_execveat
diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
index 580cde9370c9..15069cb35dac 100644
--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -88,6 +88,7 @@ sys_call_table32:
 	.word sys_syncfs, compat_sys_sendmmsg, sys_setns, compat_sys_process_vm_readv, compat_sys_process_vm_writev
 /*340*/	.word sys_kern_features, sys_kcmp, sys_finit_module, sys_sched_setattr, sys_sched_getattr
 	.word sys32_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create, sys_bpf
+/*350*/	.word sys_execveat

 #endif /* CONFIG_COMPAT */

@@ -167,3 +168,4 @@ sys_call_table:
 	.word sys_syncfs, sys_sendmmsg, sys_setns, sys_process_vm_readv, sys_process_vm_writev
 /*340*/	.word sys_kern_features, sys_kcmp, sys_finit_module, sys_sched_setattr, sys_sched_getattr
 	.word sys_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create, sys_bpf
+/*350*/	.word sys_execveat
--
2.1.0.rc2.206.gedb03e5
