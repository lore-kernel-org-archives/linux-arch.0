From: Arnd Bergmann <arnd@arndb.de>
Subject: [GIT PULL] asm-generic: bugfix for v5.8
Date: Tue, 28 Jul 2020 14:42:19 +0200
Message-ID: <CAK8P3a2Qy0OOcXOO4twf3OKZ66ESTNT60nOR9i-ixcPubeUuVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:36081 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbgG1Mmh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jul 2020 08:42:37 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stafford Horne <shorne@gmail.com>, John Garry <john.garry@huawei.com>

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-fixes-5.8

for you to fetch changes up to 214ba3584b2e2c57536fa8aed52521ac59c5b448:

  io: Fix return type of _inb and _inl (2020-07-27 10:32:29 +0200)

----------------------------------------------------------------
asm-generic: bugfix for v5.8

This is a single bugfix for a regression introduced through a
typo in the v5.8 merge window, leading to incorrect data
returned from inl() on some architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Stafford Horne (1):
      io: Fix return type of _inb and _inl

 include/asm-generic/io.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
