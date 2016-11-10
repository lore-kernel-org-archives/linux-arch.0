Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-cys01nam02on0073.outbound.protection.outlook.com ([104.47.37.73]:25039
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932295AbcKJAvl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Nov 2016 19:51:41 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [RFC PATCH v3 14/20] iommu/amd: Disable AMD IOMMU if memory
 encryption is active
Date: Wed, 9 Nov 2016 18:37:32 -0600
Message-ID: <20161110003731.3280.67205.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <20161110003426.3280.2999.stgit@tlendack-t1.amdoffice.net>
References: <20161110003426.3280.2999.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc: Rik van Riel <riel@redhat.com>, Radim =?utf-8?b?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20161110003732.c9veQnCYBhUdHIBUGhoWl85plMK9XrujT6k7a5P6DOk@z>

For now, disable the AMD IOMMU if memory encryption is active. A future
patch will re-enable the function with full memory encryption support.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 drivers/iommu/amd_iommu_init.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 59741ea..136a24e 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -27,6 +27,7 @@
 #include <linux/amd-iommu.h>
 #include <linux/export.h>
 #include <linux/iommu.h>
+#include <linux/mem_encrypt.h>
 #include <asm/pci-direct.h>
 #include <asm/iommu.h>
 #include <asm/gart.h>
@@ -2388,6 +2389,10 @@ int __init amd_iommu_detect(void)
 	if (amd_iommu_disabled)
 		return -ENODEV;
 
+	/* For now, disable the IOMMU if SME is active */
+	if (sme_me_mask)
+		return -ENODEV;
+
 	ret = iommu_go_to_state(IOMMU_IVRS_DETECTED);
 	if (ret)
 		return ret;

