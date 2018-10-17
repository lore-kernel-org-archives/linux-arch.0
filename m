Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from alln-iport-2.cisco.com ([173.37.142.89]:46104 "EHLO
        alln-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeJQIcy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Oct 2018 04:32:54 -0400
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <20181015120521.GA10146@redhat.com>
 <20398328-4ee1-96b2-5723-4b7eed55f0a2@cisco.com>
 <20181016141405.GA22045@redhat.com>
From: Enke Chen <enkechen@cisco.com>
Message-ID: <f06be2d1-c6fd-21d3-00ae-01b8d4eaaade@cisco.com>
Date: Tue, 16 Oct 2018 17:39:48 -0700
MIME-Version: 1.0
In-Reply-To: <20181016141405.GA22045@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Roman Gushchin <guro@fb.com>, Marcos Paulo de Souza <marcos.souza.org@gmail.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Cyrill Gorcunov <gorcunov@openvz.org>, Yang Shi <yang.shi@linux.alibaba.com>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Victor Kamensky (kamensky)" <kamensky@cisco.com>, xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>, Eugene Syromiatnikov <esyr@redhat.com>, Enke Chen <enkechen@cisco.com>
Message-ID: <20181017003948.3ppwHkPDP9zU0HsQSaKBTy0wgknWda4eDLh-ywEpTAI@z>

Hi, Oleg:

On 10/16/18 7:14 AM, Oleg Nesterov wrote:
> On 10/15, Enke Chen wrote:
>>
>>> I don't understand why we need valid_predump_signal() at all.
>>
>> Most of the signals have well-defined semantics, and would not be appropriate
>> for this purpose.
> 
> you are going to change the rules anyway.
> 
>> That is why it is limited to only SIGCHLD, SIGUSR1, SIGUSR2.
> 
> Which do not queue. So the parent won't get the 2nd signal if 2 children
> crash at the same time.
> 
>>>>  		if (sig_kernel_coredump(signr)) {
>>>> +			/*
>>>> +			 * Notify the parent prior to the coredump if the
>>>> +			 * parent is interested in such a notificaiton.
>>>> +			 */
>>>> +			int p_sig = current->real_parent->predump_signal;
>>>> +
>>>> +			if (valid_predump_signal(p_sig)) {
>>>> +				read_lock(&tasklist_lock);
>>>> +				do_notify_parent_predump(current);
>>>> +				read_unlock(&tasklist_lock);
>>>> +				cond_resched();
>>>
>>> perhaps this should be called by do_coredump() after coredump_wait() kills
>>> all the sub-threads?
>>
>> proc_coredump_connector(current) is located here, they should stay together.
> 
> Why?
> 
> Once again, other threads are still alive. So if the parent restarts the service
> after it recieves -predump_signal, the new process can "race" with the old thread.

Yes, it is a good idea to do the signal notification in do_coredump() after
coredump_wait(). Will make the change as suggested.

Thanks.  -- Enke
