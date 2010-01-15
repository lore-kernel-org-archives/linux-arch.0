From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: sys_recvmmsg: wire up or not?
Date: Fri, 15 Jan 2010 14:32:49 +1100
Message-ID: <1263526369.724.399.camel@pasglop>
References: <10f740e80912260239n17bbbd08w6c3065c12bde9c95@mail.gmail.com>
	 <200912261212.14264.arnd@arndb.de> <1263442833.724.325.camel@pasglop>
	 <20100113.202807.233259060.davem@davemloft.net>
	 <1263452379.724.348.camel@pasglop>
	 <20100114093322.GA3484@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:41330 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984Ab0AODeD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 14 Jan 2010 22:34:03 -0500
In-Reply-To: <20100114093322.GA3484@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: David Miller <davem@davemloft.net>, arnd@arndb.de, geert@linux-m68k.org, acme@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org

On Thu, 2010-01-14 at 09:33 +0000, Russell King wrote:
> On ARM, we used to use socketcall exclusively.  We've since added all
> the direct socket and IPC calls to our syscall table as part of the
> big EABI shakeup.  They certainly get used on EABI, whereas OABI has
> a choice.
> 
> They were made available in two stages - first the numbers were
> reserved
> and the calls were added to the call table.  A few years later, we
> exposed the syscall numbers in unistd.h.
> 
> It's now been almost 4 years since this was done, and there have been
> no bug reports. 

Agreed. It's definitely a switch we should do on powerpc. I'll look into
it after LCA.

Cheers,
Ben.
