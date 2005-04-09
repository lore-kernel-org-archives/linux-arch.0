Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <42577602.8090507@yahoo.com.au>
Date: Sat, 09 Apr 2005 16:28:18 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [patch] sched: unlocked context-switches
References: <B8E391BBE9FE384DAA4C5C003888BE6F033DB07E@scsmsx401.amr.corp.intel.com> <20050409043848.GA2677@elte.hu>
In-Reply-To: <20050409043848.GA2677@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Ingo Molnar wrote:
> * Luck, Tony <tony.luck@intel.com> wrote:
> 
> 
>>>tested on x86, and all other arches should work as well, but if an 
>>>architecture has irqs-off assumptions in its switch_to() logic 
>>>it might break. (I havent found any but there may such assumptions.)
>>
>>The ia64_switch_to() code includes a section that can change a pinned
>>MMU mapping (when the stack for the new process is in a different
>>granule from the stack for the old process).  [...]
> 
> 
> thanks - updated patch below. Any other architectures that switch the 
> kernel stack in a nonatomic way? x86/x64 switches it atomically.
> 

Well that does look like a pretty good cleanup. It certainly is
the final step in freeing complex architecture switching code
from entanglement with scheduler internal locking, and unifies
the locking scheme.

I did propose doing unconditionally unlocked switches a while
back when my patch first popped up - you were against it then,
but I guess you've had second thoughts?

It does add an extra couple of stores to on_cpu, and a wmb()
for architectures that didn't previously need the unlocked
switches. And ia64 needs the extra interrupt disable / enable.
Probably worth it?

Minor style request: I like that you're accessing ->on_cpu
through functions so the !SMP case doesn't clutter the code
with ifdefs... but can you do set_task_on_cpu(p) and
clear_task_on_cpu(p) ?

Thanks.

-- 
SUSE Labs, Novell Inc.
