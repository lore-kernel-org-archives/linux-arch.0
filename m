Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:37294 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJPXBm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Oct 2018 19:01:42 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
        <20181015120521.GA10146@redhat.com>
        <20398328-4ee1-96b2-5723-4b7eed55f0a2@cisco.com>
        <20181016141405.GA22045@redhat.com>
Date: Tue, 16 Oct 2018 10:09:34 -0500
In-Reply-To: <20181016141405.GA22045@redhat.com> (Oleg Nesterov's message of
        "Tue, 16 Oct 2018 16:14:06 +0200")
Message-ID: <87bm7ukjwx.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Enke Chen <enkechen@cisco.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Roman Gushchin <guro@fb.com>, Marcos Paulo de Souza <marcos.souza.org@gmail.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Cyrill Gorcunov <gorcunov@openvz.org>, Yang Shi <yang.shi@linux.alibaba.com>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Victor Kamensky (kamensky)" <kamensky@cisco.com>, xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>, Eugene Syromiatnikov <esyr@redhat.com>
Message-ID: <20181016150934.AaoBQW8koBM1dGdkaA1cQRcY3zrI9oMYnPmKfPsng7k@z>

Oleg Nesterov <oleg@redhat.com> writes:

> On 10/15, Enke Chen wrote:
>>
>> > I don't understand why we need valid_predump_signal() at all.
>>
>> Most of the signals have well-defined semantics, and would not be appropriate
>> for this purpose.
>
> you are going to change the rules anyway.

I will just add that CLD_XXX is only valid with SIGCHLD as they are
signal specific si_codes.  In conjunction with another signal like
SIGUSR it will have another meaning.  I would really appreciate it
if new code does not further complicate siginfo_layout.

>> That is why it is limited to only SIGCHLD, SIGUSR1, SIGUSR2.
>
> Which do not queue. So the parent won't get the 2nd signal if 2 children
> crash at the same time.

We do best effort queueing but we don't guarantee anything.  So yes
this makes signals a very louzy interface for sending this kind of
information.

>> >>  		if (sig_kernel_coredump(signr)) {
>> >> +			/*
>> >> +			 * Notify the parent prior to the coredump if the
>> >> +			 * parent is interested in such a notificaiton.
>> >> +			 */
>> >> +			int p_sig = current->real_parent->predump_signal;
>> >> +
>> >> +			if (valid_predump_signal(p_sig)) {
>> >> +				read_lock(&tasklist_lock);
>> >> +				do_notify_parent_predump(current);
>> >> +				read_unlock(&tasklist_lock);
>> >> +				cond_resched();
>> >
>> > perhaps this should be called by do_coredump() after coredump_wait() kills
>> > all the sub-threads?
>>
>> proc_coredump_connector(current) is located here, they should stay together.
>
> Why?
>
> Once again, other threads are still alive. So if the parent restarts the service
> after it recieves -predump_signal, the new process can "race" with the old thread.

Yes.  It isn't until do_coredump calls coredump_wait that all of the
threads are killed.

Eric
