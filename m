From: Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Subject: Re: [patch 2/2]: introduce fast_gup
Date: Mon, 21 Apr 2008 16:26:49 +0300
Message-ID: <480C9619.2050201@qumranet.com>
References: <20080328025455.GA8083@wotan.suse.de>	 <20080328030023.GC8083@wotan.suse.de> <1208444605.7115.2.camel@twins>	 <alpine.LFD.1.00.0804170814090.2879@woody.linux-foundation.org>	 <480C81C4.8030200@qumranet.com> <1208781013.7115.173.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1208781013.7115.173.camel@twins>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, shaggy-V7BBcbaFuwjMbYB6QlFGEg@public.gmane.org, axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Clark Williams <williams-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>

Peter Zijlstra wrote:
> On Mon, 2008-04-21 at 15:00 +0300, Avi Kivity wrote:
>   
>> Linus Torvalds wrote:
>>     
>>> Finally, I don't think that comment is correct in the first place. It's 
>>> not that simple. The thing is, even *with* the memory barrier in place, we 
>>> may have:
>>>
>>> 	CPU#1			CPU#2
>>> 	=====			=====
>>>
>>> 	fast_gup:
>>> 	 - read low word
>>>
>>> 				native_set_pte_present:
>>> 				 - set low word to 0
>>> 				 - set high word to new value
>>>
>>> 	 - read high word
>>>
>>> 				- set low word to new value
>>>
>>> and so you read a low word that is associated with a *different* high 
>>> word! Notice?
>>>
>>> So trivial memory ordering is _not_ enough.
>>>
>>> So I think the code literally needs to be something like this
>>>
>>> 	#ifdef CONFIG_X86_PAE
>>>
>>> 	static inline pte_t native_get_pte(pte_t *ptep)
>>> 	{
>>> 		pte_t pte;
>>>
>>> 	retry:
>>> 		pte.pte_low = ptep->pte_low;
>>> 		smp_rmb();
>>> 		pte.pte_high = ptep->pte_high;
>>> 		smp_rmb();
>>> 		if (unlikely(pte.pte_low != ptep->pte_low)
>>> 			goto retry;
>>> 		return pte;
>>> 	}
>>>
>>>   
>>>       
>> I think this is still broken.  Suppose that after reading pte_high 
>> native_set_pte() is called again on another cpu, changing pte_low back 
>> to the original value (but with a different pte_high).  You now have 
>> pte_low from second native_set_pte() but pte_high from the first 
>> native_set_pte().
>>     
>
> I think the idea was that for user pages we only use set_pte_present()
> which does the low=0 thing first.
>   

Doesn't matter.  The second native_set_pte() (or set_pte_present()) 
executes atomically:


	fast_gup:
	 - read low word (l0)

				native_set_pte_present:
				 - set low word to 0
				 - set high word to new value (h1)
	 			 - set low word to new value (l1)
 

	 - read high word (h1)

				native_set_pte_present:
				 - set low word to 0
				 - set high word to new value (h2)
	 			 - set low word to new value (l2)

   	 - re-read low word (l2)


If l2 happens to be equal to l0, then the check succeeds and we have a 
splintered pte h1:l0.

-- 
error compiling committee.c: too many arguments to function
