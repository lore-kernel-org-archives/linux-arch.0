Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rcdn-iport-9.cisco.com ([173.37.86.80]:30733 "EHLO
        rcdn-iport-9.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeJYG0D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Oct 2018 02:26:03 -0400
Subject: Re: [PATCH v2] kernel/signal: Signal-based pre-coredump notification
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
 <20181023092348.GA14340@redhat.com>
 <1e68a3ce-32cd-b058-3d1d-36455ceca848@cisco.com>
 <20181024135212.GF30128@redhat.com>
From: Enke Chen <enkechen@cisco.com>
Message-ID: <d24eac49-f808-7d4d-f5fc-59ad2464fb73@cisco.com>
Date: Wed, 24 Oct 2018 14:56:12 -0700
MIME-Version: 1.0
In-Reply-To: <20181024135212.GF30128@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Roman Gushchin <guro@fb.com>, Marcos Paulo de Souza <marcos.souza.org@gmail.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Cyrill Gorcunov <gorcunov@openvz.org>, Yang Shi <yang.shi@linux.alibaba.com>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Victor Kamensky (kamensky)" <kamensky@cisco.com>, xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>, Enke Chen <enkechen@cisco.com>
Message-ID: <20181024215612._DuFUwSppVZy6XczK1wfE1-LIvqRN7XyBxXBTKACcsA@z>

Hi, Olge:

On 10/24/18 6:52 AM, Oleg Nesterov wrote:
> On 10/23, Enke Chen wrote:
>>
>>>> +	/*
>>>> +	 * Send the pre-coredump signal to the parent if requested.
>>>> +	 */
>>>> +	read_lock(&tasklist_lock);
>>>> +	notify = do_notify_parent_predump(current);
>>>> +	read_unlock(&tasklist_lock);
>>>> +	if (notify)
>>>> +		cond_resched();
>>>
>>> Hmm. I do not understand why do we need cond_resched(). And even if we need it,
>>> why we can't call it unconditionally?
>>
>> Remember the goal is to allow the parent (e.g., a process manager) to take early
>> action. The "yield" before doing coredump will help.
> 
> I don't see how can it actually help...
> 
> cond_resched() is nop if CONFIG_PREEMPT or should_resched() == 0.
> 
> and the coredumping thread will certainly need to sleep/wait anyway.

I am really surprised by this - cond_resched() is used in many places and it actually
does not do anything w/o CONFIG_PREEMPT.

Will remove.

> 
>>> And once again, SIGCHLD/SIGUSR do not queue, this means that PR_SET_PREDUMP_SIG
>>> is pointless if you have 2 or more children.
>>
>> Hmm, could you point me to the code where SIGCHLD/SIGUSR is treated differently
>> w.r.t. queuing?  That does not sound right to me.
> 
> see the legacy_queue() check. Any signal < SIGRTMIN do not queue. IOW, if SIGCHLD
> is already pending, then next SIGCHLD is simply ignored.

Got it. This means that a distinct signal (in particular a RT signal) would be more
preferred. This is what it is done in our application. You earlier suggestion about
removing the signal limitation makes a lot sense to me now.

Given that a distinct signal is more preferred, I am wondering if I should just remove
CLD_PREDUMP from the patch.

Thanks.  -- Enke
