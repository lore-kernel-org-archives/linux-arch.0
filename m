From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched: remove sched_find_first_bit()
Date: Tue, 16 May 2017 10:30:42 +0200
Message-ID: <20170516083042.ybenukaiiwevgqph@gmail.com>
References: <20170513010152.13986-1-ynorov@caviumnetworks.com>
 <20170514180917.bil7xr4bqtfk6fzj@gmail.com>
 <20170515154728.amzw3d67tw722wmu@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33273 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbdEPIaq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2017 04:30:46 -0400
Content-Disposition: inline
In-Reply-To: <20170515154728.amzw3d67tw722wmu@yury-N73SV>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Akinobu Mita <mita@miraclelinux.com>, Mike Galbraith <efault@gmx.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>


* Yury Norov <ynorov@caviumnetworks.com> wrote:

> I collected about 700 results in dmesg, and took 600 fastest.
> For the vanilla kernel, the average value is 368, and for patched
> kernel it is 388. It's 5% slower. But the standard deviation is 
> really big for both series' - 131 and 106 cycles respectively, which
> is ~ 30%. And so, my conclusion is: there's no benefit in using
> sched_find_first_bit() comparing to find_first_bit().

Erm, so you in essence claim:

	"according to measurements the new code is 5% slower, with a high, 30% 
	 stddev, hence the new code is better!"

Basic logic fail...

Thanks,

	Ingo
