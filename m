Return-Path: <SRS0=T8h9=7D=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63545 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730521AbgEUVRl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 May 2020 17:17:41 -0400
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH 4/5] selftest/x86: Fix sysret_rip with ENDBR
Date: Thu, 21 May 2020 14:17:19 -0700
Message-ID: <20200521211720.20236-5-yu-cheng.yu@intel.com>
In-Reply-To: <20200521211720.20236-1-yu-cheng.yu@intel.com>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Message-ID: <20200521211719.EGQBS_JCNkmOcJkCsnf-iszvdy_Wkr1jcxj_Xik4oyI@z>

Insert endbr64 to assembly code of sysret_rip.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 tools/testing/selftests/x86/sysret_rip.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/sysret_rip.c b/tools/testing/selftests/x86/sysret_rip.c
index 84d74be1d902..027682a0f377 100644
--- a/tools/testing/selftests/x86/sysret_rip.c
+++ b/tools/testing/selftests/x86/sysret_rip.c
@@ -27,8 +27,9 @@ asm (
 	".pushsection \".text\", \"ax\"\n\t"
 	".balign 4096\n\t"
 	"test_page: .globl test_page\n\t"
-	".fill 4094,1,0xcc\n\t"
+	".fill 4090,1,0xcc\n\t"
 	"test_syscall_insn:\n\t"
+	"endbr64\n\t"
 	"syscall\n\t"
 	".ifne . - test_page - 4096\n\t"
 	".error \"test page is not one page long\"\n\t"
@@ -151,7 +152,7 @@ static void test_syscall_fallthrough_to(unsigned long ip)
 
 	if (sigsetjmp(jmpbuf, 1) == 0) {
 		asm volatile ("call *%[syscall_insn]" :: "a" (SYS_getpid),
-			      [syscall_insn] "rm" (ip - 2));
+			      [syscall_insn] "rm" (ip - 6));
 		errx(1, "[FAIL]\tSyscall trampoline returned");
 	}
 
-- 
2.21.0
