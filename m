From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 30/56] microblaze_v2: includes SHM*, msgbuf
Date: Sun, 4 May 2008 23:10:32 +0200
Message-ID: <200805042310.34042.arnd@arndb.de>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz> <09ce2baf0c8308d3fbca98e7eb36a6aab59112a7.1209897266.git.monstr@monstr.eu> <c9418c683be99ae12abb89575c362d586c026bad.1209897266.git.monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.183]:64744 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758019AbYEDVLP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 May 2008 17:11:15 -0400
In-Reply-To: <c9418c683be99ae12abb89575c362d586c026bad.1209897266.git.monstr@monstr.eu>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>

On Sunday 04 May 2008, monstr@seznam.cz wrote:

>  include/asm-microblaze/msgbuf.h   |   41 +++++++++++++++++++++++++++++
>  include/asm-microblaze/shmbuf.h   |   52 +++++++++++++++++++++++++++++++++++++
>  include/asm-microblaze/shmparam.h |   16 +++++++++++
>  3 files changed, 109 insertions(+), 0 deletions(-)
>  create mode 100644 include/asm-microblaze/msgbuf.h
>  create mode 100644 include/asm-microblaze/shmbuf.h
>  create mode 100644 include/asm-microblaze/shmparam.h

Along with cleaning up the syscall interface, you should create asm-generic
versions of these files, ipcbuf.h and sembuf.h belong in the same category
(sysv IPC).

Unfortunately, most architectures have slightly different versions of them,
few of them really getting it right.
The version you have copied to microblaze is correct for little-endian
32 bit architectures, but not for big-endian architectures. The only
big-endian architectures that correctly implement padding are parisc,
powerpc, sparc, and the only one that gets 32 bit emulation right is
parisc (which, btw is a common scheme: if you want to know how to do
it, look at the parisc code).

I suppose it doesn't really matter much now, because SysV IPC is not
used a lot any more, and people have learned to live with the ill-defined
data structures. Most architectures have made the same mistake by
blindly copying the i386 version, so I'd suggest you take the version
you have and move that to asm-generic/{msg,shm,sem,ipc}buf.h, and
asm-generic/shmparam.h, so that every architecture using a copy of the
i386 headers can move to the generic one.

	Arnd <><
