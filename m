From: Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>
Subject: [PATCH 2/2] perf kvm: fix building perf kvm on PowerPC
Date: Thu, 15 Nov 2012 14:17:54 +0800
Message-ID: <50A48912.20606@linux.vnet.ibm.com>
References: <1378.1352379110@warthog.procyon.org.uk> <CA+5PVA5vMyNmQYCLX315Jc+kN9zQuZo_h0Devpjfr43TezE-qA@mail.gmail.com> <18065.1352820271@warthog.procyon.org.uk> <CA+5PVA6qaxCzr8RBV616D3kEXyj9XjS3okeZXhJJL1R4+-Yv_A@mail.gmail.com> <20121113163458.GA1023@ghostprotocols.net> <50A488DD.6090106@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:53970 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab2KOGSX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 15 Nov 2012 01:18:23 -0500
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <xiaoguangrong@linux.vnet.ibm.com>;
	Thu, 15 Nov 2012 11:48:16 +0530
In-Reply-To: <50A488DD.6090106@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Josh Boyer <jwboyer@gmail.com>, David Howells <dhowells@redhat.com>, mingo@kernel.org, haodong@linux.vnet.ibm.com, runzhen@linux.vnet.ibm.com, dsahern@gmail.com, tglx@linutronix.de, bp@alien8.de, namhyung@gmail.com, torvalds@linux-foundation.org, paulus@samba.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org

Now, 'perf kvm stat' is only supported on x86, let its code depend
on ARCH_X86 to fix building it on other architectures

Signed-off-by: Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>
---
 tools/perf/arch/x86/Makefile |    2 ++
 tools/perf/builtin-kvm.c     |    4 ++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
index 815841c..320fb95 100644
--- a/tools/perf/arch/x86/Makefile
+++ b/tools/perf/arch/x86/Makefile
@@ -1,3 +1,5 @@
+ARCH_CFLAGS += -DARCH_X86
+
 ifndef NO_DWARF
 PERF_HAVE_DWARF_REGS := 1
 LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/dwarf-regs.o
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 7fb426b..75e998a 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -22,6 +22,7 @@
 #include <pthread.h>
 #include <math.h>

+#ifdef ARCH_X86
 #include "../../arch/x86/include/asm/svm.h"
 #include "../../arch/x86/include/asm/vmx.h"
 #include "../../arch/x86/include/asm/kvm.h"
@@ -913,6 +914,7 @@ static int kvm_cmd_stat(const char *file_name, int argc, const char **argv)
 perf_stat:
 	return cmd_stat(argc, argv, NULL);
 }
+#endif

 static int __cmd_record(const char *file_name, int argc, const char **argv)
 {
@@ -1035,8 +1037,10 @@ int cmd_kvm(int argc, const char **argv, const char *prefix __maybe_unused)
 		return cmd_top(argc, argv, NULL);
 	else if (!strncmp(argv[0], "buildid-list", 12))
 		return __cmd_buildid_list(file_name, argc, argv);
+#ifdef ARCH_X86
 	else if (!strncmp(argv[0], "stat", 4))
 		return kvm_cmd_stat(file_name, argc, argv);
+#endif
 	else
 		usage_with_options(kvm_usage, kvm_options);

-- 
1.7.7.6
