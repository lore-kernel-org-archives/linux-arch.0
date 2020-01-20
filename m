From: Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v17 15/24] selftests/vm/pkeys: Fix number of reserved powerpc pkeys
Date: Mon, 20 Jan 2020 14:06:12 +0530
Message-ID: <7ec3f35788b60da183697f1462ee11dd9d62eef1.1579507768.git.sandipan@linux.ibm.com>
References: <cover.1579507768.git.sandipan@linux.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57440 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726125AbgATIjE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Jan 2020 03:39:04 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00K8cuZw121152
        for <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 03:39:02 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xmg39fyu1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 03:39:02 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Mon, 20 Jan 2020 08:37:11 -0000
In-Reply-To: <cover.1579507768.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1579507768.git.sandipan@linux.ibm.com>
References: <cover.1579507768.git.sandipan@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, dave.hansen@intel.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>

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
