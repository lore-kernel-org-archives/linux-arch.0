Return-Path: <SRS0=g7wM=BF=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgGZQEO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Jul 2020 12:04:14 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/4] compat: add a compat_need_64bit_alignment_fixup() helper
Date: Sun, 26 Jul 2020 18:04:00 +0200
Message-ID: <20200726160401.311569-4-hch@lst.de>
In-Reply-To: <20200726160401.311569-1-hch@lst.de>
References: <20200726160401.311569-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: x86@kernel.org, Jan Kara <jack@suse.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20200726160400.O79aB-Oc2Pop4gIF1UBs9rVTO4puLgt01DU6L6MUIAE@z>

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
index c22a7f1d253b87..afdd44ba3a8869 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -945,6 +945,15 @@ static inline bool in_compat_syscall(void) { return false; }
 
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
