From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 2/7] sched: Add NEED_RESCHED to the preempt_count
Date: Wed, 11 Sep 2013 11:07:43 -0700
Message-ID: <CALCETrVU993N6HBkP-G2u-sCu6y6HOp9FknFpah+mpzztE=kkA@mail.gmail.com>
References: <20130910130811.507933095@infradead.org> <20130910132011.116593485@infradead.org>
 <522FCE9D.4010707@amacapital.net> <20130911082530.GN31370@twins.programming.kicks-ass.net>
 <20130911110635.GT26785@twins.programming.kicks-ass.net> <CALCETrUECkOZkxao0d1467rEFcSF3jzddNo1awshE4uK-wsWGQ@mail.gmail.com>
 <20130911180541.GR31370@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:34557 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755995Ab3IKSIF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Sep 2013 14:08:05 -0400
Received: by mail-vc0-f174.google.com with SMTP id gd11so6457723vcb.33
        for <linux-arch@vger.kernel.org>; Wed, 11 Sep 2013 11:08:03 -0700 (PDT)
In-Reply-To: <20130911180541.GR31370@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andi Kleen <ak@linux.intel.com>, Peter Anvin <hpa@zytor.com>, Mike Galbraith <bitbucket@online.de>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Len Brown <lenb@kernel.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

On Wed, Sep 11, 2013 at 11:05 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Sep 11, 2013 at 09:35:08AM -0700, Andy Lutomirski wrote:
>> I bet that this improves cross-cpu wakeup latency, too -- the old code
>> would presumably wake up the cpu and then immediately interrupt it.
>
> Yeah,. its what clued Mike in to there being a problem.
>
>> It might be nice to rename one or both of need_resched and
>> test_need_resched, though -- the difference is somewhat inscrutable.
>
> I agreed, I've just been unable to come up with anything sane.
>
> The best I could come up with is renaming
> {set,clear,test}_need_resched() to {}_tif_need_resched(), so we then end
> up with test_tif_need_resched(), which is slightly more different from
> need_resched().

Nothing great.  That's at least better than the current state, I think.

--Andy
