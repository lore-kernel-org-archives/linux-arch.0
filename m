From: Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v18 23/24] selftests: vm: pkeys: Use the correct page size on powerpc
Date: Thu, 30 Jan 2020 12:07:05 +0530
Message-ID: <ff2f307f4087edda4aa4b3158f3bc7df4cbd0f21.1580365432.git.sandipan@linux.ibm.com>
References: <cover.1580365432.git.sandipan@linux.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48526 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726461AbgA3GiY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Jan 2020 01:38:24 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00U6bXfG014756
        for <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 01:38:24 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xueh6tycw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 01:38:23 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Thu, 30 Jan 2020 06:38:21 -0000
In-Reply-To: <cover.1580365432.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1580365432.git.sandipan@linux.ibm.com>
References: <cover.1580365432.git.sandipan@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: shuah@kernel.org, skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mm@kvack.org, fweimer@redhat.com, dave.hansen@intel.com, linuxram@us.ibm.com, mhocko@kernel.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au

Both 4K and 64K pages are supported on powerpc. Parts of
the selftest code perform alignment computations based on
the PAGE_SIZE macro which is currently hardcoded to 64K
for powerpc. This causes some test failures on kernels
configured with 4K page size.

In some cases, we need to enforce function alignment on
page size. Since this can only be done at build time,
64K is used as the alignment factor as that also ensures
4K alignment.

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/pkey-powerpc.h    | 2 +-
 tools/testing/selftests/vm/protection_keys.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/pkey-powerpc.h b/tools/testing/selftests/vm/pkey-powerpc.h
index 02bd4dd7d467..3a761e51a587 100644
--- a/tools/testing/selftests/vm/pkey-powerpc.h
+++ b/tools/testing/selftests/vm/pkey-powerpc.h
@@ -36,7 +36,7 @@
 					     pkey-31 and exec-only key */
 #define PKEY_BITS_PER_PKEY	2
 #define HPAGE_SIZE		(1UL << 24)
-#define PAGE_SIZE		(1UL << 16)
+#define PAGE_SIZE		sysconf(_SC_PAGESIZE)
 
 static inline u32 pkey_bit_position(int pkey)
 {
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index a1cb9a71e77c..fc19addcb5c8 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -146,7 +146,12 @@ void abort_hooks(void)
  * will then fault, which makes sure that the fault code handles
  * execute-only memory properly.
  */
+#ifdef __powerpc64__
+/* This way, both 4K and 64K alignment are maintained */
+__attribute__((__aligned__(65536)))
+#else
 __attribute__((__aligned__(PAGE_SIZE)))
+#endif
 void lots_o_noops_around_write(int *write_to_me)
 {
 	dprintf3("running %s()\n", __func__);
-- 
2.17.1
