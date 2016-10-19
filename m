From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 1/3] sched/core,x86: make struct thread_info arch specific again
Date: Wed, 19 Oct 2016 16:19:46 -0700
Message-ID: <CALCETrUG06KGckAqr-nkPTsRnowJFJ6JxuYyg3o48t4_MRQang@mail.gmail.com>
References: <1476901693-8492-1-git-send-email-mark.rutland@arm.com> <1476901693-8492-2-git-send-email-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:32943 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752113AbcJSXUI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2016 19:20:08 -0400
Received: by mail-vk0-f53.google.com with SMTP id 83so48275076vkd.0
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2016 16:20:07 -0700 (PDT)
In-Reply-To: <1476901693-8492-2-git-send-email-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Andrew Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Oct 19, 2016 at 11:28 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
>
> commit c65eacbe290b ("sched/core: Allow putting thread_info into
> task_struct") made struct thread_info a generic struct with only a
> single flags member if THREAD_INFO_IN_TASK_STRUCT is selected.
>
> This change however seems to be quite x86 centric, since at least the
> generic preemption code (asm-generic/preempt.h) assumes that struct
> thread_info also has a preempt_count member, which apparently was not
> true for x86.
>
> We could add a bit more ifdefs to solve this problem too, but it seems
> to be much simpler to make struct thread_info arch specific
> again. This also makes the conversion to THREAD_INFO_IN_TASK_STRUCT a
> bit easier for architectures that have a couple of arch specific stuff
> in their thread_info definition.
>
> The arch specific stuff _could_ be moved to thread_struct. However
> keeping them in thread_info makes it easier: accessing thread_info
> members is simple, since it is at the beginning of the task_struct,
> while the thread_struct is at the end. At least on s390 the offsets
> needed to access members of the thread_struct (with task_struct as
> base) are too large for various asm instructions.  This is not a
> problem when keeping these members within thread_info.

Acked-by: Andy Lutomirski <luto@kernel.org>

Ingo, there's a (somewhat weak) argument for sending this via
tip/urgent: it doesn't change generated code at all, and I think it
will avoid a silly depedency or possible conflict for the next merge
window, since both arm64 and s390 are going to need it.

--Andy
