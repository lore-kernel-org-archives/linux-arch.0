From: Arnd Bergmann <arnd@arndb.de>
Subject: [GIT PULL] asm-generic header fixes
Date: Thu, 10 Dec 2009 22:30:39 +0100
Message-ID: <200912102230.40258.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:58130 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761043AbZLJVbM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Dec 2009 16:31:12 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, liqin.chen@sunplusct.com, Mike Frysinger <vapier.adi@gmail.com>

Linus,

Please pull the asm-generic tree from

git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master

Very small updates and bug fixes only.

Thanks,

	Arnd

----
Arnd Bergmann (5):
  lib/checksum.c: use 32-bit arithmetic consistently
  lib/checksum.c: make do_csum optional
  lib/checksum: fix one more thinko
  asm-generic: add sys_accept4 to unistd.h
  asm-generic: add sys_recvmmsg to unistd.h

Chen Liqin (1):
  asm-generic: Fix typo in asm-generic/unistd.h.

Mike Frysinger (1):
  asm-generic/gpio.h: add some forward decls of the device struct

 include/asm-generic/gpio.h   |    3 +++
 include/asm-generic/unistd.h |   10 +++++++---
 lib/checksum.c               |   14 ++++++++------
 3 files changed, 18 insertions(+), 9 deletions(-)
