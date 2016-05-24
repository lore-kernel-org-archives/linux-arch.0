From: Arnd Bergmann <arnd@arndb.de>
Subject: [GIT PULL] asm-generic patch for v4.7
Date: Tue, 24 May 2016 22:12:51 +0200
Message-ID: <5341829.UN0BGB7Fal@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:63869 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932629AbcEXUN0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 May 2016 16:13:26 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>

The following changes since commit 1f93e9f2318b598e6775a1fc9701604993c512b1:

  asm-generic: use compat version for preadv2 and pwritev2 (2016-05-05 00:42:20 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-4.7

for you to fetch changes up to b0da6d44157aa6e652de7634343708251ba64146:

  asm-generic: Drop renameat syscall from default list (2016-05-05 00:42:21 +0200)

----------------------------------------------------------------
asm-generic patch for 4.7

I have only one patch for asm-generic in this release, this one is from
James Hogan and updates the generic system call table for renameat2
so we don't need to provide both renameat and renameat2 in newly
added architectures.

----------------------------------------------------------------
James Hogan (1):
      asm-generic: Drop renameat syscall from default list

 arch/arc/include/uapi/asm/unistd.h       | 1 +
 arch/arm64/include/uapi/asm/unistd.h     | 3 +++
 arch/c6x/include/uapi/asm/unistd.h       | 1 +
 arch/h8300/include/uapi/asm/unistd.h     | 2 ++
 arch/hexagon/include/uapi/asm/unistd.h   | 1 +
 arch/metag/include/uapi/asm/unistd.h     | 2 ++
 arch/nios2/include/uapi/asm/unistd.h     | 2 ++
 arch/openrisc/include/uapi/asm/unistd.h  | 1 +
 arch/score/include/uapi/asm/unistd.h     | 1 +
 arch/tile/include/uapi/asm/unistd.h      | 1 +
 arch/unicore32/include/uapi/asm/unistd.h | 2 ++
 include/uapi/asm-generic/unistd.h        | 3 +++
 12 files changed, 20 insertions(+)
