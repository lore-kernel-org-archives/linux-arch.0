Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from saraswathi.solana.com ([198.99.130.12]:57011 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751314AbWISPh3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Sep 2006 11:37:29 -0400
Date: Tue, 19 Sep 2006 11:31:29 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: All arch maintainers: 'make headers_check' fails on most architectures.
Message-ID: <20060919153129.GD4820@ccure.user-mode-linux.org>
References: <1158079495.9189.125.camel@hades.cambridge.redhat.com> <1158478779.24527.209.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158478779.24527.209.camel@pmac.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arch@vger.kernel.org, spyro@f2s.com, starvik@axis.com, ysato@users.sourceforge.jp, takata@linux-m32r.org, geert@linux-m68k.org, lethal@linux-sh.org, davem@davemloft.net, wli@holomorphy.com, uclinux-v850@lsi.nec.co.jp, chris@zankel.net, rmk@arm.linux.org.uk, dhowells <dhowells@redhat.com>, ralf@linux-mips.org, kyle@parisc-linux.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Sep 17, 2006 at 08:39:39AM +0100, David Woodhouse wrote:
> It may be that UM and ARM26 don't need to be exporting headers, because
> they can use headers from the host architecture

Yup.

> If that's the case, we should just remove the Kbuild files
> from those architectures' include directories.

Is it OK that this happens when I do that:

	/home/jdike/linux/2.6/linux-2.6.17/scripts/Makefile.headersinst:42: /home/jdike/linux/2.6/linux-2.6.17/include/asm-um/Kbuild: No such file or directory
	make[3]: *** No rule to make target `/home/jdike/linux/2.6/linux-2.6.17/include/asm-um/Kbuild'.  Stop.

				Jeff
