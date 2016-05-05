From: Arnd Bergmann <arnd@arndb.de>
Subject: asm-generic syscall fix for 4.6-rc
Date: Thu, 05 May 2016 21:48:34 +0200
Message-ID: <4518228.KAZUJ4ZH78@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:57723 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757051AbcEETsj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2016 15:48:39 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

The following changes since commit 02da2d72174c61988eb4456b53f405e3ebdebce4:

  Linux 4.6-rc5 (2016-04-24 16:17:05 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git asm-generic-4.6

for you to fetch changes up to 1f93e9f2318b598e6775a1fc9701604993c512b1:

  asm-generic: use compat version for preadv2 and pwritev2 (2016-05-05 00:42:20 +0200)

----------------------------------------------------------------
asm-generic syscall fix for 4.6-rc

My last pull request for asm-generic had just one patch that added two
new system calls to asm/unistd.h, but unfortunately it turned out
to be wrong, pointing arch/tile compat mode at the native handlers
rather than the compat ones.

This was spotted by Yury Norov, who is working on ILP32 mode
for arch/arm64, which would have the same problem when merged.
This fixes the table to use the correct compat syscalls, like
the other 64-bit architectures do.

I'll try to find the time to come up with a solution that
prevents this problem from happening again, by allowing all
future system calls to just get added in a single file
for use by all architectures.

----------------------------------------------------------------
Yury Norov (1):
      asm-generic: use compat version for preadv2 and pwritev2

 include/uapi/asm-generic/unistd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
