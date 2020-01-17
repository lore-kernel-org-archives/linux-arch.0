Return-Path: <owner-linux-mm@kvack.org>
From: Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v16 17/23] selftests/vm/pkeys: Associate key on a mapped page
 and detect access violation
Date: Fri, 17 Jan 2020 18:19:56 +0530
In-Reply-To: <cover.1579265066.git.sandipan@linux.ibm.com>
References: <cover.1579265066.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1579265066.git.sandipan@linux.ibm.com>
References: <cover.1579265066.git.sandipan@linux.ibm.com>
Message-ID: <fda50263252327f9280f1a42e648630c1c47e48a.1579265066.git.sandipan@linux.ibm.com>
Sender: owner-linux-mm@kvack.org
To: shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, dave.hansen@intel.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200117124956.9kSzCcP0zEsgxmOGQDF-jyGRyhNrhk7FVkloCH-cUyw@z>

From: Ram Pai <linuxram@us.ibm.com>

Detect access-violation on a page to which access-disabled
key is associated much after the page is mapped.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Signed-off: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 4a0677e618ac..526ad2fea316 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -983,6 +983,24 @@ void test_read_of_access_disabled_region(int *ptr, u16 pkey)
 	dprintf1("*ptr: %d\n", ptr_contents);
 	expected_pkey_fault(pkey);
 }
+
+void test_read_of_access_disabled_region_with_page_already_mapped(int *ptr,
+		u16 pkey)
+{
+	int ptr_contents;
+
+	dprintf1("disabling access to PKEY[%02d], doing read @ %p\n",
+				pkey, ptr);
+	ptr_contents = read_ptr(ptr);
+	dprintf1("reading ptr before disabling the read : %d\n",
+			ptr_contents);
+	read_pkey_reg();
+	pkey_access_deny(pkey);
+	ptr_contents = read_ptr(ptr);
+	dprintf1("*ptr: %d\n", ptr_contents);
+	expected_pkey_fault(pkey);
+}
+
 void test_write_of_write_disabled_region(int *ptr, u16 pkey)
 {
 	dprintf1("disabling write access to PKEY[%02d], doing write\n", pkey);
@@ -1389,6 +1407,7 @@ void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
 void (*pkey_tests[])(int *ptr, u16 pkey) = {
 	test_read_of_write_disabled_region,
 	test_read_of_access_disabled_region,
+	test_read_of_access_disabled_region_with_page_already_mapped,
 	test_write_of_write_disabled_region,
 	test_write_of_access_disabled_region,
 	test_kernel_write_of_access_disabled_region,
-- 
2.17.1
