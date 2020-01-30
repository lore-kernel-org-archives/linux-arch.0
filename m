Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27240 "EHLO
 mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
 with ESMTP id S1726646AbgA3GiB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
 Thu, 30 Jan 2020 01:38:01 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1]) by
 mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00U6baO3096804
 for <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 01:38:00 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99]) by
 mx0a-001b2d01.pphosted.com with ESMTP id 2xttnuh6hj-1 (version=TLSv1.2
 cipher=AES256-GCM-SHA384 bits=256 verify=NOT) for
 <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 01:38:00 -0500
Received: from localhost by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted for
 <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>; Thu, 30 Jan 2020
 06:37:58 -0000
From: Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v18 15/24] selftests/vm/pkeys: Fix assertion in
 test_pkey_alloc_exhaust()
Date: Thu, 30 Jan 2020 12:06:57 +0530
In-Reply-To: <cover.1580365432.git.sandipan@linux.ibm.com>
References: <cover.1580365432.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1580365432.git.sandipan@linux.ibm.com>
References: <cover.1580365432.git.sandipan@linux.ibm.com>
Message-ID: <db4520916e4562f7c4b8f032768adf364a571bbb.1580365432.git.sandipan@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: shuah@kernel.org, skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mm@kvack.org, fweimer@redhat.com, dave.hansen@intel.com, linuxram@us.ibm.com, mhocko@kernel.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au
Message-ID: <20200130063657.YDNYLpJqrfad8xfEyfnGYncxKy-46rGUALvykd-Q5DA@z>

From: Ram Pai <linuxram@us.ibm.com>

Some pkeys which are valid on the hardware are reserved
and not available for application use. These keys cannot
be allocated.

test_pkey_alloc_exhaust() tries to account for these and
has an assertion which validates if all available pkeys
have been exahaustively allocated. However, the expression
that is currently used is only valid for x86. On powerpc,
a pkey is additionally reserved as compared to x86. Hence,
the assertion is made to use an arch-specific helper to
get the correct count of reserved pkeys.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index e6de078a9196..5fcbbc525364 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1153,6 +1153,7 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
 	dprintf3("%s()::%d\n", __func__, __LINE__);

 	/*
+	 * On x86:
 	 * There are 16 pkeys supported in hardware.  Three are
 	 * allocated by the time we get here:
 	 *   1. The default key (0)
@@ -1160,8 +1161,16 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
 	 *   3. One allocated by the test code and passed in via
 	 *      'pkey' to this function.
 	 * Ensure that we can allocate at least another 13 (16-3).
+	 *
+	 * On powerpc:
+	 * There are either 5, 28, 29 or 32 pkeys supported in
+	 * hardware depending on the page size (4K or 64K) and
+	 * platform (powernv or powervm). Four are allocated by
+	 * the time we get here. These include pkey-0, pkey-1,
+	 * exec-only pkey and the one allocated by the test code.
+	 * Ensure that we can allocate the remaining.
 	 */
-	pkey_assert(i >= NR_PKEYS-3);
+	pkey_assert(i >= (NR_PKEYS - get_arch_reserved_keys() - 1));

 	for (i = 0; i < nr_allocated_pkeys; i++) {
 		err = sys_pkey_free(allocated_pkeys[i]);
-- 
2.17.1
