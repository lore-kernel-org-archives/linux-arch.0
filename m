Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:51136 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbfFFURf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Jun 2019 16:17:35 -0400
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v7 11/14] x86/vsyscall/64: Add ENDBR64 to vsyscall entry points
Date: Thu,  6 Jun 2019 13:09:23 -0700
Message-ID: <20190606200926.4029-12-yu-cheng.yu@intel.com>
In-Reply-To: <20190606200926.4029-1-yu-cheng.yu@intel.com>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190606200923.SKut4RnovZpV3wlPCKgHa4ZjFCA7eCVETuvA_rdddQ8@z>

From: "H.J. Lu" <hjl.tools@gmail.com>

Add ENDBR64 to vsyscall entry points.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/vsyscall/vsyscall_emu_64.S | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/entry/vsyscall/vsyscall_emu_64.S b/arch/x86/entry/vsyscall/vsyscall_emu_64.S
index 2e203f3a25a7..040696333457 100644
--- a/arch/x86/entry/vsyscall/vsyscall_emu_64.S
+++ b/arch/x86/entry/vsyscall/vsyscall_emu_64.S
@@ -17,16 +17,25 @@ __PAGE_ALIGNED_DATA
 	.type __vsyscall_page, @object
 __vsyscall_page:
 
+#ifdef CONFIG_X86_INTEL_BRANCH_TRACKING_USER
+	endbr64
+#endif
 	mov $__NR_gettimeofday, %rax
 	syscall
 	ret
 
 	.balign 1024, 0xcc
+#ifdef CONFIG_X86_INTEL_BRANCH_TRACKING_USER
+	endbr64
+#endif
 	mov $__NR_time, %rax
 	syscall
 	ret
 
 	.balign 1024, 0xcc
+#ifdef CONFIG_X86_INTEL_BRANCH_TRACKING_USER
+	endbr64
+#endif
 	mov $__NR_getcpu, %rax
 	syscall
 	ret
-- 
2.17.1
