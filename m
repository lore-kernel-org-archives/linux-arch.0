Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46252 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752670AbdKFJAd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Nov 2017 04:00:33 -0500
From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH v9 46/51] selftest/vm: associate key on a mapped page and detect access violation
Date: Mon,  6 Nov 2017 00:57:38 -0800
Message-ID: <1509958663-18737-47-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
Message-ID: <20171106085738.TpfkD5Fmq7A7rj7fp56COtwBMUzhdm9CNp68CrzTPt4@z>

detect access-violation on a page to which access-disabled
key is associated much after the page is mapped.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 8f0dd94..998a44f 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1015,6 +1015,24 @@ void test_read_of_access_disabled_region(int *ptr, u16 pkey)
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
+	rdpkey_reg();
+	pkey_access_deny(pkey);
+	ptr_contents = read_ptr(ptr);
+	dprintf1("*ptr: %d\n", ptr_contents);
+	expected_pkey_fault(pkey);
+}
+
 void test_write_of_write_disabled_region(int *ptr, u16 pkey)
 {
 	dprintf1("disabling write access to PKEY[%02d], doing write\n", pkey);
@@ -1309,6 +1327,7 @@ void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
 void (*pkey_tests[])(int *ptr, u16 pkey) = {
 	test_read_of_write_disabled_region,
 	test_read_of_access_disabled_region,
+	test_read_of_access_disabled_region_with_page_already_mapped,
 	test_write_of_write_disabled_region,
 	test_write_of_access_disabled_region,
 	test_kernel_write_of_access_disabled_region,
-- 
1.7.1
