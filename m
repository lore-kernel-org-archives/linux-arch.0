Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725882AbfLRHxI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Dec 2019 02:53:08 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBI7qtbb048490
        for <linux-arch@vger.kernel.org>; Wed, 18 Dec 2019 02:53:06 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wybqph0xn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 18 Dec 2019 02:53:06 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Wed, 18 Dec 2019 07:53:04 -0000
From: Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v15 23/23] selftests: vm: pkeys: Use the correct page size on powerpc
Date: Wed, 18 Dec 2019 13:21:56 +0530
In-Reply-To: <cover.1576645161.git.sandipan@linux.ibm.com>
References: <cover.1576645161.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1576645161.git.sandipan@linux.ibm.com>
References: <cover.1576645161.git.sandipan@linux.ibm.com>
Message-ID: <ff7c288e2a88ccfb3b79be30967646fe5b869683.1576645161.git.sandipan@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, dave.hansen@intel.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org
Message-ID: <20191218075156.WlJL0KIBdGgsEAV1JRHWD5VUQDet5LplJKohSipK6tE@z>

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
