From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: microblaze syscall list
Date: Sun, 4 May 2008 21:37:13 +0200
Message-ID: <200805042137.17383.arnd@arndb.de>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com> <200805032357.41043.arnd@arndb.de> <481D7DF7.3000909@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.179]:56098 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520AbYEDTh0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 May 2008 15:37:26 -0400
In-Reply-To: <481D7DF7.3000909@seznam.cz>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: microblaze-uclinux@itee.uq.edu.au, Matthew Wilcox <matthew@wil.cx>, Will Newton <will.newton@gmail.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, git@xilinx.com, John Williams <john.williams@petalogix.com>, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>, John Linn <John.Linn@xilinx.com>

On Sunday 04 May 2008, Michal Simek wrote:

> > mremap is a duplicate, you only need it once ;-)
> 
> There are mixed mmu and nommu version - brk, munmap, mrepap are in both version
> but they take from different files.

That doesn't matter as the kernel is only ever built with one of the
two files. My point was just that you should have only one entry
in the syscall table if you generate it from your list.
 
> > right. sys_pipe and sys_mmap2 should probably go to fs/pipe.c and mm/mmap.c, but
> > that does not need to be your worry right now, it's not part of the ABI.
> 
> YES. sys_pipe was remove from all arch today. Patches from Uli. I'll remove
> sys_pipe from our sys_microblaze.c.

Ah, cool. I guess this leaves sys_mmap2, which we'll take care of eventually.
 
> Here is updated syscall table.

Thanks, looks good. I'd love to get a second opinion on the list though,
it's quite likely that I made a mistake somewhere.

Just three more calls I found:

> ok	.long sys_unlinkat
> ok	.long sys_unlink

> ok	.long sys_linkat
> ok	.long sys_link

> ok	.long sys_chown
> ok	.long sys_fchownat

For all of these, you only need the *at variant, afaict.

	Arnd <><
