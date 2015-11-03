Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:59454 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755888AbbKCTgY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Nov 2015 14:36:24 -0500
Message-ID: <1446579310.17404.36.camel@kernel.crashing.org>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 04 Nov 2015 06:35:10 +1100
In-Reply-To: <20151103131134.GA6384@lst.de>
References: <1446039110.3405.212.camel@infradead.org>
	 <20151102120659.GC4642@shamir-ThinkPad-T430>
	 <1446495208.17404.11.camel@kernel.crashing.org>
	 <5270615.Sf6ng964Qt@wuerfel>
	 <1446505693.17404.20.camel@kernel.crashing.org>
	 <20151103131134.GA6384@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Shamir Rabinovitch <shamir.rabinovitch@oracle.com>, David Woodhouse <dwmw2@infradead.org>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arch <linux-arch@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Jonathan Corbet <corbet@lwn.net>, KVM <kvm@vger.kernel.org>
Message-ID: <20151103193510.gjagZfNamJoOjyy2psQjo9_4zAHlHdyrlcc4NbxQfL4@z>

On Tue, 2015-11-03 at 14:11 +0100, Christoph Hellwig wrote:
> > xHCI for example, vs. something like 10G ethernet... but yes I agree it
> > sucks. I don't like that sort of policy anywhere in drivers. On the
> > other hand the platform doesn't have much information to make that sort
> > of decision either.
> 
> Mabye because it should simply use what's optimal?  E.g. passthrough
> whenever possible, where arguments against possible are:  dma_mask, vfio
> requirements, kernel command line option. 

Right this is what I do today on powerpc with the exception of
the command line option.

>  This is what a lot of
> architectures already do, I remember the SGI Origin / Altix code has the
> same behavior as well.  Those IOMMUs already had the 64 bit passthrough
> and 32-bit sliding window in addition to the real IOMMU 10 years ago.
> --
