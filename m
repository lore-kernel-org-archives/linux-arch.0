From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/3] compat: add a compat_need_64bit_alignment_fixup() helper
Date: Fri, 31 Jul 2020 14:22:01 +0200
Message-ID: <20200731122202.213333-3-hch@lst.de>
References: <20200731122202.213333-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200731122202.213333-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, Jan Kara <jack@suse.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Add a helper to check if the calling syscall needs a fixup for
non-natural 64-bit type alignment in the compat ABI.  This will only
return true for i386 syscalls on x86_64.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/compat.h | 1 +
 include/linux/compat.h        | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index bf547701f41f87..0e327a01f50fbb 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -209,6 +209,7 @@ static inline bool in_compat_syscall(void)
 	return in_32bit_syscall();
 }
 #define in_compat_syscall in_compat_syscall	/* override the generic impl */
+#define compat_need_64bit_alignment_fixup in_ia32_syscall
 #endif
 
 struct compat_siginfo;
diff --git a/include/linux/compat.h b/include/linux/compat.h
index e90100c0de72e4..a195f90f156cf6 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -937,6 +937,15 @@ static inline bool in_compat_syscall(void) { return false; }
 
 #endif /* CONFIG_COMPAT */
 
+/*
+ * Some legacy ABIs like the i386 one use less than natural alignment for 64-bit
+ * types, and will need special compat treatment for that.  Most architectures
+ * don't need that special handling even for compat syscalls.
+ */
+#ifndef compat_need_64bit_alignment_fixup
+#define compat_need_64bit_alignment_fixup()		false
+#endif
+
 /*
  * A pointer passed in from user mode. This should not
  * be used for syscall parameters, just declare them
-- 
2.27.0
