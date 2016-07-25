From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 5/5] tile: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
Date: Mon, 25 Jul 2016 16:59:54 +0100
Message-ID: <1469462394-8970-6-git-send-email-james.hogan@imgtec.com>
References: <1469462394-8970-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:55688 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356AbcGYQAX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jul 2016 12:00:23 -0400
In-Reply-To: <1469462394-8970-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>, Chris Metcalf <cmetcalf@mellanox.com>

AT_VECTOR_SIZE_ARCH should be defined with the maximum number of
NEW_AUX_ENT entries that ARCH_DLINFO can contain, but it wasn't defined
for tile at all even though ARCH_DLINFO will contain one NEW_AUX_ENT for
the VDSO address.

This shouldn't be a problem as AT_VECTOR_SIZE_BASE includes space for
AT_BASE_PLATFORM which tile doesn't use, but lets define it now and add
the comment above ARCH_DLINFO as found in several other architectures to
remind future modifiers of ARCH_DLINFO to keep AT_VECTOR_SIZE_ARCH up to
date.

Fixes: 4a556f4f56da ("tile: implement gettimeofday() via vDSO")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
---
 arch/tile/include/asm/elf.h         | 1 +
 arch/tile/include/uapi/asm/auxvec.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/tile/include/asm/elf.h b/arch/tile/include/asm/elf.h
index c505d77e4d06..e9d54a06736f 100644
--- a/arch/tile/include/asm/elf.h
+++ b/arch/tile/include/asm/elf.h
@@ -129,6 +129,7 @@ extern int dump_task_regs(struct task_struct *, elf_gregset_t *);
 struct linux_binprm;
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 				       int executable_stack);
+/* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
 #define ARCH_DLINFO \
 do { \
 	NEW_AUX_ENT(AT_SYSINFO_EHDR, VDSO_BASE); \
diff --git a/arch/tile/include/uapi/asm/auxvec.h b/arch/tile/include/uapi/asm/auxvec.h
index c93e92709f14..f497123ed980 100644
--- a/arch/tile/include/uapi/asm/auxvec.h
+++ b/arch/tile/include/uapi/asm/auxvec.h
@@ -18,4 +18,6 @@
 /* The vDSO location. */
 #define AT_SYSINFO_EHDR         33
 
+#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
+
 #endif /* _ASM_TILE_AUXVEC_H */
-- 
2.4.10
