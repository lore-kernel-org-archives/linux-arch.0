From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH v12 21/22] selftests/vm: sub-page allocator
Date: Wed, 21 Feb 2018 17:55:40 -0800
Message-ID: <1519264541-7621-22-git-send-email-linuxram@us.ibm.com>
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

introduce a new allocator that allocates 4k hardware-pages to back
64k linux-page. This allocator is only applicable on powerpc.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |   30 ++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 42c068a..1b06e59 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -766,6 +766,35 @@ void free_pkey_malloc(void *ptr)
 	return ptr;
 }
 
+void *malloc_pkey_with_mprotect_subpage(long size, int prot, u16 pkey)
+{
+#ifdef __powerpc64__
+	void *ptr;
+	int ret;
+
+	dprintf1("doing %s(size=%ld, prot=0x%x, pkey=%d)\n", __func__,
+			size, prot, pkey);
+	pkey_assert(pkey < NR_PKEYS);
+	ptr = mmap(NULL, size, prot, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+	pkey_assert(ptr != (void *)-1);
+
+	ret = syscall(__NR_subpage_prot, ptr, size, NULL);
+	if (ret) {
+		perror("subpage_perm");
+		return PTR_ERR_ENOTSUP;
+	}
+
+	ret = mprotect_pkey((void *)ptr, PAGE_SIZE, prot, pkey);
+	pkey_assert(!ret);
+	record_pkey_malloc(ptr, size);
+
+	dprintf1("%s() for pkey %d @ %p\n", __func__, pkey, ptr);
+	return ptr;
+#else /*  __powerpc64__ */
+	return PTR_ERR_ENOTSUP;
+#endif /*  __powerpc64__ */
+}
+
 void *malloc_pkey_anon_huge(long size, int prot, u16 pkey)
 {
 	int ret;
@@ -888,6 +917,7 @@ void setup_hugetlbfs(void)
 void *(*pkey_malloc[])(long size, int prot, u16 pkey) = {
 
 	malloc_pkey_with_mprotect,
+	malloc_pkey_with_mprotect_subpage,
 	malloc_pkey_anon_huge,
 	malloc_pkey_hugetlb
 /* can not do direct with the pkey_mprotect() API:
-- 
1.7.1
