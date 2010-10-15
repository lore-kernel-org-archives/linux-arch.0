From: tip-bot for Steven Rostedt <srostedt@redhat.com>
Subject: [tip:perf/core] ftrace/x86: Add support for C version of recordmcount
Date: Fri, 15 Oct 2010 06:20:12 GMT
Message-ID: <tip-72441cb1fd77d092f09ddfac748955703884c9a7@git.kernel.org>
Reply-To: linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
	  jreiser@bitwagon.com, mmarek@suse.cz, rostedt@goodmis.org,
	  srostedt@redhat.com, tglx@linutronix.de,
	  linux-arch@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45600 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753232Ab0JOGUc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Oct 2010 02:20:32 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: hpa@zytor.com, mingo@redhat.com, rostedt@goodmis.org, srostedt@redhat.com, jreiser@bitwagon.com, mmarek@suse.cz, tglx@linutronix.de, linux-arch@vger.kernel.org

Commit-ID:  72441cb1fd77d092f09ddfac748955703884c9a7
Gitweb:     http://git.kernel.org/tip/72441cb1fd77d092f09ddfac748955703884c9a7
Author:     Steven Rostedt <srostedt@redhat.com>
AuthorDate: Wed, 13 Oct 2010 17:12:30 -0400
Committer:  Steven Rostedt <rostedt@goodmis.org>
CommitDate: Thu, 14 Oct 2010 16:52:41 -0400

ftrace/x86: Add support for C version of recordmcount

This patch adds the support for the C version of recordmcount and
compile times show ~ 12% improvement.

After verifying this works, other archs can add:

 HAVE_C_MCOUNT_RECORD

in its Kconfig and it will use the C version of recordmcount
instead of the perl version.

Cc: <linux-arch@vger.kernel.org>
Cc: Michal Marek <mmarek@suse.cz>
Cc: linux-kbuild@vger.kernel.org
Cc: John Reiser <jreiser@bitwagon.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 Makefile               |    6 ++++++
 arch/x86/Kconfig       |    1 +
 kernel/trace/Kconfig   |    5 +++++
 scripts/Makefile       |    1 +
 scripts/Makefile.build |    4 ++++
 5 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 534c09c..0dd3a8d 100644
--- a/Makefile
+++ b/Makefile
@@ -568,6 +568,12 @@ endif
 
 ifdef CONFIG_FUNCTION_TRACER
 KBUILD_CFLAGS	+= -pg
+ifdef CONFIG_DYNAMIC_FTRACE
+	ifdef CONFIG_HAVE_C_MCOUNT_RECORD
+		BUILD_C_RECORDMCOUNT := y
+		export BUILD_C_RECORDMCOUNT
+	endif
+endif
 endif
 
 # We trigger additional mismatches with less inlining
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c14d8b4..788b50e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -33,6 +33,7 @@ config X86
 	select HAVE_KRETPROBES
 	select HAVE_OPTPROBES
 	select HAVE_FTRACE_MCOUNT_RECORD
+	select HAVE_C_MCOUNT_RECORD
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 538501c..df00fbb 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -49,6 +49,11 @@ config HAVE_SYSCALL_TRACEPOINTS
 	help
 	  See Documentation/trace/ftrace-design.txt
 
+config HAVE_C_MCOUNT_RECORD
+	bool
+	help
+	  C version of recordmcount available?
+
 config TRACER_MAX_TRACE
 	bool
 
diff --git a/scripts/Makefile b/scripts/Makefile
index 842dbc2..2e08810 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -11,6 +11,7 @@ hostprogs-$(CONFIG_KALLSYMS)     += kallsyms
 hostprogs-$(CONFIG_LOGO)         += pnmtologo
 hostprogs-$(CONFIG_VT)           += conmakehash
 hostprogs-$(CONFIG_IKCONFIG)     += bin2c
+hostprogs-$(BUILD_C_RECORDMCOUNT) += recordmcount
 
 always		:= $(hostprogs-y) $(hostprogs-m)
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a1a5cf9..4d03a7e 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -209,12 +209,16 @@ cmd_modversions =								\
 endif
 
 ifdef CONFIG_FTRACE_MCOUNT_RECORD
+ifdef BUILD_C_RECORDMCOUNT
+cmd_record_mcount = $(srctree)/scripts/recordmcount "$(@)";
+else
 cmd_record_mcount = set -e ; perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
 	"$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
 	"$(if $(CONFIG_64BIT),64,32)" \
 	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC)" "$(LD)" "$(NM)" "$(RM)" "$(MV)" \
 	"$(if $(part-of-module),1,0)" "$(@)";
 endif
+endif
 
 define rule_cc_o_c
 	$(call echo-cmd,checksrc) $(cmd_checksrc)			  \
