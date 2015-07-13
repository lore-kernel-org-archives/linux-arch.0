From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH] Revert "perf tools: Allow to specify custom linker command"
Date: Mon, 13 Jul 2015 14:10:53 +0300
Message-ID: <1436785853-4260-1-git-send-email-abrodkin@synopsys.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:56057 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751117AbbGMLLJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2015 07:11:09 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Jiri Olsa <jolsa@kernel.org>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-kernel@vger.kernel.org

This reverts commit 5ef7bbb09f7b
("perf tools: Allow to specify custom linker command").

LD is a pre-defined variable in GNU Make. I.e. it is always defined.
Which means there's no point to check "LD ?= ..." because it will never
succeed. And so LD will be either that explicitly passed to make like
this:
 ------->8-------
 make LD=path_to_my_ld ...
 ------->8-------
 or default value, which is host's "ld".

Latter leads to failure of cross-linkage because instead of cross linker
"$(CROSS_COMPILE)ld" host's "ld" is used.

As for commit which is reverted here:
 [1] Usually for selection of non-default flavour of CPU core/options
     linker flags are used like "-mtune=xxx" or "-mMyCPUType" etc.

 [2] Still to implement ability to use "ld" that differs from
    "$(CROSS_COMPILE)ld" one will need to add new makefile variable like
    TARGET_LD and then check if $(TARGET_LD) is not specified on make
    invocation then use "$(CROSS_COMPILE)ld".

But for now to fix cross-building of perf this revert is enough.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 7a4b549..0e0938a 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -110,7 +110,7 @@ $(OUTPUT)PERF-VERSION-FILE: ../../.git/HEAD
 	$(Q)touch $(OUTPUT)PERF-VERSION-FILE
 
 CC = $(CROSS_COMPILE)gcc
-LD ?= $(CROSS_COMPILE)ld
+LD = $(CROSS_COMPILE)ld
 AR = $(CROSS_COMPILE)ar
 PKG_CONFIG = $(CROSS_COMPILE)pkg-config
 
-- 
2.4.3
