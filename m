Return-Path: <SRS0=06hN=5A=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-mw2nam10on2123.outbound.protection.outlook.com ([40.107.94.123]:18974
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727401AbgCOBbx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 14 Mar 2020 21:31:53 -0400
From: Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v6 04/10] arm64: hyperv: Add memory alloc/free functions for Hyper-V size pages
Date: Sat, 14 Mar 2020 08:35:13 -0700
Message-ID: <1584200119-18594-5-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: will@kernel.org, ardb@kernel.org, arnd@arndb.de, catalin.marinas@arm.com, mark.rutland@arm.com, maz@kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com, jasowang@redhat.com, marcelo.cerri@canonical.com, kys@microsoft.com
Cc: mikelley@microsoft.com, sunilmut@microsoft.com, boqun.feng@gmail.com
Message-ID: <20200314153513.BtCjuIfLjECjPDcCJha5BXyM5mxxV_BL7ip_hSWswLc@z>

Add ARM64-specific code to allocate memory with HV_HYP_PAGE_SIZE
size and alignment. These are for use when pages need to be shared
with Hyper-V. Separate functions are needed as the page size used
by Hyper-V may not be the same as the guest page size.

This code is built only when CONFIG_HYPERV is enabled.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/arm64/hyperv/hv_core.c    | 34 ++++++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h |  5 +++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
index 272c348..4aa6b8f 100644
--- a/arch/arm64/hyperv/hv_core.c
+++ b/arch/arm64/hyperv/hv_core.c
@@ -17,12 +17,46 @@
 #include <linux/slab.h>
 #include <linux/hyperv.h>
 #include <linux/arm-smccc.h>
+#include <linux/string.h>
 #include <asm-generic/bug.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
 
 
 /*
+ * Functions for allocating and freeing memory with size and
+ * alignment HV_HYP_PAGE_SIZE. These functions are needed because
+ * the guest page size may not be the same as the Hyper-V page
+ * size. We depend upon kmalloc() aligning power-of-two size
+ * allocations to the allocation size boundary, so that the
+ * allocated memory appears to Hyper-V as a page of the size
+ * it expects.
+ *
+ * These functions are used by arm64 specific code as well as
+ * arch independent Hyper-V drivers.
+ */
+
+void *hv_alloc_hyperv_page(void)
+{
+	BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
+	return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
+
+void *hv_alloc_hyperv_zeroed_page(void)
+{
+	return kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(hv_alloc_hyperv_zeroed_page);
+
+void hv_free_hyperv_page(unsigned long addr)
+{
+	kfree((void *)addr);
+}
+EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
+
+
+/*
  * hv_do_hypercall- Invoke the specified hypercall
  */
 u64 hv_do_hypercall(u64 control, void *input, void *output)
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index b3f1082..1a7c4c5 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -99,6 +99,11 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
 void hv_remove_crash_handler(void);
 
+void *hv_alloc_hyperv_page(void);
+void *hv_alloc_hyperv_zeroed_page(void);
+void hv_free_hyperv_page(unsigned long addr);
+
+
 #if IS_ENABLED(CONFIG_HYPERV)
 /*
  * Hypervisor's notion of virtual processor ID is different from
-- 
1.8.3.1
