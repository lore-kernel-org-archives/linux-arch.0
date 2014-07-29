Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:48103 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbaG2RCI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 Jul 2014 13:02:08 -0400
Received: by mail-lb0-f182.google.com with SMTP id z11so7230996lbi.13
        for <linux-arch@vger.kernel.org>; Tue, 29 Jul 2014 10:02:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140729165416.GA967@redhat.com>
References: <cover.1405992946.git.luto@amacapital.net> <3f649f5658a163645e3ce15156176c325283762e.1405992946.git.luto@amacapital.net>
 <20140728173723.GA20993@redhat.com> <CALCETrWUFo_zXcAZja-vdL4_MgJDd=1ed5Vt54eyUuim930xAw@mail.gmail.com>
 <20140729165416.GA967@redhat.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 29 Jul 2014 10:01:47 -0700
Message-ID: <CALCETrWBU-=zqLTCP7B1feZ9J-e4u-Boic+e1EEn1rL-ijeEKg@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] x86: Split syscall_trace_enter into two phases
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Will Drewry <wad@chromium.org>, X86 ML <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-arch <linux-arch@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, Alexei Starovoitov <ast@plumgrid.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <20140729170147.73M_Hf8qe8l7HZAKoJQpezpIvpzt3YX1TnLa0LgillA@z>

On Tue, Jul 29, 2014 at 9:54 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 07/28, Andy Lutomirski wrote:
>>
>> On Mon, Jul 28, 2014 at 10:37 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>> > Hi Andy,
>> >
>> > I am really sorry for delay.
>> >
>> > This is on top of the recent change from Kees, right? Could me remind me
>> > where can I found the tree this series based on? So that I could actually
>> > apply these changes...
>>
>> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp/fastpath
>>
>> The first four patches are already applied there.
>
> Thanks!
>
>> > If I understand correctly, syscall_trace_enter() can avoid _phase2() above.
>> > But we should always call user_exit() unconditionally?
>>
>> Damnit.  I read that every function called by user_exit, and none of
>> them give any indication of why they're needed for traced syscalls but
>> not for untraced syscalls.  On a second look, it seems that TIF_NOHZ
>> controls it.
>
> Yes, just to trigger the slow path, I guess.
>
>> I'll update the code to call user_exit iff TIF_NOHZ is
>> set.
>
> Or perhaps it would be better to not add another user of this (strange) flag
> and just call user_exit() unconditionally(). But, yes, you need to use
> from "work = flags & (_TIF_WORK_SYSCALL_ENTRY & ~TIF_NOHZ)" then.\

user_exit looks slow enough to me that a branch to try to avoid it may
be worthwhile.  I bet that explicitly checking the flag is
actually both faster and clearer.  That's what I did for v4.

--Andy

>
>> > And we should always set X86_EFLAGS_TF if TIF_SINGLESTEP? IIRC, TF can be
>> > actually cleared on a 32bit kernel if we step over sysenter insn?
>>
>> I don't follow.  If TIF_SINGLESTEP, then phase1 will return a nonzero
>> value,
>
> Ah yes, thanks, I missed this.
>
> Oleg.
>



-- 
Andy Lutomirski
AMA Capital Management, LLC
