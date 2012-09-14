From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 13/31] arm64: Device specific operations
Date: Fri, 14 Sep 2012 17:31:59 +0000
Message-ID: <201209141731.59938.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <20120815003355.GF19607@quad.lixom.net> <20120914172944.GB2927@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:64286 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757503Ab2INRcH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Sep 2012 13:32:07 -0400
In-Reply-To: <20120914172944.GB2927@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Olof Johansson <olof@lixom.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>

On Friday 14 September 2012, Catalin Marinas wrote:
> (revisiting unanswered emails :))
> 
> On Wed, Aug 15, 2012 at 01:33:55AM +0100, Olof Johansson wrote:
> > On Tue, Aug 14, 2012 at 06:52:14PM +0100, Catalin Marinas wrote:
> > > +/*
> > > + *  I/O port access primitives.
> > > + */
> > > +#define IO_SPACE_LIMIT             0xffff
> > > +
> > > +/*
> > > + * We currently don't have any platform with PCI support, so just leave this
> > > + * defined to 0 until needed.
> > > + */
> > > +#define PCI_IOBASE         ((void __iomem *)0)
> > 
> > You could just leave out the PCI / I/O code alltogether instead.
> 
> I would leave this in as some of the first platforms to appear will have
> PCIe. At some point we'll add a fixed address where the PCI_IOBASE is
> mapped.
> 

I guess the cleanest way would be to reserve a virtual memory region right away
and document it in the file where you describe the memory layout. Then you can
fill the value in here.

	Arnd
