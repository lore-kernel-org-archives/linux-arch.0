Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f194.google.com ([209.85.222.194]:32811 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfIPTPV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Sep 2019 15:15:21 -0400
MIME-Version: 1.0
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 16 Sep 2019 21:15:04 +0200
Message-ID: <CAK8P3a0N9+-fmmg=oPVsKmoNb0vAYsASOneXUYBVAp8nyJEwdQ@mail.gmail.com>
Subject: [GIT PULL] asm-generic changes for v5.4
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Denis Efremov <efremov@linux.com>, Nicolas Pitre <nico@fluxnic.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20190916191504.vKvu-TJ8f9c66OtdlYCa4Y6DMHR24tIZsv2QvYXxMhI@z>

The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76:

  Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-5.4

for you to fetch changes up to 9b87647c665dbf93173ca2f43986902b59dfbbba:

  asm-generic: add unlikely to default BUG_ON(x) (2019-09-01 23:53:39 +0200)

----------------------------------------------------------------
asm-generic changes for v5.4

Here are three small cleanup patches for the include/asm-generic
directory. Christoph removes the __ioremap as part of a cleanup,
Nico improves the constant do_div() optimization, and Denis
changes BUG_ON() to be consistent with other implementations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Christoph Hellwig (1):
      asm-generic: don't provide __ioremap

Denis Efremov (1):
      asm-generic: add unlikely to default BUG_ON(x)

Nicolas Pitre (1):
      __div64_const32(): improve the generic C version

 include/asm-generic/bug.h   |  2 +-
 include/asm-generic/div64.h | 16 ++++++++++------
 include/asm-generic/io.h    |  9 ---------
 3 files changed, 11 insertions(+), 16 deletions(-)
