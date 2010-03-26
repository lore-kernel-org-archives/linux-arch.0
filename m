From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [patch 2/2] genirq: Remove IRQF_DISABLED from core code
Date: Fri, 26 Mar 2010 07:20:54 +0100
Message-ID: <20100326062054.GW20695@one.firstfloor.org>
References: <20100326000325.917127328@linutronix.de> <20100326000405.991244690@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:34022 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883Ab0CZGUz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Mar 2010 02:20:55 -0400
Content-Disposition: inline
In-Reply-To: <20100326000405.991244690@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <andi@firstfloor.org>, David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@suse.de>, Arnaldo Carvalho de Melo <acme@redhat.com>

On Fri, Mar 26, 2010 at 12:06:55AM -0000, Thomas Gleixner wrote:
> Remove all code which is related to IRQF_DISABLED from the core kernel
> code. IRQF_DISABLED still exists as a flag, but becomes a NOOP and
> will be removed after a grace period. That way we can easily revert to
> the previous behaviour by just restoring the core code.

Perhaps I'm dense but it's not fully clear to me why is suddenly safe to use 
the behaviour of this flags on shared interrupts when it wasn't before?

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
