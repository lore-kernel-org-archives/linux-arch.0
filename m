Return-Path: <SRS0=qOhU=AN=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:50395 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726568AbgGBX1U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 19:27:20 -0400
From: Danny Lin <danny@kdrag0n.dev>
Subject: [PATCH v2] vmlinux.lds.h: Coalesce transient LLVM dead code elimination sections
Date: Thu,  2 Jul 2020 16:27:13 -0700
Message-ID: <20200702232713.123893-1-danny@kdrag0n.dev>
In-Reply-To: <7304fdf3-23d7-442b-b870-e88ae6f37004@localhost>
References: <7304fdf3-23d7-442b-b870-e88ae6f37004@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nathan Chancellor <natechancellor@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, Sami Tolvanen <samitolvanen@google.com>, Kees Cook <keescook@chromium.org>, Fangrui Song <maskray@google.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, Danny Lin <danny@kdrag0n.dev>, stable@vger.kernel.org
Message-ID: <20200702232713.R5d514196BSbcdRpHlv1I_IERsfrt-QAHUVdwXN466g@z>

A recent LLVM 11 commit [1] made LLD stop implicitly coalescing some
temporary LLVM sections, namely .{data,bss}..compoundliteral.XXX:

  [30] .data..compoundli PROGBITS         ffffffff9ac9a000  19e9a000
       000000000000cea0  0000000000000000  WA       0     0     32
  [31] .rela.data..compo RELA             0000000000000000  40965440
       0000000000001d88  0000000000000018   I      2238    30     8
  [32] .data..compoundli PROGBITS         ffffffff9aca6ea0  19ea6ea0
       00000000000033c0  0000000000000000  WA       0     0     32
  [33] .rela.data..compo RELA             0000000000000000  409671c8
       0000000000000948  0000000000000018   I      2238    32     8
  [...]
  [2213] .bss..compoundlit NOBITS           ffffffffa3000000  1d85c000
       00000000000000a0  0000000000000000  WA       0     0     32
  [2214] .bss..compoundlit NOBITS           ffffffffa30000a0  1d85c000
       0000000000000040  0000000000000000  WA       0     0     32
  [...]

.{data,bss}..L<symbol name> sections are also created in some cases.
While there aren't any in this example, they should also be coalesced to
be safe in case some config or future LLVM change makes it start
creating more of those sections in the future. For example, enabling
global merging causes ..L_MergedGlobals sections to be created, but it's
likely that other changes will result in such sections as well.

While these extra sections don't typically cause any breakage, they do
inflate the vmlinux size due to the overhead of storing metadata for
thousands of extra sections.

It's also worth noting that for some reason, some downstream Android
kernels can't boot at all if these sections aren't coalesced.

This issue isn't limited to any specific architecture; it affects arm64
and x86 if CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is forced on.

Example on x86 allyesconfig:
    Before: 2241 sections, 1171169 KiB
    After:    56 sections, 1170972 KiB

[1] https://github.com/llvm/llvm-project/commit/9e33c096476ab5e02ab1c8442cc3cb4e32e29f17

Link: https://github.com/ClangBuiltLinux/linux/issues/958
Cc: stable@vger.kernel.org # v4.4+
Suggested-by: Fangrui Song <maskray@google.com>
Signed-off-by: Danny Lin <danny@kdrag0n.dev>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
---
v2:
  - Fixed swapped example sizes
  - Added .{data,bss}..L* sections, since it looks like they're emitted
    in some cases even when LTO is disabled

 include/asm-generic/vmlinux.lds.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index db600ef218d7..737ecf782229 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -94,10 +94,11 @@
  */
 #ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
 #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
-#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..LPBX*
+#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..LPBX* \
+		  .data..compoundliteral* .data..L*
 #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
 #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]*
-#define BSS_MAIN .bss .bss.[0-9a-zA-Z_]*
+#define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..compoundliteral* .bss..L*
 #define SBSS_MAIN .sbss .sbss.[0-9a-zA-Z_]*
 #else
 #define TEXT_MAIN .text
-- 
2.27.0
