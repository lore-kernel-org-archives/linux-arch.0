Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-11.nifty.com ([210.131.2.78]:40153 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbeLKLD4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Dec 2018 06:03:56 -0500
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 00/27] kconfig: remove all reduce/shift conflicts, refactor lexer, fix various issues
Date: Tue, 11 Dec 2018 20:00:43 +0900
Message-ID: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-arch <linux-arch@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, David Howells <dhowells@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Herbert Xu <herbert@gondor.apana.org.au>, Michal Simek <monstr@monstr.eu>, linux-arm-kernel@lists.infradead.org
Message-ID: <20181211110043.uBlF_mI6fFePg91teq1OWtFZkJywO6KlYm7sJ3hb02w@z>


When I tryed to change something, I was often hit by annoying
shift/reduce conflicts in the parser.

The lexer and parser are too cluttered.

So, I decided to clean-up now.

  - Fix all shift/reduce conflicts in the parser

  - Rewrite the lexer. The linear keyword search was removed.
    The number of states descreased from 6 to 4.

  - Fix various subtle issues



Masahiro Yamada (27):
  kconfig: fix file name and line number of warn_ignored_character()
  kconfig: fix memory leak when EOF is encountered in quotation
  kconfig: require T_EOL to reduce visible statement
  kconfig: remove unneeded pattern matching to whitespaces
  kconfig: refactor pattern matching in STRING state
  kconfig: fix ambiguous grammar in terms of new lines
  kconfig: clean up EOF handling in the lexer
  kconfig: warn no new line at end of file
  kconfig: remove grammatically ambiguous "unexpected option" diagnostic
  kconfig: remove grammatically ambiguous option_error
  kconfig: remove redundant if_block rule
  kconfig: remove redundant menu_block rule
  kconfig: loosen the order of "visible" and "depends on" in menu entry
  kconfig: rename depends_list to comment_option_list
  kconfig: remove redundant token defines
  kconfig: use distinct tokens for type and default properties
  kconfig: refactor scanning and parsing "option" properties
  kconfig: use specific tokens instead of T_ASSIGN for assignments
  kconfig: use T_WORD instead of T_VARIABLE for variables
  microblaze: surround string default in Kconfig with double quotes
  treewide: surround file paths in Kconfig files with double quotes
  kconfig: ban the use of '.' and '/' in unquoted words
  kconfig: refactor end token rules
  kconfig: stop associating kconf_id with yylval
  kconfig: switch to ASSIGN_VAL state in the second lexer
  kconfig: update current_pos in the second lexer
  kconfig: remove keyword lookup table entirely

 arch/arm/Kconfig                 |   2 +-
 arch/arm/kvm/Kconfig             |   2 +-
 arch/arm64/Kconfig               |   2 +-
 arch/arm64/kvm/Kconfig           |   2 +-
 arch/ia64/Kconfig                |   2 +-
 arch/m68k/Kconfig                |   6 +-
 arch/microblaze/Kconfig.platform |   2 +-
 arch/mips/kvm/Kconfig            |   2 +-
 arch/openrisc/Kconfig            |   2 +-
 arch/powerpc/Kconfig             |   4 +-
 arch/powerpc/kvm/Kconfig         |   2 +-
 arch/riscv/Kconfig               |   2 +-
 arch/s390/Kconfig                |   2 +-
 arch/s390/kvm/Kconfig            |   2 +-
 arch/sh/Kconfig                  |   2 +-
 arch/sparc/Kconfig               |   2 +-
 arch/x86/Kconfig                 |   2 +-
 arch/x86/kvm/Kconfig             |   2 +-
 block/Kconfig                    |   2 +-
 crypto/Kconfig                   |   4 +-
 drivers/crypto/Kconfig           |   2 +-
 drivers/gpu/drm/i915/Kconfig     |   2 +-
 drivers/hwmon/Kconfig            |   2 +-
 drivers/i2c/Kconfig              |   6 +-
 drivers/pps/Kconfig              |   4 +-
 drivers/ras/Kconfig              |   2 +-
 drivers/thermal/Kconfig          |   2 +-
 drivers/w1/Kconfig               |   4 +-
 kernel/Kconfig.preempt           |   2 +-
 lib/Kconfig.debug                |   4 +-
 scripts/kconfig/kconf_id.c       |  52 --------
 scripts/kconfig/lkc.h            |  19 +--
 scripts/kconfig/menu.c           |  43 +++---
 scripts/kconfig/preprocess.c     |   3 +-
 scripts/kconfig/zconf.l          | 232 +++++++++++++++++---------------
 scripts/kconfig/zconf.y          | 280 ++++++++++++++++-----------------------
 security/Kconfig                 |  16 +--
 security/integrity/Kconfig       |   4 +-
 38 files changed, 313 insertions(+), 414 deletions(-)
 delete mode 100644 scripts/kconfig/kconf_id.c

-- 
2.7.4
