Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:58308 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964960AbWIQMK0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 17 Sep 2006 08:10:26 -0400
Subject: Re: All arch maintainers: 'make headers_check' fails on most
	architectures.
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20060917115137.GA19084@localhost.usen.ad.jp>
References: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
	 <1158478779.24527.209.camel@pmac.infradead.org>
	 <20060917115137.GA19084@localhost.usen.ad.jp>
Content-Type: text/plain
Date: Sun, 17 Sep 2006 13:10:04 +0100
Message-Id: <1158495004.24527.236.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-arch@vger.kernel.org, drepper@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2006-09-17 at 20:51 +0900, Paul Mundt wrote:
> This is going to need a little bit more work, but I've just bumped the
> mask up for now. I just took care of the same issue on sh, so I'll carry
> over the same fix for that later. SHMLBA at 0x4000 is "good enough" for
> these caches for the time being, and fixes this issue. 

According to
http://git.kernel.org/git/?p=linux/kernel/git/dwmw2/kernel-headers.git;a=blob;h=2ff7b41d3f154ef8c44fce542929a6ac02bd6c67;hb=2c461ab5bc8d3334d4dc97412c974bf09412fccd;f=asm-sh/shmparam.h
you don't define SHMLBA in the exported headers at all for SH[34] -- the
equivalent would be just putting #ifdef __KERNEL__ around what you
currently have in include/asm-sh64/shmparam.h (before your patch).

That's probably not such an unreasonable response. If you're going to
make it depend on the CPU cache, then libc is going to have to either
work it out for itself or query the kernel somehow. Or just use the
maximum of all possible values.

I'm not averse to removing <asm/shmparam.h> from view on _all_
architectures. The less we have to export, the better :)

A bunch of architectures define it as PAGE_SIZE anyway, which is broken
when PAGE_SIZE gets killed off -- which we're doing either because it's
dynamic on the arch in question or just because we're killing it on a
bunch of architectures so we should kill it on all for consistency.
Userspace needs to learn to use getpagesize() or sysconf(_SC_PAGE_SIZE).

Hm, is there a sysconf(_SC_SHMLBA) ?

-- 
dwmw2

