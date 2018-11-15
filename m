From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/8] kbuild: clean-up modversion, TRIM_UNUSED_KSYMS, if_changed_rule, etc.
Date: Thu, 15 Nov 2018 17:27:07 +0900
Message-ID: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>, Richard Weinberger <richard@nod.at>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jeff Dike <jdike@addtoit.com>
List-Id: linux-arch.vger.kernel.org

As a Kbuild maintainer, I always struggle to keep the core makefiles
clean because people tend to squeeze more and more clutter code into
the kbuild core in order to do what they want to do.

The biggest step forward in this series is to re-implement
the build trick of CONFIG_TRIM_UNUSED_KSYMS in a cleaner way.
scripts/Kbuild.include now looks nice again.
Also, in my rough estimation, building with CONFIG_TRIM_UNUSED_KSYMS
became 40-50 % faster.

Besides those, nice cleanups are here and there.



Masahiro Yamada (8):
  kbuild: remove redundant 'set -e' from filechk_* defines
  kbuild: remove redundant 'set -e' from sub_cmd_record_mcount
  kbuild: refactor modversions build rules
  kbuild: simplify dependency generation for CONFIG_TRIM_UNUSED_KSYMS
  kbuild: change if_changed_rule to accept multi-line recipe
  kbuild: remove trailing semicolon from cmd_* passed to if_changed_rule
  kbuild: refactor if_changed and if_changed_dep
  kbuild: remove redundant 'set -e' from cmd_* defines

 arch/um/Makefile             |  2 +-
 include/asm-generic/export.h | 13 +++---
 include/linux/export.h       | 18 ++++----
 scripts/Kbuild.include       | 44 +++-----------------
 scripts/Makefile.build       | 98 +++++++++++++++++++-------------------------
 scripts/Makefile.lib         |  2 +-
 scripts/basic/fixdep.c       | 31 ++------------
 scripts/gen_ksymdeps.sh      | 25 +++++++++++
 scripts/package/Makefile     |  1 -
 9 files changed, 96 insertions(+), 138 deletions(-)
 create mode 100755 scripts/gen_ksymdeps.sh

-- 
2.7.4
