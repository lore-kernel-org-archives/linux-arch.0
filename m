Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:42446 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbdGVUeK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 22 Jul 2017 16:34:10 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <87o9shg7t7.fsf_-_@xmission.com>
        <20170718140651.15973-7-ebiederm@xmission.com>
        <CA+55aFyKsmf+BpYjcH30MGpHTDJ=zgYPx6kwyEB9CXXFxj_xsw@mail.gmail.com>
        <878tjlbqpt.fsf@xmission.com>
Date: Sat, 22 Jul 2017 15:25:55 -0500
In-Reply-To: <878tjlbqpt.fsf@xmission.com> (Eric W. Biederman's message of
        "Tue, 18 Jul 2017 12:27:26 -0500")
Message-ID: <8760ek5ics.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Simplfying copy_siginfo_to_user
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, Andrei Vagin <avagin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Greg KH <greg@kroah.com>, Andrey Vagin <avagin@openvz.org>, Serge Hallyn <serge@hallyn.com>, Pavel Emelyanov <xemul@virtuozzo.com>, Cyrill Gorcunov <gorcunov@openvz.org>, Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Linux Containers <containers@lists.linux-foundation.org>, Michael Kerrisk <mtk.manpages@gmail.com>
Message-ID: <20170722202555.HlLY0pfZenNiF1bWSNfXjReqLPna6YkhGUd5XD_SvUw@z>

ebiederm@xmission.com (Eric W. Biederman) writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> On Tue, Jul 18, 2017 at 7:06 AM, Eric W. Biederman
>> <ebiederm@xmission.com> wrote:
>>> struct siginfo is a union and the kernel since 2.4 has been hiding a union
>>> tag in the high 16bits of si_code using the values:
>>> __SI_KILL
>>> __SI_TIMER
>>> __SI_POLL
>>> __SI_FAULT
>>> __SI_CHLD
>>> __SI_RT
>>> __SI_MESGQ
>>> __SI_SYS
>>>
>>> While this looks plausible on the surface, in practice this situation has
>>> not worked well.
>>
>> So on the whole I think we just need to do this, but the part I really
>> hate about this series is still this the siginfo_layout() part.
>>
>> I can well believe that it is needed for the compat case. siginfo is a
>> piece of crap crazy type, and re-ordering fields for compat is
>> something we are always going to have to do.
>>
>> But for the native case, the *only* reason we do not just copy the
>> siginfo as-is seems to be that it's just too big, due to other bad
>> design decisions in siginfo ("let's make sure it's big enough by
>> allocating 512 bytes for it).
>>
>> And afaik, absolutely nobody uses more than about 36 bytes of that
>> 512-byte _sifields union (and that one use is SIGILL with three
>> pointers and three integers and some padding.
>>
>> So why don't we just say "screw this idiotic layout crap, and just
>> unconditionally copy that much smaller maximum of bytes"?
>>
>> Leave that layout thing purely for compat handling.
>
> I completely agree.

So I just did some measurements to see what the performance impact is of
doing the simple and obvious thing of always copying the entire siginfo
around.  There is a fair amount of variation in my timings but for
the whole change I see about a 20ns increase in time taken to send
a signal with siginfo from the current process to the current process.
AKA timing kill(getpid(),...). 

I played with some clever changes such as limiting the copy to 48 bytes,
disabling the memset and the like but I could not get a strong enough
signal to say that any one change removed the extra or a clear part of
it 20ns.

Do we care about those 20ns for signal deliver?  I suspect from my
previous numbers that if Andy can get signal delivery to use sysret
it will more than make up for the small increase in cost here.

Eric
