Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:19444 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974Ab1AZUAQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jan 2011 15:00:16 -0500
Received: from wpaz24.hot.corp.google.com (wpaz24.hot.corp.google.com [172.24.198.88])
	by smtp-out.google.com with ESMTP id p0QK0EKe020164
	for <linux-arch@vger.kernel.org>; Wed, 26 Jan 2011 12:00:14 -0800
Received: from pzk12 (pzk12.prod.google.com [10.243.19.140])
	by wpaz24.hot.corp.google.com with ESMTP id p0QK0CMk028472
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 26 Jan 2011 12:00:13 -0800
Received: by pzk12 with SMTP id 12so145311pzk.34
        for <linux-arch@vger.kernel.org>; Wed, 26 Jan 2011 12:00:12 -0800 (PST)
Date: Wed, 26 Jan 2011 12:00:08 -0800 (PST)
From: David Rientjes <rientjes@google.com>
Subject: Re: [patch] kconfig: unify GENERIC_ISA_DMA and ISA_DMA_API
In-Reply-To: <20110126112908.GD2562@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.1101261158490.13163@chino.kir.corp.google.com>
References: <alpine.DEB.2.00.1101251706040.9641@chino.kir.corp.google.com> <20110126112908.GD2562@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@redhat.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@suse.de>, Randy Dunlap <randy.dunlap@oracle.com>, x86@kernel.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20110126200008.Vlib0sWhpl7I7Kr1VGmQ8Myzfez8Oa_tNwKFPiaFHAY@z>

On Wed, 26 Jan 2011, Russell King - ARM Linux wrote:

> On Tue, Jan 25, 2011 at 05:06:28PM -0800, David Rientjes wrote:
> > CONFIG_GENERIC_ISA_DMA and CONFIG_ISA_DMA_API usually have dependencies
> > on one another depending on the architecture and generic kernel code uses
> > either to determine whether an ISA-style DMA API is configured.
> 
> Wrong.
> 
> GENERIC_ISA_DMA enables support for the standard ISA DMA allocator found
> in kernel/dma.c
> 
> ISA_DMA_API says that a platform supports the ISA DMA interfaces.
> 
> An architecture can provide the ISA DMA interfaces, but not use the
> standard ISA DMA allocator found in kernel/dma.c.  Such as the one in
> arch/arm/kernel/dma.c.
> 
> So on ARM, we have platforms where ISA_DMA_API=y but GENERIC_ISA_DMA=n.
> 

Ok, fair enough.  Thanks for pointing that out.  I'll work to resolve the 
existing dependency chain on x86 that cause build failures when one is 
disabled and another is not and add Kconfig dependencies on drivers that 
require GENERIC_ISA_DMA.
