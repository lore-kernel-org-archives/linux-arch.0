From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH v14 18/22] selftests/vm: associate key on a mapped page and
 detect write violation
Date: Tue, 17 Jul 2018 06:49:21 -0700
Message-ID: <1531835365-32387-19-git-send-email-linuxram@us.ibm.com>
References: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, dave.hansen@intel.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com, msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

detect write-violation on a page to which write-disabled
key is associated much after the page is mapped.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
---
 tools/testing/selftests/vm/protection_keys.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index d41b2dc..59f6f33 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1038,6 +1038,17 @@ void test_read_of_access_disabled_region_with_page_already_mapped(int *ptr,
 	expected_pkey_fault(pkey);
 }
 
+void test_write_of_write_disabled_region_with_page_already_mapped(int *ptr,
+		u16 pkey)
+{
+	*ptr = __LINE__;
+	dprintf1("disabling write access; after accessing the page, "
+		"to PKEY[%02d], doing write\n", pkey);
+	pkey_write_deny(pkey);
+	*ptr = __LINE__;
+	expected_pkey_fault(pkey);
+}
+
 void test_write_of_write_disabled_region(int *ptr, u16 pkey)
 {
 	dprintf1("disabling write access to PKEY[%02d], doing write\n", pkey);
@@ -1417,6 +1428,7 @@ void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
 	test_read_of_access_disabled_region,
 	test_read_of_access_disabled_region_with_page_already_mapped,
 	test_write_of_write_disabled_region,
+	test_write_of_write_disabled_region_with_page_already_mapped,
 	test_write_of_access_disabled_region,
 	test_kernel_write_of_access_disabled_region,
 	test_kernel_write_of_write_disabled_region,
-- 
1.7.1
