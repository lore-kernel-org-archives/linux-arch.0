Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33554 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfEPMJ0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 May 2019 08:09:26 -0400
MIME-Version: 1.0
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 16 May 2019 14:09:08 +0200
Message-ID: <CAK8P3a2+RHAReOZdo8nEvqDeC1EPj83L2Ug4JuVRiUh943AuNw@mail.gmail.com>
Subject: [GIT PULL] asm-generic: kill <asm/segment.h> and improve nommu
 generic uaccess helpers
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-riscv@lists.infradead.org
Message-ID: <20190516120908.DV87UmgQvdVtXw2jzGBZKHiicssJd9ESHUlO6vYwzIo@z>

[back from vacation now, sorry for the late pull request for this merge window]

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-nommu

for you to fetch changes up to 6edd1dbace0e8529ed167e8a5f9da63c0cc763cc:

  asm-generic: optimize generic uaccess for 8-byte loads and stores
(2019-04-23 21:51:41 +0200)

----------------------------------------------------------------
asm-generic: kill <asm/segment.h> and improve nommu generic uaccess helpers

Christoph Hellwig writes:

  This is a series doing two somewhat interwinded things.  It improves
  the asm-generic nommu uaccess helper to optionally be entirely generic
  and not require any arch helpers for the actual uaccess.  For the
  generic uaccess.h to actually be generically useful I also had to kill
  off the mess we made of <asm/segment.h>, which really shouldn't exist
  on most architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Christoph Hellwig (4):
      asm-generic: don't include <asm/segment.h> from <asm/uaccess.h>
      arch: mostly remove <asm/segment.h>
      asm-generic: provide entirely generic nommu uaccess
      asm-generic: optimize generic uaccess for 8-byte loads and stores

 arch/alpha/include/asm/segment.h   |  6 ----
 arch/alpha/kernel/smc37c669.c      |  1 -
 arch/alpha/kernel/smc37c93x.c      |  1 -
 arch/arc/include/asm/uaccess.h     |  1 +
 arch/arm/include/asm/Kbuild        |  1 -
 arch/arm64/include/asm/Kbuild      |  1 -
 arch/c6x/include/asm/Kbuild        |  1 -
 arch/h8300/Kconfig                 |  1 +
 arch/h8300/include/asm/Kbuild      |  1 +
 arch/h8300/include/asm/uaccess.h   | 55 ------------------------------------
 arch/hexagon/include/asm/Kbuild    |  1 -
 arch/hexagon/include/asm/uaccess.h |  1 -
 arch/ia64/include/asm/segment.h    |  6 ----
 arch/mips/include/asm/Kbuild       |  1 -
 arch/nds32/include/asm/Kbuild      |  1 -
 arch/nios2/include/asm/Kbuild      |  1 -
 arch/openrisc/include/asm/Kbuild   |  1 -
 arch/openrisc/kernel/ptrace.c      |  1 -
 arch/openrisc/kernel/setup.c       |  1 -
 arch/openrisc/kernel/traps.c       |  1 -
 arch/openrisc/mm/init.c            |  1 -
 arch/openrisc/mm/tlb.c             |  1 -
 arch/parisc/include/asm/Kbuild     |  1 -
 arch/s390/include/asm/segment.h    |  5 ----
 arch/s390/kernel/ptrace.c          |  1 -
 arch/unicore32/include/asm/Kbuild  |  1 -
 arch/xtensa/include/asm/segment.h  | 16 -----------
 include/asm-generic/segment.h      |  9 ------
 include/asm-generic/uaccess.h      | 58 +++++++++++++++++++++++++++++++++++++-
 lib/Kconfig                        |  4 +++
 30 files changed, 64 insertions(+), 117 deletions(-)
 delete mode 100644 arch/alpha/include/asm/segment.h
 delete mode 100644 arch/h8300/include/asm/uaccess.h
 delete mode 100644 arch/ia64/include/asm/segment.h
 delete mode 100644 arch/s390/include/asm/segment.h
 delete mode 100644 arch/xtensa/include/asm/segment.h
 delete mode 100644 include/asm-generic/segment.h
