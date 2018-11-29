Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40094 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730385AbeK3EMp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Nov 2018 23:12:45 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v2 20/28] arm64: elf: vDSO code page discovery
Date: Thu, 29 Nov 2018 17:05:22 +0000
Message-ID: <20181129170530.37789-21-vincenzo.frascino@arm.com>
In-Reply-To: <20181129170530.37789-1-vincenzo.frascino@arm.com>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181129170522.ngQUT05JYSZoQsdnaI-qDFalgvjUaTgbdhFyWs-HKwE@z>

Like in normal vDSOs, when compat vDSOs are enabled the auxiliary
vector symbol AT_SYSINFO_EHDR needs to point at the address of the
vDSO code, to allow the dynamic linker to find it.

This patch adds the necessary code to the elf arm64 module to make this
possible.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/elf.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index f2b6b486deb7..3fb46968da6a 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -209,7 +209,21 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 ({									\
 	set_thread_flag(TIF_32BIT);					\
  })
+#ifdef CONFIG_GENERIC_COMPAT_VDSO
+#define COMPAT_ARCH_DLINFO						\
+do {									\
+	/*								\
+	 * Note that we use Elf64_Off instead of elf_addr_t because	\
+	 * elf_addr_t in compat is defined as Elf32_Addr and casting	\
+	 * current->mm->context.vdso to it triggers a cast warning of	\
+	 * cast from pointer to integer of different size.		\
+	 */								\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
+			(Elf64_Off)current->mm->context.vdso);		\
+} while (0)
+#else
 #define COMPAT_ARCH_DLINFO
+#endif
 extern int aarch32_setup_additional_pages(struct linux_binprm *bprm,
 					  int uses_interp);
 #define compat_arch_setup_additional_pages \
-- 
2.19.2
