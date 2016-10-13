From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 1/3] sched/core,x86: make struct thread_info arch specific again
Date: Thu, 13 Oct 2016 16:51:04 -0700
Message-ID: <CALCETrU1mJC+LqO5+yTqzj3ZhOLTqrJLt5YxU_VsCPnTGEJ=Xg@mail.gmail.com>
References: <20161013115712.29517-1-heiko.carstens@de.ibm.com>
 <20161013115712.29517-2-heiko.carstens@de.ibm.com> <20161013234147.GB24167@remoulade>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:34375 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752837AbcJMXv0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Oct 2016 19:51:26 -0400
Received: by mail-vk0-f52.google.com with SMTP id b186so97563424vkb.1
        for <linux-arch@vger.kernel.org>; Thu, 13 Oct 2016 16:51:25 -0700 (PDT)
In-Reply-To: <20161013234147.GB24167@remoulade>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, linux-arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Thu, Oct 13, 2016 at 4:41 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Thu, Oct 13, 2016 at 01:57:10PM +0200, Heiko Carstens wrote:
>> commit c65eacbe290b ("sched/core: Allow putting thread_info into
>> task_struct") made struct thread_info a generic struct with only a
>> single flags member if THREAD_INFO_IN_TASK_STRUCT is selected.
>>
>> This change however seems to be quite x86 centric, since at least the
>> generic preemption code (asm-generic/preempt.h) assumes that struct
>> thread_info also has a preempt_count member, which apparently was not
>> true for x86.
>>
>> We could add a bit more ifdefs to solve this problem too, but it seems
>> to be much simpler to make struct thread_info arch specific
>> again. This also makes the conversion to THREAD_INFO_IN_TASK_STRUCT a
>> bit easier for architectures that have a couple of arch specific stuff
>> in their thread_info definition.
>>
>> The arch specific stuff _could_ be moved to thread_struct. However
>> keeping them in thread_info makes it easier: accessing thread_info
>> members is simple, since it is at the beginning of the task_struct,
>> while the thread_struct is at the end. At least on s390 the offsets
>> needed to access members of the thread_struct (with task_struct as
>> base) are too large for various asm instructions.  This is not a
>> problem when keeping these members within thread_info.
>
> The exact same applies for arm64 on all counts. This is also simpler than both
> attempts I had at this, so FWIW:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> To make merging less painful, I guess we'll need a stable branch with (just)
> this and whatever patch we end up with for fixing current_thread_info(), so we
> can independently merge the arch-specific parts.
>
> I guess it'd make sense for the tip tree to host that?
>

I wonder if this could even make 4.9.  It's pretty clearly a no-op.  Ingo?
