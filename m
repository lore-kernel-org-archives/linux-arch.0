Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <42C334DF.20203@yahoo.com.au>
Date: Thu, 30 Jun 2005 09:55:11 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: Remaining arch problems in cpu_idle
References: <B8E391BBE9FE384DAA4C5C003888BE6F03D0B7ED@scsmsx401.amr.corp.intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F03D0B7ED@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, David Mosberger <davidm@hpl.hp.com>
List-ID: <linux-arch.vger.kernel.org>

Luck, Tony wrote:
>>>+ia64 - is safe_halt call racy vs interrupts? (does it >sleep?) (See #4a)
>>>
>>>safe_halt() makes a call to PAL[1] to go to a lower power state.  It does
>>>not do anything that would require a sleep.
>>>
>>
>>So it won't need an interrupt to be revived out of that state?
>>Thank you Tony, I'll take ia64 off the list.
> 
> 
> Ummm ... no.  The processor will stay in the low power state until
> an unmasked external interrupt occurs (or one of several other more
> intrusive events like reset, machine check, PMI occur).
> 

OK, so ia64's got the interrupt race as well I think?

I don't suppose safe_halt can be called with interrupts off
safely, like the i386 function of the same name?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
