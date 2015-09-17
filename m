Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33339 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbbIQD4C (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Sep 2015 23:56:02 -0400
Received: by pacex6 with SMTP id ex6so8094417pac.0
        for <linux-arch@vger.kernel.org>; Wed, 16 Sep 2015 20:56:01 -0700 (PDT)
Message-ID: <55fa39d0.2c1b450a.6854.4115@mx.google.com>
Date: Wed, 16 Sep 2015 20:56:00 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 09/13] Move bp_type_idx to kernel/event/hw_breakpoint.c
In-Reply-To: <20150915193910.GH16853@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org
Cc: arnd@arndb.de, dhowells@redhat.com, viro@zeniv.linux.org.uk, ast@plumgrid.com, aishchuk@linux.vnet.ibm.com, aarcange@redhat.com, akpm@linux-foundation.org, luto@kernel.org, acme@kernel.org, bhe@redhat.com, 3chas3@gmail.com, chris@zankel.net, dave@sr71.net, dyoung@redhat.com, drysdale@google.com, davem@davemloft.net, ebiederm@xmission.com, geoff@infradead.org, gregkh@linuxfoundation.org, hpa@zytor.com, mingo@kernel.org, iulia.manda21@gmail.com, plagnioj@jcrosoft.com, jikos@kernel.org, josh@joshtriplett.org, kexec@lists.infradead.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, mathieu.desnoyers@efficios.com, jcmvbkbc@gmail.com, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, tomi.valkeinen@ti.com, vgoyal@redhat.com, x86@kernel.org, fweisbec@gmail.com
Message-ID: <20150917035600.c-5U6HkXKs0rppyN4zQJmogTYUeKtKt-onlkTFKzI2g@z>

On Tue, 15 Sep 2015 12:39:10 PDT (-0700), peterz@infradead.org wrote:
> On Tue, Sep 15, 2015 at 11:40:11AM -0700, Palmer Dabbelt wrote:
>> On Tue, 15 Sep 2015 01:06:07 PDT (-0700), peterz@infradead.org wrote:
>> > On Mon, Sep 14, 2015 at 03:50:43PM -0700, Palmer Dabbelt wrote:
>> >> This has a "#ifdef CONFIG_*" that used to be exposed to userspace.
>> >>
>> >> The names in here are so generic that I don't think it's a good idea
>> >> to expose them to userspace (or even the rest of the kernel).  Since
>> >> there's only one kernel user, it's been moved to that file.
>> >>
>> >> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>> >> Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
>> >> Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
>> >> ---
>> >>  include/uapi/linux/hw_breakpoint.h | 10 ----------
>> >>  kernel/events/hw_breakpoint.c      | 10 ++++++++++
>> >>  2 files changed, 10 insertions(+), 10 deletions(-)
>> >>
>> >> diff --git a/include/uapi/linux/hw_breakpoint.h b/include/uapi/linux/hw_breakpoint.h
>> >> index b04000a2296a..7a6a5a7f9511 100644
>> >> --- a/include/uapi/linux/hw_breakpoint.h
>> >> +++ b/include/uapi/linux/hw_breakpoint.h
>> >> @@ -17,14 +17,4 @@ enum {
>> >>  	HW_BREAKPOINT_INVALID   = HW_BREAKPOINT_RW | HW_BREAKPOINT_X,
>> >>  };
>> >>
>> >> -enum bp_type_idx {
>> >> -	TYPE_INST 	= 0,
>> >> -#ifdef CONFIG_HAVE_MIXED_BREAKPOINTS_REGS
>> >> -	TYPE_DATA	= 0,
>> >> -#else
>> >> -	TYPE_DATA	= 1,
>> >> -#endif
>> >> -	TYPE_MAX
>> >> -};
>> >
>> > This is rather unfortunate; you are correct that the naming is too
>> > generic (and I tend to agree), but I think these values are required by
>> > userspace to fill out:
>> >
>> >   perf_event_attr::bp_type
>> >
>> > So removing them will break things.
>> >
>> > Frederic?
>>
>> perf_event_open(2) says
>>
>>        bp_type (since Linux 2.6.33)
>>               This chooses the breakpoint type.  It is one of:
>>
>>               HW_BREAKPOINT_EMPTY
>>                      No breakpoint.
>>
>>               HW_BREAKPOINT_R
>>                      Count when we read the memory location.
>>
>>               HW_BREAKPOINT_W
>>                      Count when we write the memory location.
>>
>>               HW_BREAKPOINT_RW
>>                      Count when we read or write the memory location.
>>
>>               HW_BREAKPOINT_X
>>                      Count when we execute code at the memory location.
>>
>>               The values can be combined via a bitwise or, but the combination
>>               of HW_BREAKPOINT_R or HW_BREAKPOINT_W  with  HW_BREAKPOINT_X  is
>>               not allowed.
>>
>> so I think removing this enum from userspace is OK.  Did I miss
>> something?
>
> Nah, could've just been me not being awake. Unless Frederic says
> otherwise I'll chalk it up to not having drank enough morning juice.

Well, I'm going to leave this alone, then -- as Arnd pointed out in a
later email that got mis-threaded, this would be super tricky to fix
if userspace actually relied on it (which is why I was scared I was
wrong).

v4 (which is hopefully the final version of the patch set) will leave
this as it is.
