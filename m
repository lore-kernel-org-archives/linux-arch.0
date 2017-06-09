From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/5] kbuild: thin archives use P option to ar
Date: Fri,  9 Jun 2017 15:24:14 +1000
Message-ID: <20170609052417.561-3-npiggin@gmail.com>
References: <20170609052417.561-1-npiggin@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35809 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751483AbdFIFYv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2017 01:24:51 -0400
In-Reply-To: <20170609052417.561-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>

The P option makes ar do full path name matching and can prevent ar
from discarding files with duplicate names in some cases of creating
thin archives from thin archives. The sh architecture in particular
loses some object files from its kernel/cpu/sh*/ directories without
this option.

This could be a bug in binutils ar, but the P option should not cause
any negative effects so it is safe to use to work around tihs with.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 scripts/Makefile.build | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 733e044fff8b..4a9a2cec0a1b 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -437,8 +437,8 @@ $(sort $(subdir-obj-y)): $(subdir-ym) ;
 ifdef builtin-target
 
 ifdef CONFIG_THIN_ARCHIVES
-  cmd_make_builtin = rm -f $@; $(AR) rcST$(KBUILD_ARFLAGS)
-  cmd_make_empty_builtin = rm -f $@; $(AR) rcST$(KBUILD_ARFLAGS)
+  cmd_make_builtin = rm -f $@; $(AR) rcSTP$(KBUILD_ARFLAGS)
+  cmd_make_empty_builtin = rm -f $@; $(AR) rcSTP$(KBUILD_ARFLAGS)
   quiet_cmd_link_o_target = AR      $@
 else
   cmd_make_builtin = $(LD) $(ld_flags) -r -o
@@ -478,7 +478,7 @@ ifdef lib-target
 quiet_cmd_link_l_target = AR      $@
 
 ifdef CONFIG_THIN_ARCHIVES
-  cmd_link_l_target = rm -f $@; $(AR) rcsT$(KBUILD_ARFLAGS) $@ $(lib-y)
+  cmd_link_l_target = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(lib-y)
 else
   cmd_link_l_target = rm -f $@; $(AR) rcs$(KBUILD_ARFLAGS) $@ $(lib-y)
 endif
@@ -531,7 +531,7 @@ cmd_link_multi-link = $(LD) $(ld_flags) -r -o $@ $(link_multi_deps) $(cmd_secana
 
 ifdef CONFIG_THIN_ARCHIVES
   quiet_cmd_link_multi-y = AR      $@
-  cmd_link_multi-y = rm -f $@; $(AR) rcST$(KBUILD_ARFLAGS) $@ $(link_multi_deps)
+  cmd_link_multi-y = rm -f $@; $(AR) rcSTP$(KBUILD_ARFLAGS) $@ $(link_multi_deps)
 else
   quiet_cmd_link_multi-y = LD      $@
   cmd_link_multi-y = $(cmd_link_multi-link)
-- 
2.11.0
