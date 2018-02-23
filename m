Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40256 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbeBWKmg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Feb 2018 05:42:36 -0500
Received: by mail-wm0-f65.google.com with SMTP id t82so3714179wmt.5
        for <linux-arch@vger.kernel.org>; Fri, 23 Feb 2018 02:42:35 -0800 (PST)
From: Jack Wang <jinpu.wang@profitbricks.com>
Subject: [stable 4.4 12/29] x86: Implement array_index_mask_nospec
Date: Fri, 23 Feb 2018 11:42:01 +0100
Message-ID: <1519382538-15143-13-git-send-email-jinpu.wangl@profitbricks.com>
In-Reply-To: <1519382538-15143-1-git-send-email-jinpu.wangl@profitbricks.com>
References: <1519382538-15143-1-git-send-email-jinpu.wangl@profitbricks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, kernel-hardening@lists.openwall.com, alan@linux.intel.com, David Woodhouse <dwmw@amazon.co.uk>, Jack Wang <jinpu.wang@profitbricks.com>
Message-ID: <20180223104201.-ZFe3e3PUQeufOs45QOi0_1kpy7PtfVDzX7cJRqJKdA@z>

From: Dan Williams <dan.j.williams@intel.com>

(cherry picked from commit babdde2698d482b6c0de1eab4f697cf5856c5859)

array_index_nospec() uses a mask to sanitize user controllable array
indexes, i.e. generate a 0 mask if 'index' >= 'size', and a ~0 mask
otherwise. While the default array_index_mask_nospec() handles the
carry-bit from the (index - size) result in software.

The x86 array_index_mask_nospec() does the same, but the carry-bit is
handled in the processor CF flag without conditional instructions in the
control flow.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727414808.33451.1873237130672785331.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[jwang:chery pick to 4.4]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
---
 arch/x86/include/asm/barrier.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 0681d25..b5028e3 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -24,6 +24,30 @@
 #define wmb()	asm volatile("sfence" ::: "memory")
 #endif
 
+/**
+ * array_index_mask_nospec() - generate a mask that is ~0UL when the
+ * 	bounds check succeeds and 0 otherwise
+ * @index: array element index
+ * @size: number of elements in array
+ *
+ * Returns:
+ *     0 - (index < size)
+ */
+static inline unsigned long array_index_mask_nospec(unsigned long index,
+		unsigned long size)
+{
+	unsigned long mask;
+
+	asm ("cmp %1,%2; sbb %0,%0;"
+			:"=r" (mask)
+			:"r"(size),"r" (index)
+			:"cc");
+	return mask;
+}
+
+/* Override the default implementation from linux/nospec.h. */
+#define array_index_mask_nospec array_index_mask_nospec
+
 #ifdef CONFIG_X86_PPRO_FENCE
 #define dma_rmb()	rmb()
 #else
-- 
2.7.4
