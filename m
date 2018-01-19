Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37172 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755465AbeASBvz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jan 2018 20:51:55 -0500
From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH v10 05/27] powerpc: helper function to read,write AMR,IAMR,UAMOR registers
Date: Thu, 18 Jan 2018 17:50:26 -0800
Message-ID: <1516326648-22775-6-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1516326648-22775-1-git-send-email-linuxram@us.ibm.com>
References: <1516326648-22775-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
Message-ID: <20180119015026.N-4mmoZw1yNZNhl9EQVa8L4sd3st40mjijPdiUYqRiw@z>

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
index e2f3992..6e8df6e 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -71,3 +71,39 @@ void pkey_mm_init(struct mm_struct *mm)
 		return;
 	mm_pkey_allocation_map(mm) = initial_allocation_mask;
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
