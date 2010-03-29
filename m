From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH -v9 00/31] use lmb with x86
Date: Mon, 29 Mar 2010 16:47:00 -0700
Message-ID: <4BB13BF4.3030906@kernel.org>
References: <1269830604-26214-1-git-send-email-yinghai@kernel.org>	 <1269865331.24620.44.camel@concordia>  <4BB0DAC2.3000805@kernel.org>	 <1269900605.2286.2.camel@concordia>  <4BB126F6.8020805@kernel.org> <1269905393.7101.39.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45042 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752252Ab0C2Xsn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 29 Mar 2010 19:48:43 -0400
In-Reply-To: <1269905393.7101.39.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: michael@ellerman.id.au, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 03/29/2010 04:29 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2010-03-29 at 15:17 -0700, Yinghai Lu wrote:
>>> That was the point of my other mail. We now have two lmb APIs, one
>> which
>>> checks if the array will overflow and one which doesn't. That seems
>> like
>>> a bad idea. Having one called lmb_free() and one called free_lmb()
>> is
>>> definitely a bad idea, because it's completely non obvious which one
>>> caters for overflow.
>>
>> I want to keep the affects to other lmb users to minium at first.
>>
>> and we can merge those functions later.
>>
>> or you insist on merging them in this patchset?
> 
> As a separate patch sure, but you should really separate the patch
> series that changes LMB from the one that moves x86 to it imho. It would
> make things much clearer.

Those patches should go through tip/x86 ?

Please check the patches only have "lmb:" in the subject.

> 
> It would also allow you to spend some time properly -documenting- why
> you need to change LMB the way you do, since it's non obvious for those
> not familiar with x86 needs. I'm not objecting to the changes, I'm just
> asking for much better documentation as to why they are needed and what
> function they provide.

Thanks, will try to write more changelog for next reversion.

Yinghai
