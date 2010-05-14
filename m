From: Yinghai Lu <yinghai.lu@oracle.com>
Subject: Re: [PATCH 05/35] x86, lmb: Add lmb_find_area_size()
Date: Fri, 14 May 2010 09:33:02 -0700
Message-ID: <4BED7B3E.5020308@oracle.com>
References: <1273796396-29649-1-git-send-email-yinghai@kernel.org>	 <1273796396-29649-6-git-send-email-yinghai@kernel.org>	 <1273803621.21352.368.camel@pasglop>  <4BECEDAA.9070009@oracle.com> <1273824809.21352.584.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:21721 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab0ENQai (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 May 2010 12:30:38 -0400
In-Reply-To: <1273824809.21352.584.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 05/14/2010 01:13 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2010-05-13 at 23:28 -0700, Yinghai wrote:
>   
>> this just line by line translation from early_res version to lmb
>> changes
>>
>> please focus on lmb core at this point.
>>     
> Well, the problem is that you dig into the LMB core with those functions
> which means I -will- break your stuff if/when I change it, for example
> to use linked lists.
>
>   
then you should don't even struct lmb, and move the definition from
lmb.h to lmb.c

> Besides, the code lacks comments and explanation in the changeset. So
> please provide that, I'm sure Thomas and Peter also want to understand
> what's going on in the x86 side of things.
>
>   
