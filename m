From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [patch 02/18] smp: Add task_struct argument to __cpu_up()
Date: Mon, 23 Apr 2012 09:58:06 +0200
Message-ID: <20120423075806.GQ16861@axis.com>
References: <20120420122120.097464672@linutronix.de> <20120420124556.964170564@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120420124556.964170564@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Matt Turner <mattst88@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mike Frysinger <vapier@gentoo.org>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Hirokazu Takata <takata@linux-m32r.org>, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Chris Metcalf <cmetcalf@tilera.com>Richard
List-Id: linux-arch.vger.kernel.org

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
