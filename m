From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH] perf tools: Really allow to specify custom CC, AR or LD
Date: Tue, 14 Jul 2015 12:05:20 +0300
Message-ID: <1436864720-26316-1-git-send-email-abrodkin@synopsys.com>
References: <20150714063152.GD22977@krava.local>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:50599 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751277AbbGNJFa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Jul 2015 05:05:30 -0400
In-Reply-To: <20150714063152.GD22977@krava.local>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Jiri Olsa <jolsa@kernel.org>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-kernel@vger.kernel.org

Commit 5ef7bbb09f7b ("perf tools: Allow to specify custom linker command")
was meant to enable usage non $(CROSS_COMPILE)ld linker during perf
building. But implementation didn't take in account fact that LD is
a pre-defined variable in GNU Make. I.e. it is always defined.
Which means there's no point to check "LD ?= ..." because it will never
succeed. And so LD will be either that explicitly passed to make like
this:
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
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/Makefile.perf | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 7a4b549..bba3463 100644
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
2.4.3
