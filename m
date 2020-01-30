Return-Path: <owner-linux-mm@kvack.org>
From: Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v18 12/24] selftests/vm/pkeys: Introduce generic pkey
 abstractions
Date: Thu, 30 Jan 2020 12:06:54 +0530
In-Reply-To: <cover.1580365432.git.sandipan@linux.ibm.com>
References: <cover.1580365432.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1580365432.git.sandipan@linux.ibm.com>
References: <cover.1580365432.git.sandipan@linux.ibm.com>
Message-ID: <e776c571c94fc55681225e7f0cfc3e6e02c32ac8.1580365432.git.sandipan@linux.ibm.com>
Sender: owner-linux-mm@kvack.org
To: shuah@kernel.org, skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mm@kvack.org, fweimer@redhat.com, dave.hansen@intel.com, linuxram@us.ibm.com, mhocko@kernel.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200130063654.G76HgkPW2GoTdxoSB4BA4fdrNyFyA8B-EP74pi5ME_E@z>

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
index 0e3da7c8d628..621fb2a0a5ef 100644
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
index def2a1bcf6a5..a0c59d4f7af2 100644
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
index 535e464e27e9..57c71056c93d 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1307,9 +1307,7 @@ void test_executing_on_unreadable_memory(int *ptr, u16 pkey)
 	madvise(p1, PAGE_SIZE, MADV_DONTNEED);
 	lots_o_noops_around_write(&scratch);
 	do_not_expect_pkey_fault("executing on PROT_EXEC memory");
-	ptr_contents = read_ptr(p1);
-	dprintf2("ptr (%p) contents@%d: %x\n", p1, __LINE__, ptr_contents);
-	expected_pkey_fault(pkey);
+	expect_fault_on_read_execonly_key(p1, pkey);
 }

 void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
@@ -1336,9 +1334,7 @@ void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
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
