From: Alexander van Heukelum <heukelum@fastmail.fm>
Subject: [PATCH 1/many] PROC macro to annotate functions in assembly files
Date: Wed, 17 Dec 2008 10:17:54 +0100
Message-ID: <1229505475-10219-2-git-send-email-heukelum@fastmail.fm>
References: <1229505475-10219-1-git-send-email-heukelum@fastmail.fm>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760221AbYLQJUm@vger.kernel.org>
In-Reply-To: <1229505475-10219-1-git-send-email-heukelum@fastmail.fm>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, Alexander van Heukelum <heukelum@mailshack.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, Cyrill Gorcunov <gorcunov@gmail.com>, Alexander van Heukelum <heukelum@fastmail.fm>
List-Id: linux-arch.vger.kernel.org

Introduce the PROC macro in the generic header file
include/linux/linkage.h to annotate functions in assembly
files. This is a first step to fully annotate functions
(procedures) in .S-files. The PROC macro complements the
already existing and being used ENDPROC macro. The generic
implementation of PROC is exactly the same as ENTRY.

The goal is to annotate functions, at least those called
from C code, with PROC at the beginning and ENDPROC at the
end. This is for the benefit of debugging and tracing. It
will also allow to introduce a framework to check for
nesting problems and missing annotations in a later stage
by overriding ENTRY/END and PROC/ENDPROC in architecture-
specific code, after the annotation errors have been fixed.

Signed-off-by: Alexander van Heukelum <heukelum@fastmail.fm>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/linkage.h |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index fee9e59..f4bb5a7 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -69,10 +69,18 @@
   .size name, .-name
 #endif
 
-/* If symbol 'name' is treated as a subroutine (gets called, and returns)
- * then please use ENDPROC to mark 'name' as STT_FUNC for the benefit of
- * static analysis tools such as stack depth analyzer.
+/*
+ * If symbol 'name' is treated as a subroutine (gets called, and returns)
+ * then please use PROC/ENDPROC to mark 'name' as STT_FUNC for the benefit
+ * of static analysis tools such as stack depth analyzer.
  */
+#ifndef PROC
+#define PROC(name) \
+  .globl name; \
+  ALIGN; \
+  name:
+#endif
+
 #ifndef ENDPROC
 #define ENDPROC(name) \
   .type name, @function; \
-- 
1.5.4.3
