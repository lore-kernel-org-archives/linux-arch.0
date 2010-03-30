From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 07/31] lmb: Add reserve_lmb/free_lmb
Date: Mon, 29 Mar 2010 23:57:46 -0700
Message-ID: <4BB1A0EA.8050305@kernel.org>
References: <1269830604-26214-1-git-send-email-yinghai@kernel.org>	 <1269830604-26214-8-git-send-email-yinghai@kernel.org>	 <1269865322.24620.42.camel@concordia>  <4BB0D92C.3010103@kernel.org>	 <1269901252.2286.11.camel@concordia> <1269905491.7101.40.camel@pasglop>	 <4BB13FDB.9060006@kernel.org> <1269926794.7101.46.camel@pasglop>	 <4BB19656.9040803@kernel.org> <1269931562.15854.83.camel@concordia>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46003 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902Ab0C3G7z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 30 Mar 2010 02:59:55 -0400
In-Reply-To: <1269931562.15854.83.camel@concordia>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: michael@ellerman.id.au
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 03/29/2010 11:46 PM, Michael Ellerman wrote:
> On Mon, 2010-03-29 at 23:12 -0700, Yinghai Lu wrote:
>> On 03/29/2010 10:26 PM, Benjamin Herrenschmidt wrote:
>>> On Mon, 2010-03-29 at 17:03 -0700, Yinghai Lu wrote:
>>>>
>>>> in short: It could make us to avoid use the range that we are going to
>>>> reserve,
>>>>       when we try to get new position new lmb.reserved.region. 
>>>
>>> I'm not too sure I follow you. For the resizing, I would just basically
>>> call a low level variant of alloc (__lmb_alloc ?) that explicitely
>>> doesn't honor the total-2 "reserved" entries in the array.
>>
>> 1. you want to reserve rangeA
>> 2. before that will check if region array is big enough,
>> 3. if region is not big enough, will call lmb_alloc to get new range.
>>    lmb_alloc could return rangB that is overlapped with rangeA
> 
> So instead you do it the other way.
> 
> 1. you want to reserve rangeA
> 2. you reserve rangeA
> 3. if reserving rangeA consumed a slot in the array then you check if
> you have at least two free slots. If not you realloc. You don't need any
> special tricks because you have space to lmb_alloc() a new area and move
> everything over.

so that is check it later. should work.

one less find_lmb_area user.

Thanks

Yinghai
