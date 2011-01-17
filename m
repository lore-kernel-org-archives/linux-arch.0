From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] sched: provide scheduler_ipi() callback in response to
        smp_send_reschedule()
Date: Mon, 17 Jan 2011 11:57:48 +0000
Message-ID: <20110117115748.GA20615@n2100.arm.linux.org.uk>
References: <1295262433.30950.53.camel@laptop> <20110117112637.GA18599@n2100.arm.linux.org.uk> <1295263884.30950.54.camel@laptop> <1295264509.30950.59.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <1295264509.30950.59.camel@laptop>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Mike Frysinger <vapier@gentoo.org>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Hirokazu Takata <takata@linux-m32r.org>, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>lin
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 17, 2011 at 12:41:49PM +0100, Peter Zijlstra wrote:
> ===================================================================
> --- linux-2.6.orig/arch/arm/kernel/smp.c
> +++ linux-2.6/arch/arm/kernel/smp.c
> @@ -575,10 +575,7 @@ asmlinkage void __exception do_IPI(struc
>  				break;
>  
>  			case IPI_RESCHEDULE:
> -				/*
> -				 * nothing more to do - eveything is
> -				 * done on the interrupt return path
> -				 */
> +				scheduler_ipi();
>  				break;
>  
>  			case IPI_CALL_FUNC:

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
