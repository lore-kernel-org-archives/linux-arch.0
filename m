From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFA][PATCH 23/27] metag: ftrace: Remove check of obsolete variable function_trace_stop
Date: Thu, 26 Jun 2014 12:52:44 -0400
Message-ID: <20140626165853.049120840@goodmis.org>
References: <20140626165221.736847419@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:56938 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758024AbaFZRAH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Jun 2014 13:00:07 -0400
Content-Disposition: inline; filename=0023-metag-ftrace-Remove-check-of-obsolete-variable-funct.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiri Kosina <jkosina@suse.cz>, Josh Poimboeuf <notifications@github.com>, James Hogan <james.hogan@imgtec.com>

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

Nothing sets function_trace_stop to disable function tracing anymore.
Remove the check for it in the arch code.

[ Please test this on your arch ]

Cc: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/metag/Kconfig              |  1 -
 arch/metag/kernel/ftrace_stub.S | 14 --------------
 2 files changed, 15 deletions(-)

diff --git a/arch/metag/Kconfig b/arch/metag/Kconfig
index 499b7610eaaf..0b389a81c43a 100644
--- a/arch/metag/Kconfig
+++ b/arch/metag/Kconfig
@@ -13,7 +13,6 @@ config METAG
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_TRACER
-	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
 	select HAVE_KERNEL_BZIP2
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
diff --git a/arch/metag/kernel/ftrace_stub.S b/arch/metag/kernel/ftrace_stub.S
index e70bff745bdd..3acc288217c0 100644
--- a/arch/metag/kernel/ftrace_stub.S
+++ b/arch/metag/kernel/ftrace_stub.S
@@ -16,13 +16,6 @@ _mcount_wrapper:
 	.global _ftrace_caller
 	.type	_ftrace_caller,function
 _ftrace_caller:
-	MOVT    D0Re0,#HI(_function_trace_stop)
-	ADD	D0Re0,D0Re0,#LO(_function_trace_stop)
-	GETD	D0Re0,[D0Re0]
-	CMP	D0Re0,#0
-	BEQ	$Lcall_stub
-	MOV	PC,D0.4
-$Lcall_stub:
 	MSETL   [A0StP], D0Ar6, D0Ar4, D0Ar2, D0.4
 	MOV     D1Ar1, D0.4
 	MOV     D0Ar2, D1RtP
@@ -42,13 +35,6 @@ _ftrace_call:
 	.global	_mcount_wrapper
 	.type	_mcount_wrapper,function
 _mcount_wrapper:
-	MOVT    D0Re0,#HI(_function_trace_stop)
-	ADD	D0Re0,D0Re0,#LO(_function_trace_stop)
-	GETD	D0Re0,[D0Re0]
-	CMP	D0Re0,#0
-	BEQ	$Lcall_mcount
-	MOV	PC,D0.4
-$Lcall_mcount:
 	MSETL   [A0StP], D0Ar6, D0Ar4, D0Ar2, D0.4
 	MOV     D1Ar1, D0.4
 	MOV     D0Ar2, D1RtP
-- 
2.0.0
