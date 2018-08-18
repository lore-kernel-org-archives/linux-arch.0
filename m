Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-cys01nam02on0134.outbound.protection.outlook.com ([104.47.37.134]:49386
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726300AbeHRVTz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 18 Aug 2018 17:19:55 -0400
From: Paul Burton <paul.burton@mips.com>
Subject: [PATCH v8 1/2] kbuild: Allow asm-specific compiler_types.h
Date: Sat, 18 Aug 2018 11:10:16 -0700
Message-ID: <20180818181017.1246-2-paul.burton@mips.com>
In-Reply-To: <20180818181017.1246-1-paul.burton@mips.com>
References: <20180818181017.1246-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mips@linux-mips.org
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, James Hogan <jhogan@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>, Ralf Baechle <ralf@linux-mips.org>
Message-ID: <20180818181016.8U5kJNlwcF8yeoLp9-d7aQsjP-XDmsdzQQTl9jrQSAo@z>

We have a need to override the definition of
barrier_before_unreachable() for MIPS, which means we either need to add
architecture-specific code into linux/compiler-gcc.h or we need to allow
the architecture to provide a header that can define the macro before
the generic definition. The latter seems like the better approach.

A straightforward approach to the per-arch header is to make use of
asm-generic to provide a default empty header & adjust architectures
which don't need anything specific to make use of that by adding the
header to generic-y. Unfortunately this doesn't work so well due to
commit a95b37e20db9 ("kbuild: get <linux/compiler_types.h> out of
<linux/kconfig.h>") which moved the inclusion of linux/compiler.h to
cflags using the -include compiler flag.

Because the -include flag is present for all C files we compile, we need
the architecture-provided header to be present before any C files are
compiled. If any C files can be compiled prior to the asm-generic header
wrappers being generated then we hit a build failure due to missing
header. Such cases do exist - one pointed out by the kbuild test robot
is the compilation of arch/ia64/kernel/nr-irqs.c, which occurs as part
of the archprepare target [1].

This leaves us with a few options:

  1) Use generic-y & fix any build failures we find by enforcing
     ordering such that the asm-generic target occurs before any C
     compilation, such that linux/compiler_types.h can always include
     the generated asm-generic wrapper which in turn includes the empty
     asm-generic header. This would rely on us finding all the
     problematic cases - I don't know for sure that the ia64 issue is
     the only one.

  2) Add an actual empty header to each architecture, so that we don't
     need the generated asm-generic wrapper. This seems messy.

  3) Give up & add #ifdef CONFIG_MIPS or similar to
     linux/compiler_types.h. This seems messy too.

  4) Include the arch header only when it's actually needed, removing
     the need for the asm-generic wrapper for all other architectures.

This patch allows us to use approach 4, by including an
asm/compiler_types.h header using the -include flag in the same way we
do for linux/compiler_types.h, but only if the header actually exists.

[1] https://lists.01.org/pipermail/kbuild-all/2018-August/051175.html

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: James Hogan <jhogan@kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: linux-mips@linux-mips.org

---
Any thoughts anyone?

This isn't the prettiest it could possibly be but it's a small change &
clearly shouldn't break anything, which are good qualities for a patch
fixing build failures that we'd ideally backport as far as 4.16.

Changes in v8:
- New patch.

 scripts/Makefile.lib | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1bb594fcfe12..4e7b41ef029b 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -151,8 +151,11 @@ __a_flags	= $(call flags,_a_flags)
 __cpp_flags     = $(call flags,_cpp_flags)
 endif
 
+c_includes	= $(wildcard $(srctree)/arch/$(SRCARCH)/include/asm/compiler_types.h)
+c_includes	+= $(srctree)/include/linux/compiler_types.h
+
 c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
-		 -include $(srctree)/include/linux/compiler_types.h       \
+		 $(addprefix -include ,$(c_includes))                     \
 		 $(__c_flags) $(modkern_cflags)                           \
 		 $(basename_flags) $(modname_flags)
 
-- 
2.18.0
