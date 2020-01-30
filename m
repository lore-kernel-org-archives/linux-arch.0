From: Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v18 24/24] selftests: vm: pkeys: Fix multilib builds for x86
Date: Thu, 30 Jan 2020 12:07:06 +0530
Message-ID: <25d97f793aade305356f52cf85272b5a6b170fbd.1580365432.git.sandipan@linux.ibm.com>
References: <cover.1580365432.git.sandipan@linux.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726461AbgA3Gi0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Jan 2020 01:38:26 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00U6aJ8l021022
        for <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 01:38:25 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xtrmc6efg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 01:38:24 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Thu, 30 Jan 2020 06:38:23 -0000
In-Reply-To: <cover.1580365432.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1580365432.git.sandipan@linux.ibm.com>
References: <cover.1580365432.git.sandipan@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: shuah@kernel.org, skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mm@kvack.org, fweimer@redhat.com, dave.hansen@intel.com, linuxram@us.ibm.com, mhocko@kernel.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au

This ensures that both 32-bit and 64-bit binaries are generated
when this is built on a x86_64 system. Most of the changes have
been borrowed from tools/testing/selftests/x86/Makefile.

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/Makefile | 72 +++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 4e9c741be6af..82031f84af21 100644
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
