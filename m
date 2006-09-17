Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:54702 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964951AbWIQL7R (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 17 Sep 2006 07:59:17 -0400
Subject: Re: All arch maintainers: 'make headers_check' fails on most
	architectures.
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20060917115637.GA20746@localhost.usen.ad.jp>
References: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
	 <1158478779.24527.209.camel@pmac.infradead.org>
	 <20060917115637.GA20746@localhost.usen.ad.jp>
Content-Type: text/plain
Date: Sun, 17 Sep 2006 12:58:32 +0100
Message-Id: <1158494312.24527.226.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-arch@vger.kernel.org, spyro@f2s.com, starvik@axis.com, ysato@users.sourceforge.jp, takata@linux-m32r.org, geert@linux-m68k.org, davem@davemloft.net, wli@holomorphy.com, jdike@karaya.com, uclinux-v850@lsi.nec.co.jp, chris@zankel.net, rmk@arm.linux.org.uk, dhowells <dhowells@redhat.com>, ralf@linux-mips.org, kyle@parisc-linux.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2006-09-17 at 20:56 +0900, Paul Mundt wrote:
> One minor nit, can we get unifdef shoved in to scripts/? Gentoo at least
> didn't have it, and while Fedora and Debian both seem to, I suspect most
> of the other distributions will not. It took at least a couple of
> minutes to hunt down sensible source for it. It wouldn't be a bad idea
> to include it until other distributions have a chance to integrate it.. 

git-pull git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild

-- 
dwmw2

