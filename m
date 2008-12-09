From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [patch] Performance Counters for Linux, v2
Date: Tue, 9 Dec 2008 13:14:11 +0100
Message-ID: <4d8e3fd30812090414v2e7a4bc3h621ca56e91ae367@mail.gmail.com>
References: <20081209110246.GC21618@elte.hu>
	 <20081209.031120.90683825.davem@davemloft.net>
	 <20081209112225.GD21618@elte.hu>
	 <20081209.032955.101042639.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:55684 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbYLIMON (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Dec 2008 07:14:13 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1066206ugf.37
        for <linux-arch@vger.kernel.org>; Tue, 09 Dec 2008 04:14:11 -0800 (PST)
In-Reply-To: <20081209.032955.101042639.davem@davemloft.net>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Ingo Molnar <mingo@elte.hu>
Cc: eranian@gmail.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, linux-arch@vger.kernel.org, akpm@linux-foundation.org, dada1@cosmosbay.com, robert.richter@amd.com, arjan@infradead.org, hpa@zytor.com, a.p.zijlstra@chello.nl, rostedt@goodmis.org, paulus@samba.org

On Tue, Dec 9, 2008 at 12:29 PM, David Miller <davem@davemloft.net> wrote:
> From: Ingo Molnar <mingo@elte.hu>
> Date: Tue, 9 Dec 2008 12:22:25 +0100
>
>>
>> * David Miller <davem@davemloft.net> wrote:
>>
>> > From: Ingo Molnar <mingo@elte.hu>
>> > Date: Tue, 9 Dec 2008 12:02:46 +0100
>> >
>> > >
>> > > * stephane eranian <eranian@googlemail.com> wrote:
>> > >
>> > > > > There's also more generic x86 support: all 4 generic PMCs of Nehalem
>> > > > > / Core i7 are supported - i've run 4 instances of KernelTop and they
>> > > > > used up four separate PMCs.
>> > > >
>> > > > Core/Atom have 5 counters, Nehalem has 7. Why are you not using all of
>> > > > them already?
>> > >
>> > > no, Nehalem has 4 generic purpose PMCs and 3 fixed-purpose PMCs (7
>> > > total),
>> >  ...
>> > > Saying that it has 7 is misleading.
>> >
>> > Even you just did.
>>
>> which portion of my point stressing the general purpose attribute was
>> unclear to you?
>
> I'm just teasing you because you picked a trite point from stephane's
> email instead of the meat later on, which I would have found more
> interesting to hear you comment on.

I'm interested in Ingo's comments on that argument as well but I don't
feel the need to act like were are all in a kindergarten.

You are two astonishing developers and I'm sure you can demonstrate
that you can have a pure technical discussion on this topic as you did
several times in the past.

Regards,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
http://mypage.vodafone.it/
