Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.ocgnet.org ([64.20.243.3]:14735 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S932274AbWIQMU2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 17 Sep 2006 08:20:28 -0400
From: "lethal@ocgnet.org" <lethal@ocgnet.org>
Date: Sun, 17 Sep 2006 07:20:27 -0500
Subject: Re: All arch maintainers: 'make headers_check' fails on most architectures.
Message-ID: <20060917122027.GA20626@login.ocgnet.org>
References: <1158079495.9189.125.camel@hades.cambridge.redhat.com> <1158478779.24527.209.camel@pmac.infradead.org> <20060917115137.GA19084@localhost.usen.ad.jp> <1158495004.24527.236.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158495004.24527.236.camel@pmac.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arch@vger.kernel.org, drepper@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Sun, Sep 17, 2006 at 01:10:04PM +0100, David Woodhouse wrote:
> On Sun, 2006-09-17 at 20:51 +0900, Paul Mundt wrote:
> > This is going to need a little bit more work, but I've just bumped the
> > mask up for now. I just took care of the same issue on sh, so I'll carry
> > over the same fix for that later. SHMLBA at 0x4000 is "good enough" for
> > these caches for the time being, and fixes this issue. 
> 
> According to
> http://git.kernel.org/git/?p=linux/kernel/git/dwmw2/kernel-headers.git;a=blob;h=2ff7b41d3f154ef8c44fce542929a6ac02bd6c67;hb=2c461ab5bc8d3334d4dc97412c974bf09412fccd;f=asm-sh/shmparam.h
> you don't define SHMLBA in the exported headers at all for SH[34] -- the
> equivalent would be just putting #ifdef __KERNEL__ around what you
> currently have in include/asm-sh64/shmparam.h (before your patch).
> 
Yes, I've changed that for sh, it was broken.

> That's probably not such an unreasonable response. If you're going to
> make it depend on the CPU cache, then libc is going to have to either
> work it out for itself or query the kernel somehow. Or just use the
> maximum of all possible values.
> 
I opted for the latter. The problem was that we can have varying
configurations where the aliases need to be handled differently (or not at
all), and rather than having shmparam.h turn in to ifdef hell, I opted for
run-time probing and setting up an shm_align_mask (as MIPS also does), and
then wrapping arch_get_unmapped_area() around it.

> Userspace needs to learn to use getpagesize() or sysconf(_SC_PAGE_SIZE).
> 
uClibc does that now, so it's not an issue there. As an alternative solution,
I was playing with handing the cache desc through the ELF auxvt and doing
similar run-time setup for the mask there, since most architectures with an
aliasing dcache will have special hacks anyways.

It seems cleaner to simply use the "big enough to covering aliasing
constraints if they exist" case and let get_arch_unmapped_area() pack it a bit
tighter based off of run-time discovery in the cases where we really care
about it.
