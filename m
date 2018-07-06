Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57816 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753652AbeGFOHh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Jul 2018 10:07:37 -0400
Date: Fri, 6 Jul 2018 22:06:59 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Message-ID: <20180706140659.GB25190@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705175902.GF2530@hirez.programming.kicks-ass.net>
 <20180706114402.GB27148@guoren>
 <20180706120323.GW2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706120323.GW2476@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
Message-ID: <20180706140659.6QVkdcLCyabLJTyRBjQuNACmntYQvGLWkCgGnRJpTxY@z>

On Fri, Jul 06, 2018 at 02:03:23PM +0200, Peter Zijlstra wrote:
> > > Test-and-set with MB acting as ACQUIRE, ok.
> > Em ... Ok, I'll try to use test-and-set function instead of it.
> 
> "test-and-set" is just the name of this type of spinlock implementation.
> 
> You _could_ use the linux test_and_set bitop, but those are defined on
> unsigned long and spinlock_t is generally assumed to be of unsigned int
> size.
> 
> Go with the ticket locks as per below.
Ok, I'll learn it.

> > Ok, I'll try to implement ticket lock in next version patch.
> 
> If you need inspiration, look at:
> 
arch/arm/include/asm/spinlock.h
> 
> Or look at the current version of that file and ignore the LSE version.
> 
> Note that unlock is a store half-word (u16), not having seen your arch
> manual yet I don't know if you even have that.
Nice tips, thank you very much.

 Guo Ren
