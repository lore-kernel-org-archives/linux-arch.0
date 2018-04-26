Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:40967 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754584AbeDZIX3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Apr 2018 04:23:29 -0400
Date: Thu, 26 Apr 2018 10:25:12 +0200
From: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 06/22] arc: use generic dma_noncoherent_ops
Message-ID: <20180426082512.GB15580@lst.de>
References: <20180420080313.18796-1-hch@lst.de> <20180420080313.18796-7-hch@lst.de> <1524655020.5315.9.camel@synopsys.com> <20180426064500.GB13895@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426064500.GB13895@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "hch@lst.de" <hch@lst.de>, "deanbo422@gmail.com" <deanbo422@gmail.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "green.hu@gmail.com" <green.hu@gmail.com>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "monstr@monstr.eu" <monstr@monstr.eu>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Message-ID: <20180426082512.nQhREZ_urDlDg80rB2ae9DH8sQczl0OWc0JhSCpVJJE@z>

On Thu, Apr 26, 2018 at 08:45:00AM +0200, hch@lst.de wrote:
> On Wed, Apr 25, 2018 at 11:17:01AM +0000, Alexey Brodkin wrote:
> > Which is actually strange as I would expect ARC code to be built by bots.
> 
> I don't think I got any notification.  Thank for the fixes!
> 
> I think I found the bug, based on the fact that so far all tests for
> architectures that also need a cache op for device to cpu transitions
> failed.  I did a stupid typo when changing kconfig symbols, so please
> try the patch below.

Confirmed to work for nds32, so here is a git tree with the core, arc
and nds32 fixes folded in, feel free to test that one:

git://git.infradead.org/users/hch/misc.git generic-dma-noncoherent
