Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40446 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbfGLVEs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Jul 2019 17:04:48 -0400
MIME-Version: 1.0
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 12 Jul 2019 23:04:31 +0200
Message-ID: <CAK8P3a1ic6ty+ktmur-77f-_=1hu4Drpt617jT8Bz3MMWixvoA@mail.gmail.com>
Subject: [GIT PULL] asm-generic: remove ptrace.h
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190712210431.37WnApDbs8RYH5CU81EYZRY7mlXwH4vnpinwC4ZZTiY@z>

The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

  Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-5.3

for you to fetch changes up to 7f3a8dff1219fba3076fe207972d1d7893c099bb:

  asm-generic: remove ptrace.h (2019-07-01 17:51:40 +0200)

----------------------------------------------------------------
asm-generic: remove ptrace.h

The asm-generic changes for 5.3 consist of a cleanup series from
Christoph Hellwig, who explains:

"asm-generic/ptrace.h is a little weird in that it doesn't actually
implement any functionality, but it provided multiple layers of macros
that just implement trivial inline functions.  We implement those
directly in the few architectures and be off with a much simpler
design."

Link: https://lore.kernel.org/lkml/20190624054728.30966-1-hch@lst.de/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Christoph Hellwig (5):
      arm64: don't use asm-generic/ptrace.h
      powerpc: don't use asm-generic/ptrace.h
      sh: don't use asm-generic/ptrace.h
      x86: don't use asm-generic/ptrace.h
      asm-generic: remove ptrace.h

 MAINTAINERS                       |  1 -
 arch/arm64/include/asm/ptrace.h   | 31 ++++++++++-------
 arch/mips/include/asm/ptrace.h    |  5 ---
 arch/powerpc/include/asm/ptrace.h | 29 ++++++++++++----
 arch/sh/include/asm/ptrace.h      | 29 +++++++++++++---
 arch/x86/include/asm/ptrace.h     | 30 +++++++++++++---
 include/asm-generic/ptrace.h      | 73 ---------------------------------------
 7 files changed, 91 insertions(+), 107 deletions(-)
 delete mode 100644 include/asm-generic/ptrace.h
