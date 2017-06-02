Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50595 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750884AbdFBItG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Jun 2017 04:49:06 -0400
From: Aleksa Sarai <asarai@suse.de>
Subject: [PATCH v2 0/1] tty: add TIOCGPTPEER ioctl
Date: Fri,  2 Jun 2017 18:48:57 +1000
Message-ID: <20170602084858.4299-1-asarai@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Aleksa Sarai <asarai@suse.de>
Message-ID: <20170602084857.RthaRNSvCI8PD2j8WlEs4cyN2kBQJzv33vxAqAkfTEM@z>

Changes in v2:

  * Reordered addition to ioctls.h to follow correct hex ordering.

Aleksa Sarai (1):
  tty: add TIOCGPTPEER ioctl

 arch/alpha/include/uapi/asm/ioctls.h   |  1 +
 arch/mips/include/uapi/asm/ioctls.h    |  1 +
 arch/parisc/include/uapi/asm/ioctls.h  |  1 +
 arch/powerpc/include/uapi/asm/ioctls.h |  1 +
 arch/sh/include/uapi/asm/ioctls.h      |  1 +
 arch/sparc/include/uapi/asm/ioctls.h   |  3 +-
 arch/xtensa/include/uapi/asm/ioctls.h  |  1 +
 drivers/tty/pty.c                      | 71 ++++++++++++++++++++++++++++++++--
 include/uapi/asm-generic/ioctls.h      |  1 +
 9 files changed, 76 insertions(+), 5 deletions(-)

-- 
2.13.0
