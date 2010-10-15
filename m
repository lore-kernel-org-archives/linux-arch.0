Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:53605 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755950Ab0JODpW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 Oct 2010 23:45:22 -0400
Subject: [PATCH][GIT PULL] ftrace: Rename config option
 HAVE_C_MCOUNT_RECORD to HAVE_C_RECORDMCOUNT
From: Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Thu, 14 Oct 2010 23:45:19 -0400
Message-ID: <1287114319.23682.34.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Frederic Weisbecker <fweisbec@gmail.com>, linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.cz>, linux-kbuild <linux-kbuild@vger.kernel.org>, John Reiser <jreiser@bitwagon.com>
Message-ID: <20101015034519.bqghkrctPUN4yYzT1leIPqo7M4IuvnOmAWE8aYjYBLk@z>


Ingo,

Please pull the latest tip/perf/recordmcount-2 tree, which can be found at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git
tip/perf/recordmcount-2


Steven Rostedt (1):
      ftrace: Rename config option HAVE_C_MCOUNT_RECORD to HAVE_C_RECORDMCOUNT

----
 Makefile             |    2 +-
 arch/x86/Kconfig     |    2 +-
 kernel/trace/Kconfig |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
---------------------------
commit cf4db2597ae93b60efc0a7a4ec08690b75d629b1
Author: Steven Rostedt <srostedt@redhat.com>
Date:   Thu Oct 14 23:32:44 2010 -0400

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
index df00fbb..e550d2e 100644
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


