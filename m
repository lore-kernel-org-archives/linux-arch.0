Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64632 "EHLO
 mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1726646AbgA3GiC (ORCPT <rfc822;linux-arch@vger.kernel.org>); Thu,
 30 Jan 2020 01:38:02 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1]) by
 mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00U6bNa7173611
 for <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 01:38:02 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98]) by
 mx0a-001b2d01.pphosted.com with ESMTP id 2xrj74gmp6-1 (version=TLSv1.2
 cipher=AES256-GCM-SHA384 bits=256 verify=NOT) for
 <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 01:38:01 -0500
Received: from localhost by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted for
 <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>; Thu, 30 Jan 2020
 06:37:54 -0000
From: Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v18 14/24] selftests/vm/pkeys: Fix number of reserved powerpc
 pkeys
Date: Thu, 30 Jan 2020 12:06:56 +0530
In-Reply-To: <cover.1580365432.git.sandipan@linux.ibm.com>
References: <cover.1580365432.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1580365432.git.sandipan@linux.ibm.com>
References: <cover.1580365432.git.sandipan@linux.ibm.com>
Message-ID: <ea6bb8c333ecf03073b59668c501a655983f7778.1580365432.git.sandipan@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: shuah@kernel.org, skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mm@kvack.org, fweimer@redhat.com, dave.hansen@intel.com, linuxram@us.ibm.com, mhocko@kernel.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au, "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>
Message-ID: <20200130063656.HonWgRzqtnsLwWu7ZJOaUHriq1ySzbMGh5PJrrIbZSo@z>

From: "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>

The number of reserved pkeys in a PowerNV environment is
different from that on PowerVM or KVM.

Tested on PowerVM and PowerNV environments.

Signed-off-by: "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/pkey-powerpc.h | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-powerpc.h b/tools/testing/selftests/vm/pkey-powerpc.h
index c79f4160a6a0..319673bbab0b 100644
--- a/tools/testing/selftests/vm/pkey-powerpc.h
+++ b/tools/testing/selftests/vm/pkey-powerpc.h
@@ -28,7 +28,10 @@
 #define NR_RESERVED_PKEYS_4K	27 /* pkey-0, pkey-1, exec-only-pkey
 				      and 24 other keys that cannot be
 				      represented in the PTE */
-#define NR_RESERVED_PKEYS_64K	3  /* pkey-0, pkey-1 and exec-only-pkey */
+#define NR_RESERVED_PKEYS_64K_3KEYS	3 /* PowerNV and KVM: pkey-0,
+					     pkey-1 and exec-only key */
+#define NR_RESERVED_PKEYS_64K_4KEYS	4 /* PowerVM: pkey-0, pkey-1,
+					     pkey-31 and exec-only key */
 #define PKEY_BITS_PER_PKEY	2
 #define HPAGE_SIZE		(1UL << 24)
 #define PAGE_SIZE		(1UL << 16)
@@ -65,12 +68,27 @@ static inline int cpu_has_pku(void)
 	return 1;
 }

+static inline bool arch_is_powervm()
+{
+	struct stat buf;
+
+	if ((stat("/sys/firmware/devicetree/base/ibm,partition-name", &buf) == 0) &&
+	    (stat("/sys/firmware/devicetree/base/hmc-managed?", &buf) == 0) &&
+	    (stat("/sys/firmware/devicetree/base/chosen/qemu,graphic-width", &buf) == -1) )
+		return true;
+
+	return false;
+}
+
 static inline int get_arch_reserved_keys(void)
 {
 	if (sysconf(_SC_PAGESIZE) == 4096)
 		return NR_RESERVED_PKEYS_4K;
 	else
-		return NR_RESERVED_PKEYS_64K;
+		if (arch_is_powervm())
+			return NR_RESERVED_PKEYS_64K_4KEYS;
+		else
+			return NR_RESERVED_PKEYS_64K_3KEYS;
 }

 void expect_fault_on_read_execonly_key(void *p1, int pkey)
-- 
2.17.1
