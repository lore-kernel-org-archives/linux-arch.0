Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:49436 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725922AbeJVKJg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Oct 2018 06:09:36 -0400
Date: Mon, 22 Oct 2018 09:52:58 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V9 11/21] csky: Atomic operations
Message-ID: <20181022015258.GA3649@guoren-Inspiron-7460>
References: <cover.1539655731.git.ren_guo@c-sky.com>
 <efb6c9bb87f68c6f579ef497096086413effa5c2.1539655732.git.ren_guo@c-sky.com>
 <20181021205508.GJ4931@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181021205508.GJ4931@worktop.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, hch@infradead.org, marc.zyngier@arm.com, mark.rutland@arm.com, robh@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, c-sky_gcc_upstream@c-sky.com, Andrea Parri <andrea.parri@amarulasolutions.com>
Message-ID: <20181022015258.-rj0iOAxYS_7sNGEZXtAcrVx5pq4H0bvvAW3msBe_Ow@z>

Thx Peter, 

Your review has been a great help.

On Sun, Oct 21, 2018 at 10:55:08PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 16, 2018 at 10:58:30AM +0800, Guo Ren wrote:
> > +	smp_mb();
> > +	lock->tickets.owner++;
> 
> 	WRITE_ONCE(lock->tickets.owner, lock->tickets.owner + 1);
Yes, approve! I should use WRITE_ONCE/READ_ONCE as necessary.

> > +/*
> > + * Test-and-set spin-locking.
> > + */
> 
> I'm still not entirely sure why you want to have two spinlock
> implementations; to me that is just extra maintenance overhead.
Test and set (spinlock & rwlock) is easier for debug :P, and I don't
know the details of queue-rwlock (maybe I should learn it).
