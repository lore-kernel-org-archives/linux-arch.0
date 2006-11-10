Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:19610 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1424417AbWKJUrZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 10 Nov 2006 15:47:25 -0500
Subject: Re: [PATCH 1/2] Add arch specific dev_sysdata to struct device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20061110234757.27677dcd.sfr@canb.auug.org.au>
References: <1163141930.4982.143.camel@localhost.localdomain>
	 <20061110234757.27677dcd.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Sat, 11 Nov 2006 07:46:45 +1100
Message-Id: <1163191605.4982.175.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Arch list <linux-arch@vger.kernel.org>, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2006-11-10 at 23:47 +1100, Stephen Rothwell wrote:
> On Fri, 10 Nov 2006 17:58:50 +1100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > Adds an arch specific struct dev_sysdata to struct device. This enables
> > architecture to add specific fields to every device in the system, like
> > DMA operation pointers, NUMA node ID, firmware specific data, etc...
> >
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> I would have done this by creating a single line asm-xxx/device.h containing
> 
> #include <asm-generic/device.h>

A lot of archs will add custome things, so I felt it simpler that way,
but I can do it via asm-generic... Anybody else preferring it that
way ?

> (except for asm-generic, of course)  and then as each architecture implements
> its own dev_sysdata, it can flesh out its asm/device.h.
> 
> Also, I would use _ASM_<ARCH>_DEVICE_H, but thats just my preference.

Because I'm overly lazy, I prefer just cp'ing an identical file to all
asm-* dirs :-) Now I suppose it should be easy to do a little script to
get it "right". I'll look into it for the patch renaming it to
arch_data, I'll try to get that out later this morning.

Ben.


