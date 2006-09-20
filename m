Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from saraswathi.solana.com ([198.99.130.12]:64450 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751600AbWITPIL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Sep 2006 11:08:11 -0400
Date: Wed, 20 Sep 2006 11:02:52 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: All arch maintainers: 'make headers_check' fails on most architectures.
Message-ID: <20060920150252.GC4134@ccure.user-mode-linux.org>
References: <1158079495.9189.125.camel@hades.cambridge.redhat.com> <1158680369.24527.443.camel@pmac.infradead.org> <20060919220338.GB7435@ccure.user-mode-linux.org> <200609200818.51572.arnd.bergmann@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609200818.51572.arnd.bergmann@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org, spyro@f2s.com, starvik@axis.com, ysato@users.sourceforge.jp, takata@linux-m32r.org, geert@linux-m68k.org, lethal@linux-sh.org, davem@davemloft.net, wli@holomorphy.com, uclinux-v850@lsi.nec.co.jp, chris@zankel.net, rmk@arm.linux.org.uk, dhowells <dhowells@redhat.com>, ralf@linux-mips.org, kyle@parisc-linux.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Sep 20, 2006 at 08:18:50AM +0200, Arnd Bergmann wrote:
> headers_check should check whatever files are installed by headers_install.
> I think the most sensible two choices there are:
> 
> 1. install the headers for the actual underlying architecture (SUBARCH)
> instead of the um headers.

I don't think UML should be installing i386 headers.

> 2. if ARCH=um, don't provide headers_install or headers_check targets.

Those are provided by the toplevel Makefile, so this would involve
wrapping an ifneq($ARCH, "um") around them, which doesn't seem too
palatable.

				Jeff
