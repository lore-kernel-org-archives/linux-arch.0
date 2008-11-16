Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37093 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753286AbYKPQJi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 16 Nov 2008 11:09:38 -0500
Date: Sun, 16 Nov 2008 16:09:05 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Turn CONFIG_STRICT_DEVMEM in sysctl dev.mem.restricted
Message-ID: <20081116160905.17e867da@lxorguk.ukuu.org.uk>
In-Reply-To: <20081116080342.3d6c6976@infradead.org>
References: <1226846868-9595-1-git-send-email-bwalle@suse.de>
	<20081116150756.3cece2de@lxorguk.ukuu.org.uk>
	<20081116162003.04267538@kopernikus.site>
	<20081116154541.1f196f1e@lxorguk.ukuu.org.uk>
	<20081116080342.3d6c6976@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Bernhard Walle <bwalle@suse.de>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, crash-utility@redhat.com
Message-ID: <20081116160905.CBDuN0JUdRGR9T5bNTzt-jeMlSsAwm0dFatG9IS7Upo@z>

> because it can load kernel modules?
> or because it can bypass the iommu?

It has iopl, firmware loading, ioperm, raw disk I/O, mknod, module loading
etc etc.. 

> the point of the /dev/mem restrictions is to not allow things you know
> you don't need, while still allowing X to function where it can access
> the crap it does. Now in Bernhard's case he DOES need them, so he
> shouldn't use the restrictions.

I know what the point is, but it doesn't actually implement any
meaningful restriction to achieve that result, so it is worthless junk.

> > There are proper ways to deal with X, modern video cards and modern
> > security models. They involve using framebuffer mappings off the PCI
> > device node itself and DRI.
> > 
> when X has this for all hw that matters /dev/mem could go away for the
> people who then no longer have any need for it.

Why should it go away ? It's a matter of file permissions and security
rules as to who can access it. Trying to make it go away is just more
fake-security crap.

Alan
