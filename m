From: Yinghai Lu <yinghai.lu@oracle.com>
Subject: Re: [PATCH 01/35] lmb: prepare x86 to use lmb to replace early_res
Date: Fri, 14 May 2010 09:23:17 -0700
Message-ID: <4BED78F5.2010501@oracle.com>
References: <1273796396-29649-1-git-send-email-yinghai@kernel.org>	 <1273796396-29649-2-git-send-email-yinghai@kernel.org>	 <1273803143.21352.353.camel@pasglop>  <4BECEB8D.8070600@oracle.com> <1273824578.21352.579.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:24027 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553Ab0ENQUi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 May 2010 12:20:38 -0400
In-Reply-To: <1273824578.21352.579.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 05/14/2010 01:09 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2010-05-13 at 23:19 -0700, Yinghai wrote:
>   
>>> If we expose LMB_ERROR then all lmb calls that can fail should
>>>       
>> return
>>     
>>> that. However, the API calls all return 0 instead. Changing that
>>>       
>> means
>>     
>>> fixing all callers.
>>>       
>> ok will stop use LMB_ERROR out lib/lmb.c
>>
>> will go back to use -1ULL for x86 path.
>>     
> No. That is not the point. Read the rest of my email !
>
> We need to -sanitize- those errors. _Maybe_ exposing LMB_ERROR is the
> right way to do so, but in that case, we need to make -all- function use
> the same error code. Right now, some fail with 0 and some with
> LMB_ERROR.
>   

will check what is effects for changing all to LMB_ERROR

> You are also not responding to my other comments such as:
>  
>   
>>> I'm also not too happy with exposing lmb_add_region(). Why would you
>>> ever need to expose it ? Just call lmb_reserve() if you want to
>>>       
>> reserve
>>     
>>> something. lmb_add_region() is an internal function and has no
>>>       
>> business
>>     
>>> being used outside of the main lmb.c file.
>>>       
in other mail. and updated version in the git dropped that
lmb_add_region exposing.

Thanks

Yinghai
