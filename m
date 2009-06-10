From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [Ksummit-2009-discuss] Representing Embedded Architectures at
 the Kernel Summit
Date: Wed, 10 Jun 2009 11:42:00 +0200
Message-ID: <20090610114200.7db59b00@surf>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
	<1244034286.24482.84.camel@pc1117.cambridge.arm.com>
	<1244045997.21423.303.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ns6.enix.org ([193.19.211.1]:46534 "EHLO the-doors.enix.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754650AbZFJJvD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Jun 2009 05:51:03 -0400
In-Reply-To: <1244045997.21423.303.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org

Le Wed, 03 Jun 2009 12:19:57 -0400,
James Bottomley <James.Bottomley@HansenPartnership.com> a =C3=A9crit :

> So ZONE_DMA and coherent memory allocation as represented by the
> coherent mask are really totally separate things.  The idea of
> ZONE_DMA was really that if you had an ISA device, allocations from
> ZONE_DMA would be able to access the allocated memory without
> bouncing.  Since ISA is really going away, this definition has been
> hijacked.  If your problem is just that you need memory allocated on
> a certain physical mask and neither GFP_DMA or GFP_DMA32 cut it for
> you, then we could revisit the kmalloc_mask() proposal again ... but
> the consensus last time was that no-one really had a compelling use
> case that couldn't be covered by GFP_DMA32.

Back a few years ago, I was working on a MIPS platform which had 256 MB
of RAM attached to the CPU memory controller and 128 MB attached to an
external memory controller. The layout of the memories was: 256 MB
CPU-attached memory first, and then the 128 MB
external-controller-attached memory.

Now, back to the DMA discussion: the Ethernet controller, which was
part of that external controller also driving the 128 MB bank of
memory, could only DMA to and from memory controlled by that same
controller (i.e only to the *top* 128 MB of the physical address
space). I'm by far not an mm expert, but as far as I could understand
the zone mechanism, it was not possible to describe such a
physical memory configuration where DMA-able memory is only at the top.

In the end, I ended up passing mem=3D..., managing manually a few
megabytes of memory at the top of the physical address space, and
hacking the Ethernet driver to copy back and forth the skb contents
between the main memory and the DMA-reserved memory.

So when Calatalin Marinas says =C2=AB currently ZONE_DMA is assumed to =
be in
the bottom part of the memory which isn't always the case =C2=BB, I can=
not
agree more.

Reference:
http://www.linux-mips.org/archives/linux-mips/2004-09/msg00152.html

Sincerly,

Thomas
--=20
Thomas Petazzoni, Free Electrons
Kernel, drivers and embedded Linux development,
consulting, training and support.
http://free-electrons.com
