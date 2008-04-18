Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:46568 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753925AbYDRJ7H (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 Apr 2008 05:59:07 -0400
Message-ID: <480870E2.20507@goop.org>
Date: Fri, 18 Apr 2008 19:58:58 +1000
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
Subject: Re: [patch 2/2]: introduce fast_gup
References: <20080328025455.GA8083@wotan.suse.de>	 <20080328030023.GC8083@wotan.suse.de> <1208444605.7115.2.camel@twins>	 <alpine.LFD.1.00.0804170814090.2879@woody.linux-foundation.org> <1208448768.7115.30.camel@twins>
In-Reply-To: <1208448768.7115.30.camel@twins>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@linux-foundation.org>, shaggy@austin.ibm.com, axboe@kernel.dk, linux-mm@kvack.org, linux-arch@vger.kernel.org, Clark Williams <williams@redhat.com>, Ingo Molnar <mingo@elte.hu>
Message-ID: <20080418095858.AKyBFtcCBh0gRD5-ATRI3e2Vwuuf5K9gNWu25tB_10Q@z>

Peter Zijlstra wrote:
> On Thu, 2008-04-17 at 08:25 -0700, Linus Torvalds wrote:
>   
>> On Thu, 17 Apr 2008, Peter Zijlstra wrote:
>>     
>>> Would this be sufficient to address that comment's conern?
>>>       
>> It would be nicer to just add a "native_get_pte()" to x86, to match the 
>> already-existing "native_set_pte()".
>>     
>
> See, I _knew_ I was missing something obvious :-/
>
>   
>> And that "barrier()" should b "smp_rmb()". They may be the same code 
>> sequence, but from a conceptual angle, "smp_rmb()" makes a whole lot more 
>> sense.
>>
>> Finally, I don't think that comment is correct in the first place. It's 
>> not that simple. The thing is, even *with* the memory barrier in place, we 
>> may have:
>>
>> 	CPU#1			CPU#2
>> 	=====			=====
>>
>> 	fast_gup:
>> 	 - read low word
>>
>> 				native_set_pte_present:
>> 				 - set low word to 0
>> 				 - set high word to new value
>>
>> 	 - read high word
>>
>> 				- set low word to new value
>>
>> and so you read a low word that is associated with a *different* high 
>> word! Notice?
>>
>> So trivial memory ordering is _not_ enough.
>>
>> So I think the code literally needs to be something like this
>>
>> 	#ifdef CONFIG_X86_PAE
>>
>> 	static inline pte_t native_get_pte(pte_t *ptep)
>> 	{
>> 		pte_t pte;
>>
>> 	retry:
>> 		pte.pte_low = ptep->pte_low;
>> 		smp_rmb();
>> 		pte.pte_high = ptep->pte_high;
>> 		smp_rmb();
>> 		if (unlikely(pte.pte_low != ptep->pte_low)
>> 			goto retry;
>> 		return pte;
>> 	}
>>
>> 	#else
>>
>> 	#define native_get_pte(ptep) (*(ptep))
>>
>> 	#endif
>>
>> but I have admittedly not really thought it fully through.
>>     
>
> Looks sane here; Clark can you give this a spin?
>
> Jeremy, did I get the paravirt stuff right?
>   

You shouldn't need to do anything special for paravirt.  set_pte is 
necessary because it may have side-effects (like a hypervisor call), but 
get_pte should be side-effect free.  There's no other need for it; any 
special processing on the pte value itself is done in pte_val().

    J
