From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH 12/27] tile, smpboot: Use generic SMP booting infrastructure
Date: Fri, 1 Jun 2012 14:07:59 -0400
Message-ID: <4FC904FF.3070609@tilera.com>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com> <20120601091248.31979.59256.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:25297 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932480Ab2FASIB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jun 2012 14:08:01 -0400
In-Reply-To: <20120601091248.31979.59256.stgit@srivatsabhat.in.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, yong.zhang0@gmail.com, akpm@linux-foundation.org, vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, nikunj@linux.vnet.ibm.com

On 6/1/2012 5:12 AM, Srivatsa S. Bhat wrote:
> Convert tile to use the generic framework to boot secondary CPUs.
>
> Notes:
> 1. Don't enable interrupts in start_secondary().
> 2. Remove the unnecessary calls to local_irq_enable() in __cpu_up().
> 3. cpu_idle() was being called after doing a preempt_enable() instead
> of a preempt_disable()! Fix it.
>
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Yong Zhang <yong.zhang0@gmail.com>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---
>
>  arch/tile/kernel/smpboot.c |   22 ++++++++--------------
>  1 files changed, 8 insertions(+), 14 deletions(-)

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
