From: Arnd Bergmann <arnd@arndb.de>
Subject: [GIT PULL] asm-generic changes for v5.4
Date: Mon, 16 Sep 2019 21:15:04 +0200
Message-ID: <CAK8P3a0N9+-fmmg=oPVsKmoNb0vAYsASOneXUYBVAp8nyJEwdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Denis Efremov <efremov@linux.com>, Nicolas Pitre <nico@fluxnic.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

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
