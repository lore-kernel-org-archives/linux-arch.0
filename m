Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62356 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595Ab2B0UYJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2012 15:24:09 -0500
Received: by mail-bk0-f46.google.com with SMTP id ik5so646609bkc.19
        for <linux-arch@vger.kernel.org>; Mon, 27 Feb 2012 12:24:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120227172208.GC10608@redhat.com>
References: <1330140111-17201-1-git-send-email-wad@chromium.org>
	<1330140111-17201-8-git-send-email-wad@chromium.org>
	<20120227172208.GC10608@redhat.com>
Date: Mon, 27 Feb 2012 14:24:04 -0600
Message-ID: <CABqD9hbBj_c1qxD7N0ed3LMy_DXn-163LuNc1E7mSZbGO7oqyw@mail.gmail.com>
Subject: Re: [PATCH v11 08/12] signal, x86: add SIGSYS info and make it synchronous.
From: Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, kernel-hardening@lists.openwall.com, netdev@vger.kernel.org, x86@kernel.org, arnd@arndb.de, davem@davemloft.net, hpa@zytor.com, mingo@redhat.com, peterz@infradead.org, rdunlap@xenotime.net, mcgrathr@chromium.org, tglx@linutronix.de, luto@mit.edu, eparis@redhat.com, serge.hallyn@canonical.com, djm@mindrot.org, scarybeasts@gmail.com, indan@nul.nu, pmoore@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, eric.dumazet@gmail.com, markus@chromium.org, coreyb@linux.vnet.ibm.com, keescook@chromium.org
Message-ID: <20120227202404.AdVVoBvpvg1xOZsQsCsoWyx08SWKfDCpKR1a-7YSJWY@z>

On Mon, Feb 27, 2012 at 11:22 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 02/24, Will Drewry wrote:
>>
>> To ensure that SIGSYS delivery occurs on return from the triggering
>> system call, SIGSYS is added to the SYNCHRONOUS_MASK macro.
>
> Hmm. Can't understand... please help.
>
>>  #define SYNCHRONOUS_MASK \
>>       (sigmask(SIGSEGV) | sigmask(SIGBUS) | sigmask(SIGILL) | \
>> -      sigmask(SIGTRAP) | sigmask(SIGFPE))
>> +      sigmask(SIGTRAP) | sigmask(SIGFPE) | sigmask(SIGSYS))
>
> Why?
>
> SYNCHRONOUS_MASK just tells dequeue_signal() "pick them first".
> This is needed to make sure that the handler for, say SIGSEGV,
> can use ucontext->ip as a faulting addr.

I think that Roland covered this.  (Since the syscall_rollback was
called it's nice to let our handler get first go.)

> But seccomp adds info->si_call_addr, this looks unneeded.

True enough.  I can drop it.  It'd only be useful if the SIGSYS wasn't
being forced and the signal was being handled without ucontext_t
access.

thanks!
