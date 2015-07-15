From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 2/2] perf tools: Really allow to specify custom CC, AR or LD
Date: Wed, 15 Jul 2015 12:20:08 -0300
Message-ID: <1436973608-9271-3-git-send-email-acme@kernel.org>
References: <1436973608-9271-1-git-send-email-acme@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:37840 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbbGOPU1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jul 2015 11:20:27 -0400
In-Reply-To: <1436973608-9271-1-git-send-email-acme@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Alexey Brodkin <abrodkin@synopsys.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Jiri Olsa <jolsa@kernel.org>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Vineet Gupta <vgupta@synopsys.com>, linux-arch@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>

Commit 5ef7bbb09f7b ("perf tools: Allow to specify custom linker
command") was meant to enable usage non $(CROSS_COMPILE)ld linker during
perf building.

But implementation didn't take into account the fact that LD is a
pre-defined variable in GNU Make. I.e. it is always defined.

Which means there's no point to check "LD ?= ..." because it will never
succeed.

And so LD will be either that explicitly passed to make like this:

 ------->8-------
 make LD=path_to_my_ld ...
 ------->8-------
 or default value, which is host's "ld".

Latter leads to failure of cross-linkage because instead of cross linker
"$(CROSS_COMPILE)ld" host's "ld" is used.

Fortunately there's a way to do correct substitution of $(CROSS_COMPILE)ld
with user defined LD on command-line.

As a reference was used implementation in "tools/lib/traceevent/Makefile".

Build tested for x86_64 and ARC.

Thanks Jiri for this hint.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Fixes: 5ef7bbb09f7b ("perf tools: Allow to specify custom linker command")
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-arch@vger.kernel.org
Link: http://lkml.kernel.org/r/1436864720-26316-1-git-send-email-abrodkin@synopsys.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 7a4b549214e3..bba34636b733 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -109,9 +109,22 @@ $(OUTPUT)PERF-VERSION-FILE: ../../.git/HEAD
 	$(Q)$(SHELL_PATH) util/PERF-VERSION-GEN $(OUTPUT)
 	$(Q)touch $(OUTPUT)PERF-VERSION-FILE
 
-CC = $(CROSS_COMPILE)gcc
-LD ?= $(CROSS_COMPILE)ld
-AR = $(CROSS_COMPILE)ar
+# Makefiles suck: This macro sets a default value of $(2) for the
+# variable named by $(1), unless the variable has been set by
+# environment or command line. This is necessary for CC and AR
+# because make sets default values, so the simpler ?= approach
+# won't work as expected.
+define allow-override
+  $(if $(or $(findstring environment,$(origin $(1))),\
+            $(findstring command line,$(origin $(1)))),,\
+    $(eval $(1) = $(2)))
+endef
+
+# Allow setting CC and AR and LD, or setting CROSS_COMPILE as a prefix.
+$(call allow-override,CC,$(CROSS_COMPILE)gcc)
+$(call allow-override,AR,$(CROSS_COMPILE)ar)
+$(call allow-override,LD,$(CROSS_COMPILE)ld)
+
 PKG_CONFIG = $(CROSS_COMPILE)pkg-config
 
 RM      = rm -f
-- 
2.1.0
