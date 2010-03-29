From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH -v9 00/31] use lmb with x86
Date: Mon, 29 Mar 2010 15:17:26 -0700
Message-ID: <4BB126F6.8020805@kernel.org>
References: <1269830604-26214-1-git-send-email-yinghai@kernel.org>	 <1269865331.24620.44.camel@concordia>  <4BB0DAC2.3000805@kernel.org> <1269900605.2286.2.camel@concordia>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50152 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753124Ab0C2WTV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 29 Mar 2010 18:19:21 -0400
In-Reply-To: <1269900605.2286.2.camel@concordia>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: michael@ellerman.id.au
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 03/29/2010 03:10 PM, Michael Ellerman wrote:
> On Mon, 2010-03-29 at 09:52 -0700, Yinghai Lu wrote:
>> On 03/29/2010 05:22 AM, Michael Ellerman wrote:
>>> On Sun, 2010-03-28 at 19:42 -0700, Yinghai Lu wrote:
>>>> the new lmb could be used to early_res in x86.
>>>>
>>>> Suggested by: David, Ben, and Thomas
>>>>
>>>> First three patches should go into 2.6.34
>>>>
>>>> -v6: change sequence as requested by Thomas
>>>> -v7: seperate them to more patches
>>>> -v8: add boundary checking to make sure not free partial page.
>>>> -v9: use lmb_debug to control print out of reserve_lmb.
>>>>      add e820 clean up, and e820 become __initdata
>>>
>>> Bike shedding perhaps, but can you maintain the naming convention, ie.
>>> lmb_xxx() rather than xxx_lmb(). Neither is necessarily better, but all
>>> the existing functions use the lmb_xxx() style.
>>>
>>
>> so you want
>>
>> find_lmb_area ==> lmb_find_area
>> reserve_lmb ==> lmb_reserve
>> free_lmb ==> lmb_free
>>
>> first one is ok, 
>>
>> but next two we already have lmb_reserved and lmb_free without checking and increasing the size of region array.
> 
> That was the point of my other mail. We now have two lmb APIs, one which
> checks if the array will overflow and one which doesn't. That seems like
> a bad idea. Having one called lmb_free() and one called free_lmb() is
> definitely a bad idea, because it's completely non obvious which one
> caters for overflow.

I want to keep the affects to other lmb users to minium at first.

and we can merge those functions later.

or you insist on merging them in this patchset?

Yinghai
