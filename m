Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:48414 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbeCOL2d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Mar 2018 07:28:33 -0400
Date: Thu, 15 Mar 2018 12:28:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: arc_usr_cmpxchg and preemption
Message-ID: <20180315112829.GW4064@hirez.programming.kicks-ass.net>
References: <1521045375.11552.27.camel@synopsys.com>
 <fdf30e76-f75d-9dda-26ca-ac011c41ee64@synopsys.com>
 <20180314175352.GP4064@hirez.programming.kicks-ass.net>
 <1521059931.11552.51.camel@synopsys.com>
 <20180315081845.GS4064@hirez.programming.kicks-ass.net>
 <1521105128.11552.64.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521105128.11552.64.camel@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Message-ID: <20180315112829.DzFk1N9zTSP9D7crqYvMKTrgWUhGw4IZScJhbhoDU6E@z>

On Thu, Mar 15, 2018 at 09:12:09AM +0000, Alexey Brodkin wrote:
> On Thu, 2018-03-15 at 09:18 +0100, Peter Zijlstra wrote:

> > Also, it might make sense to stuff this implementation in some lib/ file
> > somewhere and make all platforms that need it use the same code, afaict
> > there really isn't anything platform specific to it.
> 
> Not clear which part do you mean here.
> Are you talking about entire cmpxchg syscall implementation?

Yep.

> Do you think there're many users of that quite an inefficient
> [compared to proper HW version] atomic exchange?

I think there's a bunch of architectures that are in the same boat.
m68k, arm, mips was mentioned. Sure, the moment an arch has hardware
support you don't need the syscall anymore.

I was just thinking it would be good to have a common implementation (if
possible) rather than 4-5 different copies of basically the same thing.
