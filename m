From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH v12 10/22] selftests/vm: introduce two arch independent
 abstraction
Date: Wed, 21 Feb 2018 17:55:29 -0800
Message-ID: <1519264541-7621-11-git-send-email-linuxram@us.ibm.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
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
Cc: linux-arch@vger.kernel.org, ebiederm@xmission.com, arnd@arndb.de, linux-doc@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com, linux-kernel@vger.kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

open_hugepage_file() <- opens the huge page file
get_start_key() <--  provides the first non-reserved key.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/pkey-helpers.h    |   11 +++++++++++
 tools/testing/selftests/vm/protection_keys.c |    6 +++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index 7c979ad..c8f5739 100644
--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -304,3 +304,14 @@ static inline void __page_o_noops(void)
 	}					\
 } while (0)
 #define raw_assert(cond) assert(cond)
+
+static inline int open_hugepage_file(int flag)
+{
+	return open("/sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages",
+		 O_RDONLY);
+}
+
+static inline int get_start_key(void)
+{
+	return 1;
+}
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 2e4b636..254b66d 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -809,7 +809,7 @@ void setup_hugetlbfs(void)
 	 * Now go make sure that we got the pages and that they
 	 * are 2M pages.  Someone might have made 1G the default.
 	 */
-	fd = open("/sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages", O_RDONLY);
+	fd = open_hugepage_file(O_RDONLY);
 	if (fd < 0) {
 		perror("opening sysfs 2M hugetlb config");
 		return;
@@ -1087,10 +1087,10 @@ void test_kernel_gup_write_to_write_disabled_region(int *ptr, u16 pkey)
 void test_pkey_syscalls_on_non_allocated_pkey(int *ptr, u16 pkey)
 {
 	int err;
-	int i;
+	int i = get_start_key();
 
 	/* Note: 0 is the default pkey, so don't mess with it */
-	for (i = 1; i < NR_PKEYS; i++) {
+	for (; i < NR_PKEYS; i++) {
 		if (pkey == i)
 			continue;
 
-- 
1.7.1
