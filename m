Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:27854 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751666AbWISPkR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Sep 2006 11:40:17 -0400
Subject: Re: All arch maintainers: 'make headers_check' fails on most
	architectures.
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20060919153129.GD4820@ccure.user-mode-linux.org>
References: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
	 <1158478779.24527.209.camel@pmac.infradead.org>
	 <20060919153129.GD4820@ccure.user-mode-linux.org>
Content-Type: text/plain
Date: Tue, 19 Sep 2006 16:39:29 +0100
Message-Id: <1158680369.24527.443.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-arch@vger.kernel.org, spyro@f2s.com, starvik@axis.com, ysato@users.sourceforge.jp, takata@linux-m32r.org, geert@linux-m68k.org, lethal@linux-sh.org, davem@davemloft.net, wli@holomorphy.com, uclinux-v850@lsi.nec.co.jp, chris@zankel.net, rmk@arm.linux.org.uk, dhowells <dhowells@redhat.com>, ralf@linux-mips.org, kyle@parisc-linux.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2006-09-19 at 11:31 -0400, Jeff Dike wrote:
> Is it OK that this happens when I do that:
> 
>         /home/jdike/linux/2.6/linux-2.6.17/scripts/Makefile.headersinst:42: /home/jdike/linux/2.6/linux-2.6.17/include/asm-um/Kbuild: No such file or directory
>         make[3]: *** No rule to make target
> `/home/jdike/linux/2.6/linux-2.6.17/include/asm-um/Kbuild'.  Stop.

Er, yes. I don't think it makes any sense to export headers specifically
for UM. I wonder why my shadow git tree has them...

-- 
dwmw2

