Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:15449 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753654AbaGKOAb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 11 Jul 2014 10:00:31 -0400
Date: Fri, 11 Jul 2014 15:00:11 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 3/3] arm64: Use include/asm-generic/io.h
Message-ID: <20140711140011.GA16321@arm.com>
References: <1404918699-17284-1-git-send-email-thierry.reding@gmail.com>
 <201407101514.16530.arnd@arndb.de>
 <20140711121923.GE11473@arm.com>
 <201407111458.09884.arnd@arndb.de>
 <20140711130158.GA10827@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140711130158.GA10827@ulmo>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20140711140011.nPx6FjHJlLEtNBQF8dH0qlDhK3KL2QgQ-HlHTRvugnM@z>

On Fri, Jul 11, 2014 at 02:01:59PM +0100, Thierry Reding wrote:
> On Fri, Jul 11, 2014 at 02:58:09PM +0200, Arnd Bergmann wrote:
> > On Friday 11 July 2014, Catalin Marinas wrote:
> > > ioread32() is indeed an alias for readl on arm64 but if the address it
> > > gets as argument looks like an I/O port, it adds PCI_IOBASE (via the inl
> > > macro). This would no longer happen with Thierry's patches.
> > > 
> > > So I guess that for this patch to work, we also need ioport_map() to
> > > return an address from the PCI_IOBASE range. Should we merge this now as
> > > well:
> > > 
> > > http://linux-arm.org/git?p=linux-ld.git;a=commitdiff;h=3423064d8e42a38164a8436bcdf7434cf9cd2192
> > 
> > This is also part of patch 1/3 in Thierry's series.
> 
> The hunk in my patch 1/3 is missing the "& IO_SPACE_LIMIT", I can respin
> and include that.

OK, I missed this part. In which case, the patches look fine:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(I'm also happy to merge 1 and 3, whatever you prefer)
