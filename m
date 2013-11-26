From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [patch 4/6] ia64: Use preempt_schedule_irq
Date: Tue, 26 Nov 2013 10:37:59 -0800
Message-ID: <CA+8MBbL3oscq6GpgyTBb6hxdzuG+Gj_ahdu4rpvTTaPvrF+8_w@mail.gmail.com>
References: <20130917082838.218329307@infradead.org>
	<20130917182350.449685712@linutronix.de>
	<20130917183628.857145384@linutronix.de>
	<CA+8MBbKq1idWt1OSpRM3mWMDAQaEoewrU=h=m_pFoidVy6OA-Q@mail.gmail.com>
	<alpine.DEB.2.02.1311202121340.30673@ionos.tec.linutronix.de>
	<alpine.DEB.2.02.1311211230030.30673@ionos.tec.linutronix.de>
	<20131121130605.GE10022@twins.programming.kicks-ass.net>
	<alpine.DEB.2.02.1311211428450.30673@ionos.tec.linutronix.de>
	<CA+8MBbL4sBZK26O_+VQizNy-5mWtieDBfAy5CDcNBFxvorEp3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ve0-f169.google.com ([209.85.128.169]:45431 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834Ab3KZSiA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 26 Nov 2013 13:38:00 -0500
In-Reply-To: <CA+8MBbL4sBZK26O_+VQizNy-5mWtieDBfAy5CDcNBFxvorEp3g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andi Kleen <ak@linux.intel.com>, Peter Anvin <hpa@zytor.com>, Mike Galbraith <bitbucket@online.de>, Arjan van de Ven <arjan@linux.intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>

On Thu, Nov 21, 2013 at 10:57 AM, Tony Luck <tony.luck@gmail.com> wrote:
> On Thu, Nov 21, 2013 at 5:30 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Thu, 21 Nov 2013, Peter Zijlstra wrote:
>>> Anyway, I don't object to the patch per se, but it might bloat a few
>>> !ia64 kernels for having to carry the extra text.
>
> I tried it out ... if does fix both build & boot for ia64 with
> PREMPT=n and PREMPT=y
>
> Tested-by: Tony Luck <tony.luck@intel.com>

So - are we going with this patch?  Or still thinking of something better?

-Tony
