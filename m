Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59613 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760663AbYA1MXX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jan 2008 07:23:23 -0500
Date: Mon, 28 Jan 2008 12:20:30 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [RFC][PATCH 2/2] xtime_lock vs update_process_times
Message-ID: <20080128122030.GA14058@flint.arm.linux.org.uk>
References: <20080128103953.326762000@chello.nl> <20080128104056.184943000@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080128104056.184943000@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: rth@twiddle.net, bryan.wu@analog.com, dhowells@redhat.com, gerg@uclinux.org, lethal@linux-sh.org, wli@holomorphy.com, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu, torvalds@linux-foundation.org

On Mon, Jan 28, 2008 at 11:39:55AM +0100, Peter Zijlstra wrote:
> move update_process_times() out from under xtime_lock.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

Peter,

Mind if I merge:

>  arch/arm/common/time-acorn.c          |    2 --
>  arch/arm/mach-at91/at91sam926x_time.c |    3 ---
>  arch/arm/plat-iop/time.c              |    4 ----
>  arch/arm/plat-s3c24xx/time.c          |    2 --

with my patch and submit it as part of the ARM merge (which I'm hoping
to send in about an hours time.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
