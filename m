Return-Path: <SRS0=PUSD=5Q=kvack.org=owner-linux-mm@kernel.org>
From: Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v19 17/24] selftests/vm/pkeys: Associate key on a mapped page and detect access violation
Date: Tue, 31 Mar 2020 15:28:18 +0530
In-Reply-To: <cover.1585646528.git.sandipan@linux.ibm.com>
References: <cover.1585646528.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1585646528.git.sandipan@linux.ibm.com>
References: <cover.1585646528.git.sandipan@linux.ibm.com>
Message-ID: <4a19cf9252c03dd883887e9002881599e6900d06.1585646528.git.sandipan@linux.ibm.com>
Sender: owner-linux-mm@kvack.org
To: akpm@linux-foundation.org
Cc: linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mm@kvack.org, fweimer@redhat.com, linuxram@us.ibm.com, mhocko@kernel.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au, shuah@kernel.org, Dave Hansen <dave.hansen@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200331095818.FO6zLJkcuu_RC6UV-e2tTTmUZvWTpTuj-_9fXto6TJ4@z>

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
index 95f173049f43f..f65d384ef6a0d 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -984,6 +984,24 @@ void test_read_of_access_disabled_region(int *ptr, u16 pkey)
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
@@ -1390,6 +1408,7 @@ void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
 void (*pkey_tests[])(int *ptr, u16 pkey) = {
 	test_read_of_write_disabled_region,
 	test_read_of_access_disabled_region,
+	test_read_of_access_disabled_region_with_page_already_mapped,
 	test_write_of_write_disabled_region,
 	test_write_of_access_disabled_region,
 	test_kernel_write_of_access_disabled_region,
-- 
2.17.1
