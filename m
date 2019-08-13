Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:18661 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbfHMVDl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 17:03:41 -0400
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v8 06/14] x86/cet/ibt: Add arch_prctl functions for IBT
Date: Tue, 13 Aug 2019 13:53:51 -0700
Message-ID: <20190813205359.12196-7-yu-cheng.yu@intel.com>
In-Reply-To: <20190813205359.12196-1-yu-cheng.yu@intel.com>
References: <20190813205359.12196-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Message-ID: <20190813205351.wdOXXtI9xzCJFCqjPDhkDET_c4MuW-pSVdveYUmJu0A@z>

From: "H.J. Lu" <hjl.tools@gmail.com>

Update ARCH_X86_CET_STATUS and ARCH_X86_CET_DISABLE to include
Indirect Branch Tracking features.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/uapi/asm/prctl.h | 2 ++
 arch/x86/kernel/cet_prctl.c       | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index d962f0ec9ccf..02243127dcf6 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -18,5 +18,7 @@
 #define ARCH_X86_CET_DISABLE		0x3002
 #define ARCH_X86_CET_LOCK		0x3003
 #define ARCH_X86_CET_ALLOC_SHSTK	0x3004
+#define ARCH_X86_CET_GET_LEGACY_BITMAP	0x3005 /* deprecated */
+#define ARCH_X86_CET_SET_LEGACY_BITMAP	0x3006 /* deprecated */
 
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/cet_prctl.c b/arch/x86/kernel/cet_prctl.c
index 9c9d4262b07e..09d8c4ea935c 100644
--- a/arch/x86/kernel/cet_prctl.c
+++ b/arch/x86/kernel/cet_prctl.c
@@ -20,6 +20,8 @@ static int handle_get_status(unsigned long arg2)
 
 	if (current->thread.cet.shstk_enabled)
 		features |= GNU_PROPERTY_X86_FEATURE_1_SHSTK;
+	if (current->thread.cet.ibt_enabled)
+		features |= GNU_PROPERTY_X86_FEATURE_1_IBT;
 
 	shstk_base = current->thread.cet.shstk_base;
 	shstk_size = current->thread.cet.shstk_size;
@@ -69,6 +71,8 @@ int prctl_cet(int option, unsigned long arg2)
 			return -EPERM;
 		if (arg2 & GNU_PROPERTY_X86_FEATURE_1_SHSTK)
 			cet_disable_free_shstk(current);
+		if (arg2 & GNU_PROPERTY_X86_FEATURE_1_IBT)
+			cet_disable_ibt();
 
 		return 0;
 
-- 
2.17.1
