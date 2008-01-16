Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate3.de.ibm.com ([195.212.29.152]:56453 "EHLO
	mtagate3.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbYAPJwe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jan 2008 04:52:34 -0500
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id m0G9qXJr174650
	for <linux-arch@vger.kernel.org>; Wed, 16 Jan 2008 09:52:33 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m0G9qWiv2838544
	for <linux-arch@vger.kernel.org>; Wed, 16 Jan 2008 10:52:32 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m0G9qVtd031115
	for <linux-arch@vger.kernel.org>; Wed, 16 Jan 2008 10:52:32 +0100
Subject: Re: [rfc][patch 2/2] mm: introduce optional pte_special pte bit
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20080116054831.GD14049@wotan.suse.de>
References: <alpine.LFD.1.00.0801151944120.2806@woody.linux-foundation.org>
	 <20080116043728.GA7684@wotan.suse.de>
	 <alpine.LFD.1.00.0801152040310.2806@woody.linux-foundation.org>
	 <20080115.205152.153390863.davem@davemloft.net>
	 <alpine.LFD.1.00.0801152119000.2806@woody.linux-foundation.org>
	 <20080116054831.GD14049@wotan.suse.de>
Content-Type: text/plain
Date: Wed, 16 Jan 2008 10:52:41 +0100
Message-Id: <1200477161.29080.18.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, hugh@veritas.com, jaredeh@gmail.com, cotte@de.ibm.com, heiko.carstens@de.ibm.com, linux-arch@vger.kernel.org

On Wed, 2008-01-16 at 06:48 +0100, Nick Piggin wrote:
> On Tue, Jan 15, 2008 at 09:23:57PM -0800, Linus Torvalds wrote:
> > On Tue, 15 Jan 2008, David Miller wrote:
> > >
> > > From: Linus Torvalds <torvalds@linux-foundation.org>
> > > Date: Tue, 15 Jan 2008 20:48:42 -0800 (PST)
> > > 
> > > > Can you give a pointer to some browsable archive?
> > > 
> > > http://marc.info/?l=linux-arch
> > 
> > .. and the discussion itself that actually explains why ARM has problems 
> > and why S390 suddenly _does_ have a bit for this after all?
> > 
> > (Not that I consider marc to be really "browsable" in the first place.. )
> > 
> > 		Linus
> 
> 
> I sent you an exact link to the thread on marc in an earlier message...
> not many others archive linux-arch or linux-mm unfortunately.
> 
> But no I didn't see a discussion of why s390 does have a bit, beyond the
> s390 devs just asserting there is one, and providing a patch ;) I never
> saw any of the discussions concluding that s390 does *not* have a bit
> spare. Do you recall if they were public?

Hmm, it all depends on the type of the pte. The hardware specs tell us
that the last 8 bits of a pte is software defined. There is the hardware
invalid bit 2**9 and the hardware read-only bit 2**10. Two of the
software defined bits and the two hardware bits are used for the page
type. The current code distinguishes 8 different types (the comments
says six but that is wrong :-/):

#define _PAGE_TYPE_EMPTY        0x400
#define _PAGE_TYPE_NONE         0x401
#define _PAGE_TYPE_SWAP         0x403
#define _PAGE_TYPE_FILE         0x601   /* bit 0x002 is used for offset !! */
#define _PAGE_TYPE_RO           0x200
#define _PAGE_TYPE_RW           0x000
#define _PAGE_TYPE_EX_RO        0x202
#define _PAGE_TYPE_EX_RW        0x002

The types where we have no free bits are _PAGE_TYPE_SWAP and
_PAGE_TYPE_FILE. That should be true for all architectures, since any
free bit could be used to increase the allowable size of the swap device
and the file-page offset. For 64 bit we could even make room for another
bit in the swap and file ptes since it won't hurt much to lower the swap
size / file-page offset. For 31 bit the bits are in short supply. In ESA
mode another 3 bits of the pte are reserved, they have to be zero or bad
things will happen (specification exceptions). So with the two hardware
and the two software bits a total of 7 bits of 32 bits are lost. As the
comment for _PAGE_TYPE_FILE indicates I was able to squeeze one more bit
out of a pte for file ptes. Which makes 25 free bits for a swap pte and
26 free bits for a file pte, or 32 4GB swap devices and 64GB max file
size for remap_file_pages. Again this is ONLY for 31 bit and ONLY for
the swap and file ptes. For pte_present() ptes we have 6 free bits.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.


