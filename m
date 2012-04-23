Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106]:53774 "EHLO
	e06smtp10.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899Ab2DWHKF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 23 Apr 2012 03:10:05 -0400
Received: from /spool/local
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
	Mon, 23 Apr 2012 08:10:04 +0100
Date: Mon, 23 Apr 2012 09:09:58 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 12/18] s390: Use generic idle thread allocation
Message-ID: <20120423090958.6904ae7b@de.ibm.com>
In-Reply-To: <20120420124557.652574928@linutronix.de>
References: <20120420122120.097464672@linutronix.de>
	<20120420124557.652574928@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Message-ID: <20120423070958.wrmoBPt0I2eJ0ohxLd25I9J4d-M2QyoKl8MzymFN1-g@z>

On Fri, 20 Apr 2012 13:05:52 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
>  arch/s390/Kconfig      |    1 +
>  arch/s390/kernel/smp.c |   33 ++-------------------------------
>  2 files changed, 3 insertions(+), 31 deletions(-)

Compile, boots & survives a few rounds of cpu hotplug stress.
Looks good.
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

