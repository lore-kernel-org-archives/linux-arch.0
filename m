Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268213AbUIPUNN@vger.kernel.org>
Received: from [69.28.190.101] ([69.28.190.101]:34766 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S268209AbUIPUNN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2004 16:13:13 -0400
Date: Thu, 16 Sep 2004 16:13:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: RFC: being more anal about iospace accesses..
Message-ID: <20040916201308.GA8911@havoc.gtf.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <20040916134152.GK642@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0409161110070.2333@ppc970.osdl.org> <200409161152.54691.jbarnes@engr.sgi.com> <20040916130450.40b3f8a1.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916130450.40b3f8a1.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, torvalds@osdl.org, willy@debian.org, James.Bottomley@steeleye.com, geert@linux-m68k.org, linux-arch@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, davem@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Thu, Sep 16, 2004 at 01:04:50PM -0700, David S. Miller wrote:
> Drivers aren't allowed to touch active DMA data areas until they
> call one of those interfaces (see Documentation/DMA-mapping.txt)

Does that include DMA memory allocated with pci_alloc_consistent?

	Jeff
