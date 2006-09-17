Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.ocgnet.org ([64.20.243.3]:39884 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S932325AbWIQM1Y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 17 Sep 2006 08:27:24 -0400
Date: Sun, 17 Sep 2006 21:27:18 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: All arch maintainers: 'make headers_check' fails on most architectures.
Message-ID: <20060917122718.GA20902@localhost.usen.ad.jp>
References: <1158079495.9189.125.camel@hades.cambridge.redhat.com> <1158478779.24527.209.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158478779.24527.209.camel@pmac.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arch@vger.kernel.org, spyro@f2s.com, starvik@axis.com, ysato@users.sourceforge.jp, takata@linux-m32r.org, geert@linux-m68k.org, davem@davemloft.net, wli@holomorphy.com, jdike@karaya.com, uclinux-v850@lsi.nec.co.jp, chris@zankel.net, rmk@arm.linux.org.uk, dhowells <dhowells@redhat.com>, ralf@linux-mips.org, kyle@parisc-linux.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Sep 17, 2006 at 08:39:39AM +0100, David Woodhouse wrote:
> asm-sparc64/shmparam.h requires asm/spitfire.h, which does not exist in exported headers
> asm-xtensa/shmparam.h requires asm/processor.h, which does not exist in exported headers

For what it's worth, I suspect these two will have to do something
similar, as the dcache way size specifics won't be visible to userspace
under conventional means. This leaves the auxvt (alpha sets precedent
for this), or setting a value big enough to handle the aliasing
constraints.
