From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH] sched: remove sched_find_first_bit()
Date: Wed, 17 May 2017 15:16:36 +0300
Message-ID: <20170517121636.3p75k77dxppfzaxg@yury-N73SV>
References: <20170513010152.13986-1-ynorov@caviumnetworks.com>
 <20170514180917.bil7xr4bqtfk6fzj@gmail.com>
 <20170515154728.amzw3d67tw722wmu@yury-N73SV>
 <20170516083042.ybenukaiiwevgqph@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2nam03on0077.outbound.protection.outlook.com ([104.47.42.77]:64342
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750795AbdEQMQr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 May 2017 08:16:47 -0400
Content-Disposition: inline
In-Reply-To: <20170516083042.ybenukaiiwevgqph@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Akinobu Mita <mita@miraclelinux.com>, Mike Galbraith <efault@gmx.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>

On Tue, May 16, 2017 at 10:30:42AM +0200, Ingo Molnar wrote:
> 
> * Yury Norov <ynorov@caviumnetworks.com> wrote:
> 
> > I collected about 700 results in dmesg, and took 600 fastest.
> > For the vanilla kernel, the average value is 368, and for patched
> > kernel it is 388. It's 5% slower. But the standard deviation is 
> > really big for both series' - 131 and 106 cycles respectively, which
> > is ~ 30%. And so, my conclusion is: there's no benefit in using
> > sched_find_first_bit() comparing to find_first_bit().
> 
> Erm, so you in essence claim:
> 
> 	"according to measurements the new code is 5% slower, with a high, 30% 
> 	 stddev, hence the new code is better!"
> 
> Basic logic fail...
> 
> Thanks,
> 
> 	Ingo

No, in essence I claim that scatter is so big (in both cases, and in
case of vanilla kernel even bigger) that 5% is not a meaningful
difference. To be specific - new measured value is inside the
confidence interval of previous one.

In fact I repeated measurements many times, and results always
different. Even 2 consequent measurements in the same configuration
may show difference ~10-15%. Arnd's unrolled version generates almost
identical assembler code, but also slower.

After all that fun, I think that measuring average value of the
function execution time is not the suitable approach. Maybe in this
case it would be better to compare fastest runs.

Anyway, are you OK if I drop alpha's implementation of sched_find_first_bit(),
move it to kernel/sched/rt.c and remove include/asm-generic/bitops/sched.h,
as Arnd suggested?

Yury
