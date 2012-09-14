From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 13/31] arm64: Device specific operations
Date: Fri, 14 Sep 2012 18:29:45 +0100
Message-ID: <20120914172944.GB2927@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-14-git-send-email-catalin.marinas@arm.com>
 <20120815003355.GF19607@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:46708 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756341Ab2INRa2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 14 Sep 2012 13:30:28 -0400
Content-Disposition: inline
In-Reply-To: <20120815003355.GF19607@quad.lixom.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Olof Johansson <olof@lixom.net>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <Will.Deacon@arm.com>

(revisiting unanswered emails :))

On Wed, Aug 15, 2012 at 01:33:55AM +0100, Olof Johansson wrote:
> On Tue, Aug 14, 2012 at 06:52:14PM +0100, Catalin Marinas wrote:
> > +/*
> > + *  I/O port access primitives.
> > + */
> > +#define IO_SPACE_LIMIT		0xffff
> > +
> > +/*
> > + * We currently don't have any platform with PCI support, so just leave this
> > + * defined to 0 until needed.
> > + */
> > +#define PCI_IOBASE		((void __iomem *)0)
> 
> You could just leave out the PCI / I/O code alltogether instead.

I would leave this in as some of the first platforms to appear will have
PCIe. At some point we'll add a fixed address where the PCI_IOBASE is
mapped.

-- 
Catalin
