Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:44190 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527AbbKCAZp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 2 Nov 2015 19:25:45 -0500
Message-ID: <1446505693.17404.20.camel@kernel.crashing.org>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 03 Nov 2015 10:08:13 +1100
In-Reply-To: <5270615.Sf6ng964Qt@wuerfel>
References: <1446039110.3405.212.camel@infradead.org>
	 <20151102120659.GC4642@shamir-ThinkPad-T430>
	 <1446495208.17404.11.camel@kernel.crashing.org>
	 <5270615.Sf6ng964Qt@wuerfel>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>, David Woodhouse <dwmw2@infradead.org>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arch <linux-arch@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Jonathan Corbet <corbet@lwn.net>, KVM <kvm@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Message-ID: <20151102230813.dD22GSpQ1G05l4UI_s3Xqpo9DAd2mreNqg3fcyzfePw@z>

On Mon, 2015-11-02 at 22:45 +0100, Arnd Bergmann wrote:
> > Then I would argue for naming this differently. Make it an optional
> > hint "DMA_ATTR_HIGH_PERF" or something like that. Whether this is
> > achieved via using a bypass or other means in the backend not the
> > business of the driver.
> > 
> 
> With a name like that, who wouldn't pass that flag? ;-)

xHCI for example, vs. something like 10G ethernet... but yes I agree it
sucks. I don't like that sort of policy anywhere in drivers. On the
other hand the platform doesn't have much information to make that sort
of decision either.

Cheers,
Ben.

