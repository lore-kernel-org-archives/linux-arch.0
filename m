From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/2] kbuild: modversions for exported asm symbols
Date: Mon, 31 Oct 2016 22:14:45 +1100
Message-ID: <20161031221445.34e50e69@roar.ozlabs.ibm.com>
References: <20161015124352.10795-1-npiggin@gmail.com>
        <7315031.MmlhY1rulM@wuerfel>
        <20161020145827.453025a6@roar.ozlabs.ibm.com>
        <16513464.3RM484EDf1@wuerfel>
        <c9adb10a-1c5f-1b90-ead3-37c6665a903b@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34611 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936345AbcJaLPM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Oct 2016 07:15:12 -0400
In-Reply-To: <c9adb10a-1c5f-1b90-ead3-37c6665a903b@suse.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

On Sat, 22 Oct 2016 17:36:34 +0200
Michal Marek <mmarek@suse.com> wrote:

> Dne 20.10.2016 v 10:03 Arnd Bergmann napsal(a):
> > On Thursday, October 20, 2016 2:58:27 PM CEST Nicholas Piggin wrote:  
> >>
> >> Yeah, I had the same idea as you and Michal too. It's conceptually nicer,
> >> but in practice it turned into a mess. If some architectures wanted to start
> >> protecting their .h files and including them into .S for the prototypes, we
> >> could start parsing those too. Should we do the quick and dirty way for 4.9?  
> > 
> > Let's stay with your approach for now.  
> 
> Agreed.

My patch 2/2 needs the following incremental patch applied. It is
to preprocess the .S file properly as asm the same way the kernel
build does, and then building the dummy C from there.

Without this, we don't necessarily get proper symbol expansion or
get conditional compilation, etc. With it, genksyms should see what
the assembler sees.

---
 scripts/Makefile.build | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 2e512a2..6beeb9e 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -321,12 +321,19 @@ $(real-objs-m:.o=.s): modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)
 # or a file that it includes, in order to get versioned symbols. We build a
 # dummy C file that includes asm-prototypes and the EXPORT_SYMBOL lines from
 # the .S file (with trailing ';'), and run genksyms on that, to extract vers.
+# 
+# This is convoluted. The .S file must first be preprocessed to run guards and
+# expand names, then the resulting exports must be constructed into plain
+# EXPORT_SYMBOL(symbol); to build our dummy C file, and that gets preprocessed
+# to make the genksyms input.
 #
 # These mirror gensymtypes_c and co above, keep them in synch.
 cmd_gensymtypes_S =                                                         \
     (echo "\#include <linux/kernel.h>" ;                                    \
      echo "\#include <asm/asm-prototypes.h>" ;                              \
-     grep EXPORT_SYMBOL $< | sed 's/$$/;/' ) |                              \
+    $(CPP) $(a_flags) $< |                                                  \
+     grep ^___EXPORT_SYMBOL |                                               \
+     sed 's/___EXPORT_SYMBOL \([a-zA-Z0-9_]*\),.*/EXPORT_SYMBOL(\1);/' ) |  \
     $(CPP) -D__GENKSYMS__ $(c_flags) -xc - |                                \
     $(GENKSYMS) $(if $(1), -T $(2))                                         \
      $(patsubst y,-s _,$(CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX))             \
-- 
2.9.3
