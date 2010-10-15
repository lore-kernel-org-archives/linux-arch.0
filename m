From: tip-bot for Steven Rostedt <srostedt@redhat.com>
Subject: [tip:perf/core] ftrace: Rename config option HAVE_C_MCOUNT_RECORD to HAVE_C_RECORDMCOUNT
Date: Fri, 15 Oct 2010 06:21:03 GMT
Message-ID: <tip-cf4db2597ae93b60efc0a7a4ec08690b75d629b1@git.kernel.org>
Reply-To: linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
	  jreiser@bitwagon.com, mmarek@suse.cz, rostedt@goodmis.org,
	  srostedt@redhat.com, tglx@linutronix.de,
	  linux-arch@vger.kernel.org, mingo@elte.hu
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45644 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753232Ab0JOGV2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Oct 2010 02:21:28 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: hpa@zytor.com, mingo@redhat.com, rostedt@goodmis.org, srostedt@redhat.com, jreiser@bitwagon.com, mmarek@suse.cz, tglx@linutronix.de, linux-arch@vger.kernel.org, mingo@elte.hu

Commit-ID:  cf4db2597ae93b60efc0a7a4ec08690b75d629b1
Gitweb:     http://git.kernel.org/tip/cf4db2597ae93b60efc0a7a4ec08690b75d629b1
Author:     Steven Rostedt <srostedt@redhat.com>
AuthorDate: Thu, 14 Oct 2010 23:32:44 -0400
Committer:  Steven Rostedt <rostedt@goodmis.org>
CommitDate: Thu, 14 Oct 2010 23:32:44 -0400

ftrace: Rename config option HAVE_C_MCOUNT_RECORD to HAVE_C_RECORDMCOUNT

The config option used by archs to let the build system know that
the C version of the recordmcount works for said arch is currently
called HAVE_C_MCOUNT_RECORD which enables BUILD_C_RECORDMCOUNT. To
be more consistent with the name that all archs may use, it has been
renamed to HAVE_C_RECORDMCOUNT. This will be less confusing since
we are building a C recordmcount and not a mcount_record.

Suggested-by: Ingo Molnar <mingo@elte.hu>
Cc: <linux-arch@vger.kernel.org>
Cc: Michal Marek <mmarek@suse.cz>
Cc: linux-kbuild@vger.kernel.org
Cc: John Reiser <jreiser@bitwagon.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 Makefile             |    2 +-
 arch/x86/Kconfig     |    2 +-
 kernel/trace/Kconfig |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 0dd3a8d..c2362c2 100644
--- a/Makefile
+++ b/Makefile
@@ -569,7 +569,7 @@ endif
 ifdef CONFIG_FUNCTION_TRACER
 KBUILD_CFLAGS	+= -pg
 ifdef CONFIG_DYNAMIC_FTRACE
-	ifdef CONFIG_HAVE_C_MCOUNT_RECORD
+	ifdef CONFIG_HAVE_C_RECORDMCOUNT
 		BUILD_C_RECORDMCOUNT := y
 		export BUILD_C_RECORDMCOUNT
 	endif
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 788b50e..9815221 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -33,7 +33,7 @@ config X86
 	select HAVE_KRETPROBES
 	select HAVE_OPTPROBES
 	select HAVE_FTRACE_MCOUNT_RECORD
-	select HAVE_C_MCOUNT_RECORD
+	select HAVE_C_RECORDMCOUNT
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index df00fbb..e550d2ed 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -49,7 +49,7 @@ config HAVE_SYSCALL_TRACEPOINTS
 	help
 	  See Documentation/trace/ftrace-design.txt
 
-config HAVE_C_MCOUNT_RECORD
+config HAVE_C_RECORDMCOUNT
 	bool
 	help
 	  C version of recordmcount available?
