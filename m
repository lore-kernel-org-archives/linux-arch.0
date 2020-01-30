From: Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v18 21/24] selftests/vm/pkeys: Test correct behaviour of pkey-0
Date: Thu, 30 Jan 2020 12:07:03 +0530
Message-ID: <0c0467a7b40c425bccf1b2fe11214bd7caf7670d.1580365432.git.sandipan@linux.ibm.com>
References: <cover.1580365432.git.sandipan@linux.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726646AbgA3GiT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Jan 2020 01:38:19 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00U6aleF081317
        for <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 01:38:18 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xttw80tww-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 01:38:17 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Thu, 30 Jan 2020 06:38:15 -0000
In-Reply-To: <cover.1580365432.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1580365432.git.sandipan@linux.ibm.com>
References: <cover.1580365432.git.sandipan@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: shuah@kernel.org, skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mm@kvack.org, fweimer@redhat.com, dave.hansen@intel.com, linuxram@us.ibm.com, mhocko@kernel.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au

From: Ram Pai <linuxram@us.ibm.com>

Ensure that pkey-0 is allocated on start and that it can
be attached dynamically in various modes, without failures.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c | 53 ++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index d4952b57cc90..a1cb9a71e77c 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -964,6 +964,58 @@ __attribute__((noinline)) int read_ptr(int *ptr)
 	return *ptr;
 }
 
+void test_pkey_alloc_free_attach_pkey0(int *ptr, u16 pkey)
+{
+	int i, err;
+	int max_nr_pkey_allocs;
+	int alloced_pkeys[NR_PKEYS];
+	int nr_alloced = 0;
+	long size;
+
+	pkey_assert(pkey_last_malloc_record);
+	size = pkey_last_malloc_record->size;
+	/*
+	 * This is a bit of a hack.  But mprotect() requires
+	 * huge-page-aligned sizes when operating on hugetlbfs.
+	 * So, make sure that we use something that's a multiple
+	 * of a huge page when we can.
+	 */
+	if (size >= HPAGE_SIZE)
+		size = HPAGE_SIZE;
+
+	/* allocate every possible key and make sure key-0 never got allocated */
+	max_nr_pkey_allocs = NR_PKEYS;
+	for (i = 0; i < max_nr_pkey_allocs; i++) {
+		int new_pkey = alloc_pkey();
+		pkey_assert(new_pkey != 0);
+
+		if (new_pkey < 0)
+			break;
+		alloced_pkeys[nr_alloced++] = new_pkey;
+	}
+	/* free all the allocated keys */
+	for (i = 0; i < nr_alloced; i++) {
+		int free_ret;
+
+		if (!alloced_pkeys[i])
+			continue;
+		free_ret = sys_pkey_free(alloced_pkeys[i]);
+		pkey_assert(!free_ret);
+	}
+
+	/* attach key-0 in various modes */
+	err = sys_mprotect_pkey(ptr, size, PROT_READ, 0);
+	pkey_assert(!err);
+	err = sys_mprotect_pkey(ptr, size, PROT_WRITE, 0);
+	pkey_assert(!err);
+	err = sys_mprotect_pkey(ptr, size, PROT_EXEC, 0);
+	pkey_assert(!err);
+	err = sys_mprotect_pkey(ptr, size, PROT_READ|PROT_WRITE, 0);
+	pkey_assert(!err);
+	err = sys_mprotect_pkey(ptr, size, PROT_READ|PROT_WRITE|PROT_EXEC, 0);
+	pkey_assert(!err);
+}
+
 void test_read_of_write_disabled_region(int *ptr, u16 pkey)
 {
 	int ptr_contents;
@@ -1448,6 +1500,7 @@ void (*pkey_tests[])(int *ptr, u16 pkey) = {
 	test_pkey_syscalls_on_non_allocated_pkey,
 	test_pkey_syscalls_bad_args,
 	test_pkey_alloc_exhaust,
+	test_pkey_alloc_free_attach_pkey0,
 };
 
 void run_tests_once(void)
-- 
2.17.1
