From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH -v18 00/37] Use lmb with x86
Date: Wed, 16 Jun 2010 08:43:49 -0700
Message-ID: <4C18F135.20807@kernel.org>
References: <1276666966-14259-1-git-send-email-yinghai@kernel.org>	 <AANLkTinhO5sFs4YRP3nraC_ldZ8ZgzJBOQYYv9jLd_Dw@mail.gmail.com> <1276677680.2552.205.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:43044 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320Ab0FPPpB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jun 2010 11:45:01 -0400
In-Reply-To: <1276677680.2552.205.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Johannes Weiner <hannes@cmpxchg.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On 06/16/2010 01:41 AM, Benjamin Herrenschmidt wrote:
> On Tue, 2010-06-15 at 23:10 -0700, Linus Torvalds wrote:
>> On Tuesday, June 15, 2010, Yinghai Lu <yinghai@kernel.org> wrote:
>>>
>>>  46 files changed, 1476 insertions(+), 1282 deletions(-)
>>
>> So what was the advantage again? It's adding more lines than it
>> removes. Wasn't the point to simplify things, not make them bigger?
> 
> I -think- the point is that once that's done, you can remove a whole lot
> of gunk that was added such as the kernel/range.c caca, etc...
> (basically, x86 gunk gratuituously made generic and that should really
> just die instead).

right.

this patch include seperate bootmem.c into bootmem.c and nobootmem.c to reduce
MACRO according Ingo and others.
 mm/bootmem.c                    |  165 +----------
 mm/nobootmem.c                  |  415 +++++++++++++++++++++++++++

later will
1. remove x86 own copy for find_from_low_to_high after more testing with high to low. that is about 200 lines code.
2. replace range.c with lmb. but need to expand lmb little bit
   like add can_resize and can_merge to be attribute of lmb_type.

Thanks

Yinghai Lu
