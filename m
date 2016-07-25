From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 3/5] arm64: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
Date: Mon, 25 Jul 2016 16:59:52 +0100
Message-ID: <1469462394-8970-4-git-send-email-james.hogan@imgtec.com>
References: <1469462394-8970-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469462394-8970-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

AT_VECTOR_SIZE_ARCH should be defined with the maximum number of
NEW_AUX_ENT entries that ARCH_DLINFO can contain, but it wasn't defined
for arm64 at all even though ARCH_DLINFO will contain one NEW_AUX_ENT
for the VDSO address.

This shouldn't be a problem as AT_VECTOR_SIZE_BASE includes space for
AT_BASE_PLATFORM which arm64 doesn't use, but lets define it now and add
the comment above ARCH_DLINFO as found in several other architectures to
remind future modifiers of ARCH_DLINFO to keep AT_VECTOR_SIZE_ARCH up to
date.

Fixes: f668cd1673aa ("arm64: ELF definitions")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/elf.h         | 1 +
 arch/arm64/include/uapi/asm/auxvec.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 579b6e654f2d..a55384f4a5d7 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -140,6 +140,7 @@ typedef struct user_fpsimd_state elf_fpregset_t;
 
 #define SET_PERSONALITY(ex)		clear_thread_flag(TIF_32BIT);
 
+/* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
 #define ARCH_DLINFO							\
 do {									\
 	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
diff --git a/arch/arm64/include/uapi/asm/auxvec.h b/arch/arm64/include/uapi/asm/auxvec.h
index 22d6d8885854..4cf0c17787a8 100644
--- a/arch/arm64/include/uapi/asm/auxvec.h
+++ b/arch/arm64/include/uapi/asm/auxvec.h
@@ -19,4 +19,6 @@
 /* vDSO location */
 #define AT_SYSINFO_EHDR	33
 
+#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
+
 #endif
-- 
2.4.10
