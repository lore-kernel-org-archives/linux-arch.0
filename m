From: Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v15 23/23] selftests: vm: pkeys: Use the correct page size on
 powerpc
Date: Wed, 18 Dec 2019 13:21:56 +0530
Message-ID: <ff7c288e2a88ccfb3b79be30967646fe5b869683.1576645161.git.sandipan@linux.ibm.com>
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

Both 4K and 64K pages are supported on powerpc. Parts of
the selftest code perform alignment computations based on
the PAGE_SIZE macro which is currently hardcoded to 64K
for powerpc. This causes some test failures on kernels
configured with 4K page size.

This problem is solved by determining the correct page
size during the build process rather than hardcoding it
in the header file.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
cc: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/Makefile       | 4 ++++
 tools/testing/selftests/vm/pkey-powerpc.h | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 4e9c741be6af..ada3a67eaac6 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -4,6 +4,10 @@ uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/')
 
 CFLAGS = -Wall -I ../../../../usr/include $(EXTRA_CFLAGS)
+ifneq (,$(filter $(ARCH), ppc64 ppc64le))
+protection_keys: EXTRA_CFLAGS += -DPAGE_SIZE=$(shell getconf PAGESIZE)
+endif
+
 LDLIBS = -lrt
 TEST_GEN_FILES = compaction_test
 TEST_GEN_FILES += gup_benchmark
diff --git a/tools/testing/selftests/vm/pkey-powerpc.h b/tools/testing/selftests/vm/pkey-powerpc.h
index 3cd8e03fd640..07fa9f529014 100644
--- a/tools/testing/selftests/vm/pkey-powerpc.h
+++ b/tools/testing/selftests/vm/pkey-powerpc.h
@@ -36,7 +36,6 @@
 					     pkey-31 and exec-only key */
 #define PKEY_BITS_PER_PKEY	2
 #define HPAGE_SIZE		(1UL << 24)
-#define PAGE_SIZE		(1UL << 16)
 #define pkey_reg_t		u64
 #define PKEY_REG_FMT		"%016lx"
 
-- 
2.17.1
