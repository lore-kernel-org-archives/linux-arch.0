From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC][PATCH 0/5] tools, perf: Fix up for x86 UAPI disintegration
Date: Fri, 26 Oct 2012 15:04:36 +0900
Message-ID: <878vat93bf.fsf@sejong.aot.lge.com>
References: <20121024194619.GC17945@liondog.tnic>
	<20121019165558.23037.40181.stgit@warthog.procyon.org.uk>
	<20121024184337.GD13993@ghostprotocols.net>
	<8477.1351151840@warthog.procyon.org.uk>
	<87liet97jk.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:56819 "EHLO
	LGEMRELSE7Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756296Ab2JZGEh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Oct 2012 02:04:37 -0400
In-Reply-To: <87liet97jk.fsf@sejong.aot.lge.com> (Namhyung Kim's message of
	"Fri, 26 Oct 2012 13:33:19 +0900")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, mingo@kernel.org, tglx@linutronix.de, davem@davemloft.net, torvalds@linux-foundation.org, paulus@samba.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org

This time, I tried on tip/master since it seemed that it contains
related patches already.

At first I got a conflict with davem's change:

--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@@ -57,7 -53,6 +53,10 @@@ void get_term_dimensions(struct winsiz
  #endif
 =20
  #ifdef __sparc__
++<<<<<<< HEAD
 +#include "../../arch/sparc/include/uapi/asm/unistd.h"
++=3D=3D=3D=3D=3D=3D=3D
++>>>>>>> perf: Make perf build for x86 with UAPI disintegration applie=
d
  #define rmb()         asm volatile("":::"memory")
  #define cpu_relax()   asm volatile("":::"memory")
  #define CPUINFO_PROC  "cpu"


After resolving it, I got a tons of error mostly about redeclaration of
enum contants.  I managed to build perf with below patch:


------------ 8< ------------------- 8< -----------------
diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index da040ff69b2b..7a73f37696b7 100644
--- a/tools/perf/Makefile
+++ b/tools/perf/Makefile
@@ -170,7 +170,11 @@ endif
 ### --- END CONFIGURATION SECTION ---
=20
 ifeq ($(srctree),)
-srctree :=3D $(shell pwd)
+srctree :=3D $(shell cd ../../; pwd)
+endif
+
+ifeq ($(objtree),)
+objtree :=3D $(shell cd ../../; pwd)
 endif
=20
 BASIC_CFLAGS =3D \
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 618d41140abd..de882d5a4ab3 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -19,7 +19,6 @@
 #include "thread_map.h"
 #include "target.h"
 #include "../../../include/linux/hw_breakpoint.h"
-#include "../../../include/uapi/linux/perf_event.h"
 #include "perf_regs.h"
=20
 #define FD(e, x, y) (*(int *)xyarray__entry(e->fd, x, y))
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 6f94d6dea00f..9ac02f655124 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -3,7 +3,7 @@
=20
 #include <linux/list.h>
 #include <stdbool.h>
-#include "../../../include/uapi/linux/perf_event.h"
+#include <linux/perf_event.h>
 #include "types.h"
 #include "xyarray.h"
 #include "cgroup.h"
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 879d215cdac9..3c24404c8523 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -1,7 +1,7 @@
 #ifndef __PERF_HEADER_H
 #define __PERF_HEADER_H
=20
-#include "../../../include/uapi/linux/perf_event.h"
+#include <linux/perf_event.h>
 #include <sys/types.h>
 #include <stdbool.h>
 #include "types.h"
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-eve=
nts.h
index ac9a6aacf2f5..146684787adb 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -7,7 +7,7 @@
 #include <linux/list.h>
 #include <stdbool.h>
 #include "types.h"
-#include "../../../include/uapi/linux/perf_event.h"
+#include <linux/perf_event.h>
 #include "types.h"
=20
 struct list_head;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 39f3abac7744..8410897cc856 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -2,7 +2,7 @@
 #define __PMU_H
=20
 #include <linux/bitops.h>
-#include "../../../include/uapi/linux/perf_event.h"
+#include <linux/perf_event.h>
=20
 enum {
 	PERF_PMU_FORMAT_VALUE_CONFIG,
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index dd6426163ba6..1768581bb4a6 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -7,7 +7,7 @@
 #include "symbol.h"
 #include "thread.h"
 #include <linux/rbtree.h>
-#include "../../../include/uapi/linux/perf_event.h"
+#include <linux/perf_event.h>
=20
 struct sample_queue;
 struct ip_callchain;
------------ 8< ------------------- 8< -----------------

But it also failed to build like this:

    CC builtin-kvm.o
builtin-kvm.c:146:2: error: =E2=80=98DB_VECTOR=E2=80=99 undeclared here=
 (not in a function)
builtin-kvm.c:146:2: error: =E2=80=98BP_VECTOR=E2=80=99 undeclared here=
 (not in a function)
builtin-kvm.c:146:2: error: =E2=80=98UD_VECTOR=E2=80=99 undeclared here=
 (not in a function)
builtin-kvm.c:146:2: error: =E2=80=98PF_VECTOR=E2=80=99 undeclared here=
 (not in a function)
builtin-kvm.c:146:2: error: =E2=80=98NM_VECTOR=E2=80=99 undeclared here=
 (not in a function)
builtin-kvm.c:146:2: error: =E2=80=98MC_VECTOR=E2=80=99 undeclared here=
 (not in a function)
make: *** [builtin-kvm.o] Error 1


I can see that those are defined in arch/x86/include/asm/kvm.h.


Thanks,
Namhyung
