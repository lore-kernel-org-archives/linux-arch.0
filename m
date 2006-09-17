Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.ocgnet.org ([64.20.243.3]:18661 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S964963AbWIQL4n (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 17 Sep 2006 07:56:43 -0400
Date: Sun, 17 Sep 2006 20:56:37 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: All arch maintainers: 'make headers_check' fails on most architectures.
Message-ID: <20060917115637.GA20746@localhost.usen.ad.jp>
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
> As of today, a number of other architectures are fixed and we're left
> with a few stragglers whose headers may not be clean in the
> linux-kernel-headers tarball I intend to make based on the 2.6.18
> release.
> 
One minor nit, can we get unifdef shoved in to scripts/? Gentoo at least
didn't have it, and while Fedora and Debian both seem to, I suspect most
of the other distributions will not. It took at least a couple of
minutes to hunt down sensible source for it. It wouldn't be a bad idea
to include it until other distributions have a chance to integrate it..
