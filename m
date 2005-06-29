Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <42C3310C.8070004@yahoo.com.au>
Date: Thu, 30 Jun 2005 09:38:52 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: Remaining arch problems in cpu_idle
References: <B8E391BBE9FE384DAA4C5C003888BE6F03D0B5D6@scsmsx401.amr.corp.intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F03D0B5D6@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, David Mosberger <davidm@hpl.hp.com>
List-ID: <linux-arch.vger.kernel.org>

Luck, Tony wrote:
>>h8300, ia64, and sh64 still have possible outstanding issues,
>>which I've put at the end of the Documentation/ file. It
>>would be nice to get these looked at.
> 
> 
> +ia64 - is safe_halt call racy vs interrupts? (does it sleep?) (See #4a)
> 
> safe_halt() makes a call to PAL[1] to go to a lower power state.  It does
> not do anything that would require a sleep.
> 

So it won't need an interrupt to be revived out of that state?
Thank you Tony, I'll take ia64 off the list.

The other change I made to ia64 is to use TIF_POLLING_NRFLAG to
inhibit wakeup IPIs to idle threads - is this something that
looks acceptable?

Clearing TIF_POLLING_NRFLAG from around safe_halt() in my patch
is superfluous if safe_halt doesn't require an interrupt to wake
up - I'll remove that hunk.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
