Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:49632 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752095AbdKFI6f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Nov 2017 03:58:35 -0500
From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH v9 05/51] powerpc: helper function to read,write AMR,IAMR,UAMOR registers
Date: Mon,  6 Nov 2017 00:56:57 -0800
Message-ID: <1509958663-18737-6-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
Message-ID: <20171106085657.2U_ijvAB7gK0pb4OKbxFPcqr8KYa-G4XTk3yfxdsug8@z>

Implements helper functions to read and write the key related
registers; AMR, IAMR, UAMOR.

AMR register tracks the read,write permission of a key
IAMR register tracks the execute permission of a key
UAMOR register enables and disables a key

Acked-by: Balbir Singh <bsingharora@gmail.com>
Reviewed-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/mm/pkeys.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 512bdf2..b6bdfdf 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -61,3 +61,39 @@ void __init pkey_initialize(void)
 	for (i = 2; i < (pkeys_total - os_reserved); i++)
 		initial_allocation_mask &= ~(0x1 << i);
 }
+
+static inline u64 read_amr(void)
+{
+	return mfspr(SPRN_AMR);
+}
+
+static inline void write_amr(u64 value)
+{
+	mtspr(SPRN_AMR, value);
+}
+
+static inline u64 read_iamr(void)
+{
+	if (!likely(pkey_execute_disable_supported))
+		return 0x0UL;
+
+	return mfspr(SPRN_IAMR);
+}
+
+static inline void write_iamr(u64 value)
+{
+	if (!likely(pkey_execute_disable_supported))
+		return;
+
+	mtspr(SPRN_IAMR, value);
+}
+
+static inline u64 read_uamor(void)
+{
+	return mfspr(SPRN_UAMOR);
+}
+
+static inline void write_uamor(u64 value)
+{
+	mtspr(SPRN_UAMOR, value);
+}
-- 
1.7.1
