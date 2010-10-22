From: Arnd Bergmann <arnd@arndb.de>
Subject: [GIT PULL] asm-generic changes
Date: Fri, 22 Oct 2010 14:36:46 +0200
Message-ID: <201010221436.46476.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:64851 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836Ab0JVMg6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 Oct 2010 08:36:58 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

A few small cleanups and fixes for include/asm-generic.
Please pull from:

  git+ssh://master.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master

---
Akinobu Mita (2):
      bitops: make asm-generic/bitops/find.h more generic
      bitops: remove duplicated extern declarations

Andrea Gelmini (1):
      asm-generic: kdebug.h: Checkpatch cleanup

Lucian Adrian Grijincu (1):
      asm-generic: fcntl: make exported headers use strict posix types

Mathieu Lacage (2):
      asm-generic: make atomic_add_unless a function
      asm-generic: cmpxchg does not handle non-long arguments

Mike Frysinger (1):
      asm-generic/io.h: allow people to override individual funcs

 arch/tile/include/asm/bitops.h    |    1 +
 arch/x86/include/asm/bitops.h     |    2 +
 include/asm-generic/atomic.h      |   34 ++++++++++++++--------------
 include/asm-generic/bitops/find.h |   39 ++++++++++++++++++++++++++++++-
 include/asm-generic/fcntl.h       |    2 +-
 include/asm-generic/io.h          |   26 +++++++++++++++++++++
 include/asm-generic/kdebug.h      |    2 +-
 include/asm-generic/system.h      |   20 +---------------
 include/linux/bitops.h            |   45 -------------------------------------
 9 files changed, 86 insertions(+), 85 deletions(-)
