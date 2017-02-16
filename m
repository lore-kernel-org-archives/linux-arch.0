Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-sn1nam01on0048.outbound.protection.outlook.com ([104.47.32.48]:31811
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932326AbdBPPqn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Feb 2017 10:46:43 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [RFC PATCH v4 20/28] iommu/amd: Disable AMD IOMMU if memory
 encryption is active
Date: Thu, 16 Feb 2017 09:46:32 -0600
Message-ID: <20170216154632.19244.26080.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <20170216154158.19244.66630.stgit@tlendack-t1.amdoffice.net>
References: <20170216154158.19244.66630.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc: Rik van Riel <riel@redhat.com>, Radim =?utf-8?b?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Alexander Potapenko <glider@google.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Larry Woodman <lwoodman@redhat.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170216154632.9bLc7HUiqS02zd0CUzhCSzFhuwILPFI5sQtRWe4pWII@z>

For now, disable the AMD IOMMU if memory encryption is active. A future
patch will re-enable the function with full memory encryption support.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 drivers/iommu/amd_iommu_init.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 6799cf9..6df2dd5 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -29,6 +29,7 @@
 #include <linux/export.h>
 #include <linux/iommu.h>
 #include <linux/kmemleak.h>
+#include <linux/mem_encrypt.h>
 #include <asm/pci-direct.h>
 #include <asm/iommu.h>
 #include <asm/gart.h>
@@ -2544,6 +2545,12 @@ int __init amd_iommu_detect(void)
 	if (amd_iommu_disabled)
 		return -ENODEV;
 
+	/* For now, disable the IOMMU if SME is active */
+	if (sme_active()) {
+		pr_notice("AMD-Vi: SME is active, disabling the IOMMU\n");
+		return -ENODEV;
+	}
+
 	ret = iommu_go_to_state(IOMMU_IVRS_DETECTED);
 	if (ret)
 		return ret;
