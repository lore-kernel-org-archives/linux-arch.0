From: Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v16 12/23] selftests/vm/pkeys: Introduce generic pkey abstractions
Date: Fri, 17 Jan 2020 18:19:51 +0530
Message-ID: <aad11df01123d4fe173ea29680e9b9826a04be1f.1579265066.git.sandipan@linux.ibm.com>
References: <cover.1579265066.git.sandipan@linux.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726845AbgAQMus (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Jan 2020 07:50:48 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00HClHor084837
        for <linux-arch@vger.kernel.org>; Fri, 17 Jan 2020 07:50:46 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xk0qrusrt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 17 Jan 2020 07:50:46 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Fri, 17 Jan 2020 12:50:44 -0000
In-Reply-To: <cover.1579265066.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1579265066.git.sandipan@linux.ibm.com>
References: <cover.1579265066.git.sandipan@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, dave.hansen@intel.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org

From: Ram Pai <linuxram@us.ibm.com>

This introduces some generic abstractions and provides
the corresponding architecture-specfic implementations
for these abstractions.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/pkey-helpers.h    | 12 ++++++++++++
 tools/testing/selftests/vm/pkey-x86.h        | 15 +++++++++++++++
 tools/testing/selftests/vm/protection_keys.c |  8 ++------
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index df4b46050393..98617a011aa4 100644
--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -74,6 +74,9 @@ extern void abort_hooks(void);
 	}					\
 } while (0)
 
+__attribute__((noinline)) int read_ptr(int *ptr);
+void expected_pkey_fault(int pkey);
+
 #if defined(__i386__) || defined(__x86_64__) /* arch */
 #include "pkey-x86.h"
 #else /* arch */
@@ -172,4 +175,13 @@ static inline void __pkey_write_allow(int pkey, int do_allow_write)
 #define __stringify_1(x...)     #x
 #define __stringify(x...)       __stringify_1(x)
 
+static inline u32 *siginfo_get_pkey_ptr(siginfo_t *si)
+{
+#ifdef si_pkey
+	return &si->si_pkey;
+#else
+	return (u32 *)(((u8 *)si) + si_pkey_offset);
+#endif
+}
+
 #endif /* _PKEYS_HELPER_H */
diff --git a/tools/testing/selftests/vm/pkey-x86.h b/tools/testing/selftests/vm/pkey-x86.h
index f05e45ecaffb..296151309a30 100644
--- a/tools/testing/selftests/vm/pkey-x86.h
+++ b/tools/testing/selftests/vm/pkey-x86.h
@@ -42,6 +42,7 @@
 #endif
 
 #define NR_PKEYS		16
+#define NR_RESERVED_PKEYS	2 /* pkey-0 and exec-only-pkey */
 #define PKEY_BITS_PER_PKEY	2
 #define HPAGE_SIZE		(1UL<<21)
 #define PAGE_SIZE		4096
@@ -158,4 +159,18 @@ int pkey_reg_xstate_offset(void)
 	return xstate_offset;
 }
 
+static inline int get_arch_reserved_keys(void)
+{
+	return NR_RESERVED_PKEYS;
+}
+
+void expect_fault_on_read_execonly_key(void *p1, int pkey)
+{
+	int ptr_contents;
+
+	ptr_contents = read_ptr(p1);
+	dprintf2("ptr (%p) contents@%d: %x\n", p1, __LINE__, ptr_contents);
+	expected_pkey_fault(pkey);
+}
+
 #endif /* _PKEYS_X86_H */
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 3d80a8783b87..3b3abe4cbccd 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1306,9 +1306,7 @@ void test_executing_on_unreadable_memory(int *ptr, u16 pkey)
 	madvise(p1, PAGE_SIZE, MADV_DONTNEED);
 	lots_o_noops_around_write(&scratch);
 	do_not_expect_pkey_fault("executing on PROT_EXEC memory");
-	ptr_contents = read_ptr(p1);
-	dprintf2("ptr (%p) contents@%d: %x\n", p1, __LINE__, ptr_contents);
-	expected_pkey_fault(pkey);
+	expect_fault_on_read_execonly_key(p1, pkey);
 }
 
 void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
@@ -1335,9 +1333,7 @@ void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
 	madvise(p1, PAGE_SIZE, MADV_DONTNEED);
 	lots_o_noops_around_write(&scratch);
 	do_not_expect_pkey_fault("executing on PROT_EXEC memory");
-	ptr_contents = read_ptr(p1);
-	dprintf2("ptr (%p) contents@%d: %x\n", p1, __LINE__, ptr_contents);
-	expected_pkey_fault(UNKNOWN_PKEY);
+	expect_fault_on_read_execonly_key(p1, UNKNOWN_PKEY);
 
 	/*
 	 * Put the memory back to non-PROT_EXEC.  Should clear the
-- 
2.17.1
