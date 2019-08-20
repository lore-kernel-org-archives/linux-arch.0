Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:37860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbfHTJ6b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 05:58:31 -0400
From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 1/2] ELF: UAPI and Kconfig additions for ELF program properties
Date: Tue, 20 Aug 2019 10:57:42 +0100
Message-ID: <1566295063-7387-2-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1566295063-7387-1-git-send-email-Dave.Martin@arm.com>
References: <1566295063-7387-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20190820095742.0xU8qRgyq9amLn_VeS7X-Iav5FFl_eJkpMNMrDu5HLY@z>

Pull the basic ELF definitions from Yu-Cheng Yu's series.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

This patch should be merged with the next patch.

I kept it seprate for now to document where this code came from.
---
 fs/Kconfig.binfmt        | 3 +++
 include/uapi/linux/elf.h | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 62dc4f5..d2cfe07 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -36,6 +36,9 @@ config COMPAT_BINFMT_ELF
 config ARCH_BINFMT_ELF_STATE
 	bool
 
+config ARCH_USE_GNU_PROPERTY
+	bool
+
 config BINFMT_ELF_FDPIC
 	bool "Kernel support for FDPIC ELF binaries"
 	default y if !BINFMT_ELF
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 34c02e4..a3eaad9 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -36,6 +36,7 @@ typedef __s64	Elf64_Sxword;
 #define PT_LOPROC  0x70000000
 #define PT_HIPROC  0x7fffffff
 #define PT_GNU_EH_FRAME		0x6474e550
+#define PT_GNU_PROPERTY		0x6474e553
 
 #define PT_GNU_STACK	(PT_LOOS + 0x474e551)
 
@@ -443,4 +444,10 @@ typedef struct elf64_note {
   Elf64_Word n_type;	/* Content type */
 } Elf64_Nhdr;
 
+/* NT_GNU_PROPERTY_TYPE_0 header */
+struct gnu_property {
+  __u32 pr_type;
+  __u32 pr_datasz;
+};
+
 #endif /* _UAPI_LINUX_ELF_H */
-- 
2.1.4
