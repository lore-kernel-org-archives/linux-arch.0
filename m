From: Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v15 15/23] selftests/vm/pkeys: Improve checks to determine
 pkey support
Date: Wed, 18 Dec 2019 13:21:48 +0530
Message-ID: <f0cae58cacb8a0e5459e8517d3d8dafc15868aba.1576645161.git.sandipan@linux.ibm.com>
References: <cover.1576645161.git.sandipan@linux.ibm.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <cover.1576645161.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1576645161.git.sandipan@linux.ibm.com>
References: <cover.1576645161.git.sandipan@linux.ibm.com>
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
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, linux-mm@kvack.org, aneesh.kumar@linux.ibm.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, dave.hansen@intel.com, mingo@redhat.com, msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org, bauerman@linux.ibm.com
List-Id: linux-arch.vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>

For the pkeys subsystem to work, both the CPU and the
kernel need to have support. So, additionally check if
the kernel supports pkeys apart from the CPU feature
checks.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/pkey-helpers.h    | 30 ++++++++++++++++++++
 tools/testing/selftests/vm/pkey-powerpc.h    |  3 +-
 tools/testing/selftests/vm/pkey-x86.h        |  2 +-
 tools/testing/selftests/vm/protection_keys.c |  7 +++--
 4 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index 5de06d3a81de..43299435f24c 100644
--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -76,6 +76,8 @@ extern void abort_hooks(void);
 
 __attribute__((noinline)) int read_ptr(int *ptr);
 void expected_pkey_fault(int pkey);
+int sys_pkey_alloc(unsigned long flags, unsigned long init_val);
+int sys_pkey_free(unsigned long pkey);
 
 #if defined(__i386__) || defined(__x86_64__) /* arch */
 #include "pkey-x86.h"
@@ -187,4 +189,32 @@ static inline u32 *siginfo_get_pkey_ptr(siginfo_t *si)
 #endif
 }
 
+static inline int kernel_has_pkeys(void)
+{
+	/* try allocating a key and see if it succeeds */
+	int ret = sys_pkey_alloc(0, 0);
+	if (ret <= 0) {
+		return 0;
+	}
+	sys_pkey_free(ret);
+	return 1;
+}
+
+static inline int is_pkeys_supported(void)
+{
+	/* check if the cpu supports pkeys */
+	if (!cpu_has_pkeys()) {
+		dprintf1("SKIP: %s: no CPU support\n", __func__);
+		return 0;
+	}
+
+	/* check if the kernel supports pkeys */
+	if (!kernel_has_pkeys()) {
+		dprintf1("SKIP: %s: no kernel support\n", __func__);
+		return 0;
+	}
+
+	return 1;
+}
+
 #endif /* _PKEYS_HELPER_H */
diff --git a/tools/testing/selftests/vm/pkey-powerpc.h b/tools/testing/selftests/vm/pkey-powerpc.h
index 5ced9c58fa4a..a43d7be85a27 100644
--- a/tools/testing/selftests/vm/pkey-powerpc.h
+++ b/tools/testing/selftests/vm/pkey-powerpc.h
@@ -63,8 +63,9 @@ static inline void __write_pkey_reg(pkey_reg_t pkey_reg)
 			pkey_reg);
 }
 
-static inline int cpu_has_pku(void)
+static inline int cpu_has_pkeys(void)
 {
+	/* No simple way to determine this */
 	return 1;
 }
 
diff --git a/tools/testing/selftests/vm/pkey-x86.h b/tools/testing/selftests/vm/pkey-x86.h
index bb2d4dfcacd5..e5fdee39a7d8 100644
--- a/tools/testing/selftests/vm/pkey-x86.h
+++ b/tools/testing/selftests/vm/pkey-x86.h
@@ -99,7 +99,7 @@ static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
 #define X86_FEATURE_PKU        (1<<3) /* Protection Keys for Userspace */
 #define X86_FEATURE_OSPKE      (1<<4) /* OS Protection Keys Enable */
 
-static inline int cpu_has_pku(void)
+static inline int cpu_has_pkeys(void)
 {
 	unsigned int eax;
 	unsigned int ebx;
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 8d90cfe2c9bd..7bceb98662c1 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1377,7 +1377,7 @@ void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
 	int size = PAGE_SIZE;
 	int sret;
 
-	if (cpu_has_pku()) {
+	if (cpu_has_pkeys()) {
 		dprintf1("SKIP: %s: no CPU support\n", __func__);
 		return;
 	}
@@ -1446,12 +1446,13 @@ void pkey_setup_shadow(void)
 int main(void)
 {
 	int nr_iterations = 22;
+	int pkeys_supported = is_pkeys_supported();
 
 	setup_handlers();
 
-	printf("has pku: %d\n", cpu_has_pku());
+	printf("has pkeys: %d\n", pkeys_supported);
 
-	if (!cpu_has_pku()) {
+	if (!pkeys_supported) {
 		int size = PAGE_SIZE;
 		int *ptr;
 
-- 
2.17.1
