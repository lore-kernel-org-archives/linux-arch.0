From: Arnd Bergmann <arnd@arndb.de>
Subject: [GIT PULL] asm-generic: add new syscalls for 4.6
Date: Sat, 23 Apr 2016 23:33:17 +0200
Message-ID: <5983094.zeRXZxzCRP@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:55849 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbcDWVdY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 23 Apr 2016 17:33:24 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>, will.deacon@arm.com, Christoph Hellwig <hch@lst.de>

The following changes since commit c3b46c73264b03000d1e18b22f5caf63332547c9:

  Linux 4.6-rc4 (2016-04-17 19:13:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-4.6

for you to fetch changes up to 987aedb5d6f6e10c5203c6d0aab9a60ec22c7e93:

  generic syscalls: wire up preadv2 and pwritev2 syscalls (2016-04-23 22:38:08 +0200)

----------------------------------------------------------------
asm-generic changes for 4.6-rc

Here is one patch to wire up the preadv/pwritev system calls in the
generic system call table, which is required for all architectures
that were merged in the last few years, including arm64.

Usually these get merged along with the syscall implementation
or one of the architecture trees, but this time that did not
happen.

----------------------------------------------------------------

Andre and Christoph both sent a version of this patch, I picked the
one I got first.

Andre Przywara (1):
      generic syscalls: wire up preadv2 and pwritev2 syscalls

 include/uapi/asm-generic/unistd.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
