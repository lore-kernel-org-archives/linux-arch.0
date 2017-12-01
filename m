Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49206 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752797AbdLAOTh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Dec 2017 09:19:37 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB1EE6C1019916
        for <linux-arch@vger.kernel.org>; Fri, 1 Dec 2017 09:19:37 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ek86kj2g0-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 01 Dec 2017 09:19:36 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <brueckner@linux.vnet.ibm.com>;
        Fri, 1 Dec 2017 14:19:33 -0000
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 2/5] s390/bpf: correct broken uapi for BPF_PROG_TYPE_PERF_EVENT program type
Date: Fri,  1 Dec 2017 15:19:05 +0100
In-Reply-To: <1512137948-31729-1-git-send-email-brueckner@linux.vnet.ibm.com>
References: <1512137948-31729-1-git-send-email-brueckner@linux.vnet.ibm.com>
Message-ID: <1512137948-31729-3-git-send-email-brueckner@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, linux-perf-users@vger.kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <20171201141905.ZEN8LADpX6zzfqB3cX1vkxkrxzpIHaaIwrJUeXnhzjA@z>

To mitigate and correct the broken uapi for the BPF_PROG_TYPE_PERF_EVENT
program type, introduce a user_pt_regs structure (similar to arm64) that
exports parts from the beginnig of the pt_regs structure.

The export must start with the beginning of the pt_regs structure because
to correctly calculate BPF prologues for perf (regs_query_register_offset()).

For BPF_PROG_TYPE_PERF_EVENT program types, the BPF program is then passed
a user_pt_regs structure.

Note: Depending on future changes to the s390 pt_regs structure, consider
the user_pt_regs structure to be stable for a particular kernel version
only. (Of course, s390 tries to ensure keep it stable as much as possible.)

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Reviewed-and-tested-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/s390/include/asm/perf_event.h          |  1 +
 arch/s390/include/asm/ptrace.h              | 11 ++++++++---
 arch/s390/include/uapi/asm/bpf_perf_event.h |  9 +++++++++
 arch/s390/include/uapi/asm/ptrace.h         | 11 +++++++++++
 4 files changed, 29 insertions(+), 3 deletions(-)
 create mode 100644 arch/s390/include/uapi/asm/bpf_perf_event.h

diff --git a/arch/s390/include/asm/perf_event.h b/arch/s390/include/asm/perf_event.h
index d6c9d1e..b9c0e36 100644
--- a/arch/s390/include/asm/perf_event.h
+++ b/arch/s390/include/asm/perf_event.h
@@ -40,6 +40,7 @@ extern ssize_t cpumf_events_sysfs_show(struct device *dev,
 extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
 extern unsigned long perf_misc_flags(struct pt_regs *regs);
 #define perf_misc_flags(regs) perf_misc_flags(regs)
+#define perf_arch_bpf_user_pt_regs(regs) &regs->user_regs
 
 /* Perf pt_regs extension for sample-data-entry indicators */
 struct perf_sf_sde_regs {
diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index a3788da..6f70d81 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -74,9 +74,14 @@ enum {
  */
 struct pt_regs 
 {
-	unsigned long args[1];
-	psw_t psw;
-	unsigned long gprs[NUM_GPRS];
+	union {
+		user_pt_regs user_regs;
+		struct {
+			unsigned long args[1];
+			psw_t psw;
+			unsigned long gprs[NUM_GPRS];
+		};
+	};
 	unsigned long orig_gpr2;
 	unsigned int int_code;
 	unsigned int int_parm;
diff --git a/arch/s390/include/uapi/asm/bpf_perf_event.h b/arch/s390/include/uapi/asm/bpf_perf_event.h
new file mode 100644
index 0000000..cefe7c7
--- /dev/null
+++ b/arch/s390/include/uapi/asm/bpf_perf_event.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _UAPI__ASM_BPF_PERF_EVENT_H__
+#define _UAPI__ASM_BPF_PERF_EVENT_H__
+
+#include <asm/ptrace.h>
+
+typedef user_pt_regs bpf_user_pt_regs_t;
+
+#endif /* _UAPI__ASM_BPF_PERF_EVENT_H__ */
diff --git a/arch/s390/include/uapi/asm/ptrace.h b/arch/s390/include/uapi/asm/ptrace.h
index 0d23c8f..70f7cb2 100644
--- a/arch/s390/include/uapi/asm/ptrace.h
+++ b/arch/s390/include/uapi/asm/ptrace.h
@@ -291,6 +291,17 @@
 } s390_regs;
 
 /*
+ * The user_pt_regs structure exports the beginning of
+ * the in-kernel pt_regs structure to user space.
+ */
+typedef struct
+{
+	unsigned long args[1];
+	psw_t psw;
+	unsigned long gprs[NUM_GPRS];
+} user_pt_regs;
+
+/*
  * Now for the user space program event recording (trace) definitions.
  * The following structures are used only for the ptrace interface, don't
  * touch or even look at it if you don't want to modify the user-space
-- 
1.8.3.1
