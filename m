Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35931 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbbKGGoJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 7 Nov 2015 01:44:09 -0500
Received: by pacdm15 with SMTP id dm15so120236700pac.3
        for <linux-arch@vger.kernel.org>; Fri, 06 Nov 2015 22:44:08 -0800 (PST)
Message-ID: <563d9db7.6293420a.cdda3.ffffa5c8@mx.google.com>
Date: Fri, 06 Nov 2015 22:44:07 -0800 (PST)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 09/13] Move bp_type_idx to kernel/event/hw_breakpoint.c
In-Reply-To: <20151104122151.GB11639@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org
Cc: arnd@arndb.de, dhowells@redhat.com, viro@zeniv.linux.org.uk, ast@plumgrid.com, aishchuk@linux.vnet.ibm.com, aarcange@redhat.com, akpm@linux-foundation.org, luto@kernel.org, acme@kernel.org, bhe@redhat.com, 3chas3@gmail.com, chris@zankel.net, dave@sr71.net, dyoung@redhat.com, drysdale@google.com, davem@davemloft.net, ebiederm@xmission.com, geoff@infradead.org, gregkh@linuxfoundation.org, hpa@zytor.com, mingo@kernel.org, iulia.manda21@gmail.com, plagnioj@jcrosoft.com, jikos@kernel.org, josh@joshtriplett.org, kexec@lists.infradead.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, mathieu.desnoyers@efficios.com, jcmvbkbc@gmail.com, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, tomi.valkeinen@ti.com, vgoyal@redhat.com, x86@kernel.org
Message-ID: <20151107064407.ChmYQl3_5EBreIvl_5JmewHY-ybX_asUJMkGFaCDJlY@z>

On Wed, 04 Nov 2015 04:21:51 PST (-0800), peterz@infradead.org wrote:
> On Wed, Nov 04, 2015 at 12:41:06PM +0100, Peter Zijlstra wrote:
>> On Tue, Nov 03, 2015 at 11:46:30AM -0800, Palmer Dabbelt wrote:
>> > This has a "#ifdef CONFIG_*" that used to be exposed to userspace.
>> >
>> > The names in here are so generic that I don't think it's a good idea
>> > to expose them to userspace (or even the rest of the kernel).  Since
>> > there's only one kernel user, it's been moved to that file.
>> >
>> > Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>> > Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
>> > Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
>>
>> Assuming you want to keep all these patches together in a tree or so.
>> Let me know if you want me to take this patch.

Well, the plan was to try to get the whole patch set all upstream together.
I'd prefer that, because it'll be easier to make sure everything gets in before
the last checker patch.  Since it touches so many different places I'd be OK
with doing it peicemeal.

I'm kind of new to this whole process: do you think someone is likely to take
this patch set all together?

>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Ah, build-bot finds your change is broken and you didn't grep right. It
> is used in more places.

Sorry about that, I must have mis-grep'd.  I guess that's what the build-bot is
for :).

> How about moving it to include/linux/hw_breakpoint.h, instead of having
> it in the uapi crud?

Yep, that makes sense.

I'm going to re-submit a v5 of this patch set, since there was also a missing
patch for blackfin that the buildbot found.
