From: Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] perf kvm: fix building perf kvm on PowerPC
Date: Mon, 19 Nov 2012 16:19:21 +0800
Message-ID: <50A9EB89.70901@linux.vnet.ibm.com>
References: <50A48912.20606@linux.vnet.ibm.com> <1378.1352379110@warthog.procyon.org.uk> <CA+5PVA5vMyNmQYCLX315Jc+kN9zQuZo_h0Devpjfr43TezE-qA@mail.gmail.com> <18065.1352820271@warthog.procyon.org.uk> <CA+5PVA6qaxCzr8RBV616D3kEXyj9XjS3okeZXhJJL1R4+-Yv_A@mail.gmail.com> <20121113163458.GA1023@ghostprotocols.net> <50A488DD.6090106@linux.vnet.ibm.com> <6764.1352976414@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:43048 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133Ab2KSITv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 19 Nov 2012 03:19:51 -0500
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <xiaoguangrong@linux.vnet.ibm.com>;
	Mon, 19 Nov 2012 13:49:48 +0530
In-Reply-To: <6764.1352976414@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Josh Boyer <jwboyer@gmail.com>, mingo@kernel.org, haodong@linux.vnet.ibm.com, runzhen@linux.vnet.ibm.com, dsahern@gmail.com, tglx@linutronix.de, bp@alien8.de, namhyung@gmail.com, torvalds@linux-foundation.org, paulus@samba.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org

On 11/15/2012 06:46 PM, David Howells wrote:
> Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com> wrote:
> 
>> Now, 'perf kvm stat' is only supported on x86, let its code depend
>> on ARCH_X86 to fix building it on other architectures
> 
> Other parts of perf do this sort of thing:
> 
> 	#if defined(__x86_64__) || defined(__i386__)
> 

Yes, thanks for you point it out, David! How about this one?

Subject: [PATCH 2/2] perf kvm: fix building perf kvm on PowerPC

Now, 'perf kvm stat' is only supported on x86, let its code depend
on ARCH_X86 to fix building it on other architectures

Signed-off-by: Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>
---
 tools/perf/builtin-kvm.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 7fb426b..df30ca0 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -22,6 +22,7 @@
 #include <pthread.h>
 #include <math.h>

+#if defined(__i386__) || defined(__x86_64__)
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
+#if defined(__i386__) || defined(__x86_64__)
 	else if (!strncmp(argv[0], "stat", 4))
 		return kvm_cmd_stat(file_name, argc, argv);
+#endif
 	else
 		usage_with_options(kvm_usage, kvm_options);

-- 
1.7.7.6
