Return-Path: <SRS0=nIgR=6W=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728060AbgEHMhS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 May 2020 08:37:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.4 032/312] MIPS: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
Date: Fri,  8 May 2020 14:30:23 +0200
Message-ID: <20200508123126.743335733@linuxfoundation.org>
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org, linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
Message-ID: <20200508123023.EpSGvHpsVrfg51FSPVRAxNhAAJn6kVxYqkIhWqXT0MI@z>

From: James Hogan <james.hogan@imgtec.com>

commit 233b2ca181f20674ecad11be90b00814911ce345 upstream.

AT_VECTOR_SIZE_ARCH should be defined with the maximum number of
NEW_AUX_ENT entries that ARCH_DLINFO can contain, but it wasn't defined
for MIPS at all even though ARCH_DLINFO will contain one NEW_AUX_ENT for
the VDSO address.

This shouldn't be a problem as AT_VECTOR_SIZE_BASE includes space for
AT_BASE_PLATFORM which MIPS doesn't use, but lets define it now and add
the comment above ARCH_DLINFO as found in several other architectures to
remind future modifiers of ARCH_DLINFO to keep AT_VECTOR_SIZE_ARCH up to
date.

Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/13823/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/elf.h         |    1 +
 arch/mips/include/uapi/asm/auxvec.h |    2 ++
 2 files changed, 3 insertions(+)

--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -420,6 +420,7 @@ extern const char *__elf_platform;
 #define ELF_ET_DYN_BASE		(TASK_SIZE / 3 * 2)
 #endif
 
+/* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
 #define ARCH_DLINFO							\
 do {									\
 	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
--- a/arch/mips/include/uapi/asm/auxvec.h
+++ b/arch/mips/include/uapi/asm/auxvec.h
@@ -14,4 +14,6 @@
 /* Location of VDSO image. */
 #define AT_SYSINFO_EHDR		33
 
+#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
+
 #endif /* __ASM_AUXVEC_H */
