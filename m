Return-Path: <SRS0=06hN=5A=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-mw2nam10on2097.outbound.protection.outlook.com ([40.107.94.97]:13053
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727320AbgCOBbj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 14 Mar 2020 21:31:39 -0400
From: Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v6 02/10] arm/arm64: smccc-1.1: Add vendor specific owner definition
Date: Sat, 14 Mar 2020 08:35:11 -0700
Message-ID: <1584200119-18594-3-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: will@kernel.org, ardb@kernel.org, arnd@arndb.de, catalin.marinas@arm.com, mark.rutland@arm.com, maz@kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com, jasowang@redhat.com, marcelo.cerri@canonical.com, kys@microsoft.com
Cc: mikelley@microsoft.com, sunilmut@microsoft.com, boqun.feng@gmail.com
Message-ID: <20200314153511.AfsgMa9UBtK_WiPRdeHBJDIFVs8eNA6z2_00ImLd6eQ@z>

In the SMCCC v1.1 spec, the Owning Entity Number in the Function
Identifier may have a value of 6 for a vendor specific hypervisor
service call. Add this #define.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 include/linux/arm-smccc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 59494df..8229203 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -46,6 +46,7 @@
 #define ARM_SMCCC_OWNER_OEM		3
 #define ARM_SMCCC_OWNER_STANDARD	4
 #define ARM_SMCCC_OWNER_STANDARD_HYP	5
+#define ARM_SMCCC_OWNER_VENDOR_HYP	6
 #define ARM_SMCCC_OWNER_TRUSTED_APP	48
 #define ARM_SMCCC_OWNER_TRUSTED_APP_END	49
 #define ARM_SMCCC_OWNER_TRUSTED_OS	50
-- 
1.8.3.1
