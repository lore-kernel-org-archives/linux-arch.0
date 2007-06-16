Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from canuck.infradead.org ([209.217.80.40]:35455 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755490AbXFPLeU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 16 Jun 2007 07:34:20 -0400
Subject: Re: [PATCH] Introduce compat_u64 and compat_s64 types
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <200706161321.35940.arnd@arndb.de>
References: <200706150159.l5F1xNgM000459@hera.kernel.org>
	 <1181986686.25228.639.camel@pmac.infradead.org>
	 <200706161226.40875.arnd@arndb.de>  <200706161321.35940.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 16 Jun 2007 12:34:11 +0100
Message-Id: <1181993652.25228.690.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

On Sat, 2007-06-16 at 13:21 +0200, Arnd Bergmann wrote:
> On Saturday 16 June 2007, Arnd Bergmann wrote:
> > On Saturday 16 June 2007, David Woodhouse wrote:
> > > Will GCC know that it needs to emit code to handle that (mis)alignment?
> > 
> > I've tested this with gcc-4.0.3, and it does the right thing, which
> > is to split a 4 byte aligned 64 bit load/store into two 32 bit accesses,
> > if you pass -mstrict-align.
> 
> I just realized this was correct but slightly misleading. On powerpc, we
> don't set the 'attribute((aligned(4)))' on compat_64, so there is never
> a reason to handle the misalignment, even though it would work.

You're right. My question was probably not relevant -- all these 64-bit
architectures cope with misaligned loads anyway. If we ever have to deal
with 32-bit compat on a 64-bit architecture which can't handle
misalignment, I'm just going to hide under my desk and never come out.

> On x86_64, misaligned loads are always ok, so gcc never needs to
> care about this, even attribute((packed)) does not cause byte access
> here.

IA64 too, but it'll be handled there too -- either naturally or by
fixups; it doesn't matter.

-- 
dwmw2

