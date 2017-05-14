From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched: remove sched_find_first_bit()
Date: Sun, 14 May 2017 20:09:17 +0200
Message-ID: <20170514180917.bil7xr4bqtfk6fzj@gmail.com>
References: <20170513010152.13986-1-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36394 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754719AbdENSJW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 14 May 2017 14:09:22 -0400
Content-Disposition: inline
In-Reply-To: <20170513010152.13986-1-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Akinobu Mita <mita@miraclelinux.com>, Mike Galbraith <efault@gmx.de>


* Yury Norov <ynorov@caviumnetworks.com> wrote:

> sched_find_first_bit() is in fact the unrolled version of
> find_first_bit(), which is theoretically faster in some cases.
> But in the kernel it is called only in couple places in 
> kernel/sched/rt.c, and both of them are not looking like hot
> paths [...]

They are in terms of scheduling: pick_next_rt_entity() is in the RT scheduling 
fastpath.

Which makes me just suspicious of how careful this patch really is:

> that will doubtly achieve measurable benefit from using unrolled version of 
> find_first_bit() - there's no hard loops, and the execution path is not really 
> short.

... that's really just handwaving. Numbers please.

Thanks,

	Ingo
