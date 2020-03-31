From: Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v19 24/24] selftests: vm: pkeys: Fix multilib builds for x86
Date: Tue, 31 Mar 2020 15:28:25 +0530
Message-ID: <0326a442214d7a1b970d38296e63df3b217f5912.1585646528.git.sandipan@linux.ibm.com>
References: <cover.1585646528.git.sandipan@linux.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730224AbgCaJ7w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Mar 2020 05:59:52 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02V9XSQS169881
        for <linux-arch@vger.kernel.org>; Tue, 31 Mar 2020 05:59:51 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30227vvver-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 31 Mar 2020 05:59:51 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Tue, 31 Mar 2020 10:59:47 +0100
In-Reply-To: <cover.1585646528.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1585646528.git.sandipan@linux.ibm.com>
References: <cover.1585646528.git.sandipan@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mm@kvack.org, fweimer@redhat.com, linuxram@us.ibm.com, mhocko@kernel.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au, shuah@kernel.org

This ensures that both 32-bit and 64-bit binaries are generated
when this is built on a x86_64 system. Most of the changes have
been borrowed from tools/testing/selftests/x86/Makefile.

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Tested-by: Dave Hansen <dave.hansen@intel.com>
---
 tools/testing/selftests/vm/Makefile | 72 +++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 4e9c741be6af2..82031f84af212 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -18,7 +18,30 @@ TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += userfaultfd
+
+ifeq ($(ARCH),x86_64)
+CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_32bit_program.c -m32)
+CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_64bit_program.c)
+CAN_BUILD_WITH_NOPIE := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_program.c -no-pie)
+
+TARGETS := protection_keys
+BINARIES_32 := $(TARGETS:%=%_32)
+BINARIES_64 := $(TARGETS:%=%_64)
+
+ifeq ($(CAN_BUILD_WITH_NOPIE),1)
+CFLAGS += -no-pie
+endif
+
+ifeq ($(CAN_BUILD_I386),1)
+TEST_GEN_FILES += $(BINARIES_32)
+endif
+
+ifeq ($(CAN_BUILD_X86_64),1)
+TEST_GEN_FILES += $(BINARIES_64)
+endif
+else
 TEST_GEN_FILES += protection_keys
+endif
 
 ifneq (,$(filter $(ARCH),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sh64 sparc64 x86_64))
 TEST_GEN_FILES += va_128TBswitch
@@ -32,6 +55,55 @@ TEST_FILES := test_vmalloc.sh
 KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
+ifeq ($(ARCH),x86_64)
+BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
+BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
+
+define gen-target-rule-32
+$(1) $(1)_32: $(OUTPUT)/$(1)_32
+.PHONY: $(1) $(1)_32
+endef
+
+define gen-target-rule-64
+$(1) $(1)_64: $(OUTPUT)/$(1)_64
+.PHONY: $(1) $(1)_64
+endef
+
+ifeq ($(CAN_BUILD_I386),1)
+$(BINARIES_32): CFLAGS += -m32
+$(BINARIES_32): LDLIBS += -lrt -ldl -lm
+$(BINARIES_32): %_32: %.c
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(notdir $^) $(LDLIBS) -o $@
+$(foreach t,$(TARGETS),$(eval $(call gen-target-rule-32,$(t))))
+endif
+
+ifeq ($(CAN_BUILD_X86_64),1)
+$(BINARIES_64): CFLAGS += -m64
+$(BINARIES_64): LDLIBS += -lrt -ldl
+$(BINARIES_64): %_64: %.c
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(notdir $^) $(LDLIBS) -o $@
+$(foreach t,$(TARGETS),$(eval $(call gen-target-rule-64,$(t))))
+endif
+
+# x86_64 users should be encouraged to install 32-bit libraries
+ifeq ($(CAN_BUILD_I386)$(CAN_BUILD_X86_64),01)
+all: warn_32bit_failure
+
+warn_32bit_failure:
+	@echo "Warning: you seem to have a broken 32-bit build" 2>&1;		\
+	echo  "environment. This will reduce test coverage of 64-bit" 2>&1;	\
+	echo  "kernels. If you are using a Debian-like distribution," 2>&1;	\
+	echo  "try:"; 2>&1;							\
+	echo  "";								\
+	echo  "  apt-get install gcc-multilib libc6-i386 libc6-dev-i386";	\
+	echo  "";								\
+	echo  "If you are using a Fedora-like distribution, try:";		\
+	echo  "";								\
+	echo  "  yum install glibc-devel.*i686";				\
+	exit 0;
+endif
+endif
+
 $(OUTPUT)/userfaultfd: LDLIBS += -lpthread
 
 $(OUTPUT)/mlock-random-test: LDLIBS += -lcap
-- 
2.17.1
