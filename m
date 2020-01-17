From: Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v16 08/23] selftests/vm: Fix pkey_disable_clear()
Date: Fri, 17 Jan 2020 18:19:47 +0530
Message-ID: <2c5a7d6888e87bbe11a533e0b5c34c99829f8e5f.1579265066.git.sandipan@linux.ibm.com>
References: <cover.1579265066.git.sandipan@linux.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726761AbgAQMug (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Jan 2020 07:50:36 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00HClEKX064404
        for <linux-arch@vger.kernel.org>; Fri, 17 Jan 2020 07:50:35 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xk0qt42va-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 17 Jan 2020 07:50:35 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Fri, 17 Jan 2020 12:50:33 -0000
In-Reply-To: <cover.1579265066.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1579265066.git.sandipan@linux.ibm.com>
References: <cover.1579265066.git.sandipan@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, dave.hansen@intel.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org

From: Ram Pai <linuxram@us.ibm.com>

Currently, pkey_disable_clear() sets the specified bits
instead clearing them. This has been dead code up to now
because its only callers i.e. pkey_access/write_allow()
are also unused.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 3ce5a87804ab..7440f6fa7be3 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -417,7 +417,7 @@ void pkey_disable_clear(int pkey, int flags)
 			pkey, pkey, pkey_rights);
 	pkey_assert(pkey_rights >= 0);
 
-	pkey_rights |= flags;
+	pkey_rights &= ~flags;
 
 	ret = hw_pkey_set(pkey, pkey_rights, 0);
 	shadow_pkey_reg = set_pkey_bits(shadow_pkey_reg, pkey, pkey_rights);
@@ -430,7 +430,7 @@ void pkey_disable_clear(int pkey, int flags)
 	dprintf1("%s(%d) pkey_reg: 0x%016lx\n", __func__,
 			pkey, read_pkey_reg());
 	if (flags)
-		assert(read_pkey_reg() > orig_pkey_reg);
+		assert(read_pkey_reg() < orig_pkey_reg);
 }
 
 void pkey_write_allow(int pkey)
-- 
2.17.1
