Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268240AbUIPUs7@vger.kernel.org>
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:40644
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268237AbUIPUs7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2004 16:48:59 -0400
Date: Thu, 16 Sep 2004 13:45:40 -0700
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: RFC: being more anal about iospace accesses..
Message-Id: <20040916134540.3cea892f.davem@davemloft.net>
In-Reply-To: <20040916201308.GA8911@havoc.gtf.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
	<20040916134152.GK642@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.58.0409161110070.2333@ppc970.osdl.org>
	<200409161152.54691.jbarnes@engr.sgi.com>
	<20040916130450.40b3f8a1.davem@davemloft.net>
	<20040916201308.GA8911@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Jeff Garzik <jgarzik@pobox.com>
Cc: jbarnes@engr.sgi.com, torvalds@osdl.org, willy@debian.org, James.Bottomley@steeleye.com, geert@linux-m68k.org, linux-arch@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, davem@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Thu, 16 Sep 2004 16:13:08 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> On Thu, Sep 16, 2004 at 01:04:50PM -0700, David S. Miller wrote:
> > Drivers aren't allowed to touch active DMA data areas until they
> > call one of those interfaces (see Documentation/DMA-mapping.txt)
> 
> Does that include DMA memory allocated with pci_alloc_consistent?

Good point.  No, it does not include consistent DMA memory.
I guess they do need it after all.
