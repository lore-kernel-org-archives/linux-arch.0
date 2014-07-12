From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/3] ARM: Use include/asm-generic/io.h
Date: Sat, 12 Jul 2014 14:27:22 +0200
Message-ID: <201407121427.22668.arnd@arndb.de>
References: <1405092672-18549-1-git-send-email-thierry.reding@gmail.com> <1405092672-18549-2-git-send-email-thierry.reding@gmail.com> <20140711162422.GF16321@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:58984 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbaGLM1g (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 12 Jul 2014 08:27:36 -0400
In-Reply-To: <20140711162422.GF16321@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Friday 11 July 2014, Catalin Marinas wrote:
> 
> On Fri, Jul 11, 2014 at 04:31:11PM +0100, Thierry Reding wrote:
> > diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> > index a78562f21aab..ef54f5c8a7ae 100644
> > --- a/arch/arm/include/asm/io.h
> > +++ b/arch/arm/include/asm/io.h
> [...]
> > -#define iowrite16be(v,p) ({ __iowmb(); __raw_writew((__force __u16)cpu_to_be16(v), p); })
> > -#define iowrite32be(v,p) ({ __iowmb(); __raw_writel((__force __u32)cpu_to_be32(v), p); })
> 
> Aren't you losing the barrier semantics here? The generic iowrite*be()
> functions call __raw_write*() directly which don't have a barrier
> (write* accessors do).
> 

Indeed, sorry for missing this. The generic implementation still makes sense for
include/asm-generic, but arm32 and arm64 must provide their own versions here.

An alternative would be to define

#define iowrite32be(v, p) iowrite32(swab32(v), p)

which is correct but can end up swapping multiple twice.

	Arnd
