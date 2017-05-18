From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched: remove sched_find_first_bit()
Date: Thu, 18 May 2017 09:14:11 +0200
Message-ID: <20170518071411.kb762lo5fmh7ffpe@gmail.com>
References: <20170513010152.13986-1-ynorov@caviumnetworks.com>
 <20170514180917.bil7xr4bqtfk6fzj@gmail.com>
 <20170515154728.amzw3d67tw722wmu@yury-N73SV>
 <20170516083042.ybenukaiiwevgqph@gmail.com>
 <20170517121636.3p75k77dxppfzaxg@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36432 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753868AbdERHOV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 May 2017 03:14:21 -0400
Content-Disposition: inline
In-Reply-To: <20170517121636.3p75k77dxppfzaxg@yury-N73SV>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Akinobu Mita <mita@miraclelinux.com>, Mike Galbraith <efault@gmx.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>


* Yury Norov <ynorov@caviumnetworks.com> wrote:

> On Tue, May 16, 2017 at 10:30:42AM +0200, Ingo Molnar wrote:
> > 
> > * Yury Norov <ynorov@caviumnetworks.com> wrote:
> > 
> > > I collected about 700 results in dmesg, and took 600 fastest.
> > > For the vanilla kernel, the average value is 368, and for patched
> > > kernel it is 388. It's 5% slower. But the standard deviation is 
> > > really big for both series' - 131 and 106 cycles respectively, which
> > > is ~ 30%. And so, my conclusion is: there's no benefit in using
> > > sched_find_first_bit() comparing to find_first_bit().
> > 
> > Erm, so you in essence claim:
> > 
> > 	"according to measurements the new code is 5% slower, with a high, 30% 
> > 	 stddev, hence the new code is better!"
> > 
> > Basic logic fail...
> > 
> > Thanks,
> > 
> > 	Ingo
> 
> No, in essence I claim that scatter is so big (in both cases, and in
> case of vanilla kernel even bigger) that 5% is not a meaningful
> difference. To be specific - new measured value is inside the
> confidence interval of previous one.

Firstly, the high spread is due to the poor measurement method: by increasing the 
number of measurements the standard deviation can be reduced.

Secondly, and most importantly, the claim you made based on the numbers is simply 
false:

> > > And so, my conclusion is: there's no benefit in using
> > > sched_find_first_bit() comparing to find_first_bit().

you _measured no benefit_, and in fact the result you got is leaning towards it 
being a benefit.

When doing a proper measurement it might strengthen, vanish or turn around - we 
simply don't know.

Thanks,

	Ingo
