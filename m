Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from anubis.se.axis.com ([195.60.68.12]:36483 "EHLO
	anubis.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420Ab2DWIFV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 23 Apr 2012 04:05:21 -0400
Date: Mon, 23 Apr 2012 09:58:06 +0200
From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [patch 02/18] smp: Add task_struct argument to __cpu_up()
Message-ID: <20120423075806.GQ16861@axis.com>
References: <20120420122120.097464672@linutronix.de> <20120420124556.964170564@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120420124556.964170564@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Matt Turner <mattst88@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mike Frysinger <vapier@gentoo.org>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Hirokazu Takata <takata@linux-m32r.org>, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Chris Metcalf <cmetcalf@tilera.com>, Richard Weinberger <richard@nod.at>, "x86@kernel.org" <x86@kernel.org>
Message-ID: <20120423075806.-ny8Ic9KU_VgCHspJ6P6Uw8oUHKAH5LJrlQNk9Rc-Wc@z>

On Fri, Apr 20, 2012 at 03:05:42PM +0200, Thomas Gleixner wrote:
> Preparatory patch to make the idle thread allocation for secondary
> cpus generic.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Mike Frysinger <vapier@gentoo.org>

For the CRIS part:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
