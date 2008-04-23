From: Mark Lord <lkml-gsilrlXbHYg@public.gmane.org>
Subject: Re: [PATCH 1/11] Add generic helpers for arch IPI function calls
Date: Wed, 23 Apr 2008 09:42:20 -0400
Message-ID: <480F3CBC.60305@rtr.ca>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-2-git-send-email-jens.axboe@oracle.com> <480E70ED.3030701@rtr.ca> <20080423072432.GX12774@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080423072432.GX12774-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org

>>> Date:	Thu, 15 Nov 2007 12:07:48 -0500
>>> From: Mark Lord <lkml-gsilrlXbHYg@public.gmane.org>
>>> To: Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
>>> Cc: Yasunori Goto <y-goto-+CUm20s59erQFUHtdCDX3A@public.gmane.org>,
>>> 	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
>>> 	Alexey Dobriyan <adobriyan-3ImXcnM4P+0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> Subject: Re: EIP is at device_shutdown+0x32/0x60
>>> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
>>> Content-Transfer-Encoding: 7bit
>>> Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>
>>> ... < snip > ...
>>>
>>> Greg, I don't know if this is relevant or not,
>>> but x86 has bugs in the halt/reboot code for SMP.
>>>
>>> Specifically, in native_smp_send_stop() the code now uses
>>> spin_trylock() to "lock" the shared call buffers,
>>> but then ignores the result.
>>>
>>> This means that multiple CPUs can/will clobber each other
>>> in that code.
>>>
>>> The second bug, is that this code does not wait for the
>>> target CPUs to actually stop before it continues.
>>>
>>> This was the real cause of the failure-to-poweroff problems
>>> I was having with 2.6.23, which we fixed by using CPU hotplug
>>> to disable_nonboot_cpus() before the above code ever got run.

Jens Axboe wrote:
> On Tue, Apr 22 2008, Mark Lord wrote:
>> Jens,
>>
>> While you're in there, :)
>>
>> Could you perhaps fix this bug (above) if it still exists?
> 
> I don't understand the bug - what are the shared call buffers you are
> talking of?
> 
> With the changes, there's not even an spin_trylock() in there anymore.
> But I don't see the original bug either, so...
..

arch/x86/kernel/smp.c:

static void native_smp_send_stop(void)
{
        int nolock;
        unsigned long flags;

        if (reboot_force)
                return;

        /* Don't deadlock on the call lock in panic */
        nolock = !spin_trylock(&call_lock);       <<<<<<<<<< buggy
        local_irq_save(flags);
        __smp_call_function(stop_this_cpu, NULL, 0, 0);
        if (!nolock)
                spin_unlock(&call_lock);
        disable_local_APIC();
        local_irq_restore(flags);
}

The spinlock is trying to protect access to the global variable
"call_data" (higher up in the same file), which is used
in __smp_call_function() and friends.

But since the spinlock is ignored in this case,
the global "call_data will get clobbered if it was already in-use.

The second bug, is that for the halt case at least,
nobody waits for the other CPU to actually halt
before continuing.. so we sometimes enter the shutdown
code while other CPUs are still active.

This causes some machines to hang at shutdown,
unless CPU_HOTPLUG is configured and takes them offline
before we get here.

Cheers
