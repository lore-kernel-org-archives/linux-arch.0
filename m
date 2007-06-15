Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from canuck.infradead.org ([209.217.80.40]:51389 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbXFOMBA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jun 2007 08:01:00 -0400
Subject: Re: [PATCH] Introduce compat_u64 and compat_s64 types
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <200706151355.57464.ak@suse.de>
References: <200706150159.l5F1xNgM000459@hera.kernel.org>
	 <200706151128.39566.arnd@arndb.de> <200706151131.38429.arnd@arndb.de>
	 <200706151355.57464.ak@suse.de>
Content-Type: text/plain
Date: Fri, 15 Jun 2007 13:00:36 +0100
Message-Id: <1181908836.25228.452.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2007-06-15 at 13:55 +0200, Andi Kleen wrote:
> On Friday 15 June 2007 11:31:37 Arnd Bergmann wrote:
> > One common problem with 32 bit system call and ioctl emulation
> > is the different alignment rules between i386 and 64 bit machines.
> > A number of drivers work around this by marking the compat
> > structures as 'attribute((packed))', which is not the right
> > solution because it breaks all the non-x86 architectures that
> > want to use the same compat code.
> 
> Why does it break them? It should just make them a little slower.
> 
> The network code requires unaligned accesses to work
> anyways so if your architecture doesn't support them it is already
> remotely crashable.

alignof(uint64_t) is 8 on just about every 32-bit architecture except
i386. Using __attribute__((packed)) for the 32-on-64 compat code is thus
wrong on every 64-bit architecture except x86_64 and ia64.

It's the _location_ which is wrong; the handling of unaligned loads is
irrelevant (and Linux actually supports a bunch of architecture on which
fixups are impossible now, btw).

-- 
dwmw2

