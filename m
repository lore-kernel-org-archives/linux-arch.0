Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-cys01nam02on0134.outbound.protection.outlook.com ([104.47.37.134]:49386
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726265AbeHRVTt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 18 Aug 2018 17:19:49 -0400
From: Paul Burton <paul.burton@mips.com>
Subject: [PATCH v8 0/2] MIPS: Override barrier_before_unreachable() to fix microMIPS
Date: Sat, 18 Aug 2018 11:10:15 -0700
Message-ID: <20180818181017.1246-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mips@linux-mips.org
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, James Hogan <jhogan@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>, Ralf Baechle <ralf@linux-mips.org>
Message-ID: <20180818181015.QrAeJcxlihJMXQhOOmo52rmwtx-ccKpO6TtjUfBTJ8w@z>

This series overrides barrier_before_unreachable() for MIPS to add a
.insn assembler directive.

Due to the subsequent __builtin_unreachable(), the assembler can't tell
that a label on the empty inline asm is code rather than data, so any
microMIPS branches targeting it (which sadly can't be removed) raise
errors due to the mismatching ISA mode, Adding the .insn in patch 2
tells the assembler that it should be treated as code.

Applies cleanly atop v4.18.

Changes in v8 (Paul):
- Try something different... including a header that might be an
  asm-generic wrapper in linux/compiler_types.h creates build ordering
  problems for any C file which can be built before the asm-generic
  target. Patch 1 changes tact to avoid asm-generic & the ordering
  problem.
- Commit message improvements in patch 2.

Changes in v7 (Paul):
- Elaborate on affected GCC versions in patch 4.

Changes in v6 (Paul):
- Fix patch 2 to find the generated headers in $(objtree).
- Remove CC's for defunct MIPS email addresses (Matthew & Robert).
- CC linux-um@lists.infradead.org.

Changes in v5 (Paul):
- Rebase atop v4.18-rc8.
- Comment & commit message tweaks.
- Add SPDX-License-Identifier to asm-generic/compiler.h.

Changes in v4 (James):
- Fix asm-generic/compiler.h include from check, compiler_types.h is
  included on the command line so linux/compiler.h may not be included
  (kbuild test robot).
- New patch 2 to fix um (kbuild test robot).

Changes in v3 (James):
- New patch 1.
- Rebase after 4.17 arch removal and update commit messages.
- Use asm/compiler.h instead of compiler-gcc.h (Arnd).
- Drop stable tag for now.

Changes in v2 (Paul):
- Add generic-y entries to arch Kbuild files. Oops!

Previous versions:
v1: https://www.linux-mips.org/archives/linux-mips/2016-05/msg00399.html
v2: https://www.linux-mips.org/archives/linux-mips/2016-05/msg00401.html
v3: https://lkml.org/lkml/2018/4/17/228
v4: https://www.linux-mips.org/archives/linux-mips/2018-05/msg00069.html
v5: https://www.spinics.net/lists/mips/msg74408.html
v6: https://www.spinics.net/lists/mips/msg74425.html
v7: https://www.spinics.net/lists/linux-arch/msg47934.html

Older #ifdef-based attempt:
https://marc.info/?l=linux-mips&m=145555921408274&w=2

Paul Burton (2):
  kbuild: Allow asm-specific compiler_types.h
  MIPS: Workaround GCC __builtin_unreachable reordering bug

 arch/mips/include/asm/compiler_types.h | 39 ++++++++++++++++++++++++++
 include/linux/compiler-gcc.h           |  2 ++
 scripts/Makefile.lib                   |  5 +++-
 3 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/include/asm/compiler_types.h

-- 
2.18.0
