From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: [RFC patch 06/15] LTTng build
Date: Thu, 16 Oct 2008 19:27:35 -0400
Message-ID: <20081016234656.385520321@polymtl.ca>
References: <20081016232729.699004293@polymtl.ca>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759573AbYJQAB7@vger.kernel.org>
Content-Disposition: inline; filename=lttng-build-instrumentation-menu.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Steve
Cc: David Miller <davem@davemloft.net>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Ingo Molnar <mingo@redhat.com>, "William L. Irwin" <wli@holomorphy.com>
List-Id: linux-arch.vger.kernel.org

Adds the basic LTTng config options.

sparc32 needs to have ltt/ added to core-y for some reason (seems broken).

ltt/Kconfig is sourced from kernel/Kconfig.instrumentation.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: William L. Irwin <wli@holomorphy.com>
---
 Makefile            |    2 +-
 arch/sparc/Makefile |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6-lttng/arch/sparc/Makefile
===================================================================
--- linux-2.6-lttng.orig/arch/sparc/Makefile	2008-10-16 18:16:33.000000000 -0400
+++ linux-2.6-lttng/arch/sparc/Makefile	2008-10-16 18:16:38.000000000 -0400
@@ -37,7 +37,7 @@ drivers-$(CONFIG_OPROFILE)	+= arch/sparc
 # Renaming is done to avoid confusing pattern matching rules in 2.5.45 (multy-)
 INIT_Y		:= $(patsubst %/, %/built-in.o, $(init-y))
 CORE_Y		:= $(core-y)
-CORE_Y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/
+CORE_Y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/ ltt/
 CORE_Y		:= $(patsubst %/, %/built-in.o, $(CORE_Y))
 DRIVERS_Y	:= $(patsubst %/, %/built-in.o, $(drivers-y))
 NET_Y		:= $(patsubst %/, %/built-in.o, $(net-y))
Index: linux-2.6-lttng/Makefile
===================================================================
--- linux-2.6-lttng.orig/Makefile	2008-10-16 18:16:33.000000000 -0400
+++ linux-2.6-lttng/Makefile	2008-10-16 18:16:38.000000000 -0400
@@ -619,7 +619,7 @@ export mod_strip_cmd
 
 
 ifeq ($(KBUILD_EXTMOD),)
-core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/
+core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/ ltt/
 
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
