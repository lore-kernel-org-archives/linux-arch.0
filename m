From: Kees Cook <keescook@chromium.org>
Subject: Re: [kernel-hardening] [PATCH 0/2] introduce post-init read-only memory
Date: Mon, 30 Nov 2015 13:33:03 -0800
Message-ID: <CAGXu5jK+5UjQt+YZV_oe286+_5NrsZ7gTyVr-v+R7mF1uHskTg@mail.gmail.com>
References: <1448401114-24650-1-git-send-email-keescook@chromium.org>
	<CA+rthh-euk2hGGWjsDqXogWSmzmJNV1aiUVfnTfrzyQhndgbOQ@mail.gmail.com>
	<565595F5.32536.DB9FE75@pageexec.freemail.hu>
	<20151126085425.GA29848@gmail.com>
	<CALCETrXrvAY+mXx+JULw7W+xokcSPFgWm5-McJf9EKhYehPhbA@mail.gmail.com>
	<20151127075959.GA24991@gmail.com>
	<CA+55aFxH+Gy4U8WbGWXh+ybrvng8tw1=2CrjPnJSju3+c5XpbA@mail.gmail.com>
	<CAGXu5j+mvknX69Kk1S8u54LR4T+KED8zZdkqQWA9KMrOvtVQtQ@mail.gmail.com>
	<CALCETrVVYMUgxABoEVfJgLtE+nB44aijqG5saq8dTQSTVWxbMA@mail.gmail.com>
	<20151129080505.GA23721@gmail.com>
	<565CBC37.9090106@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35577 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959AbbK3VdF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Nov 2015 16:33:05 -0500
Received: by igl9 with SMTP id 9so74244727igl.0
        for <linux-arch@vger.kernel.org>; Mon, 30 Nov 2015 13:33:04 -0800 (PST)
In-Reply-To: <565CBC37.9090106@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Linus Torvalds <torvalds@linux-foundation.org>, PaX Team <pageexec@freemail.hu>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Mathias Krause <minipli@googlemail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, linux-arch <linux-arch@vger.kernel.org>, Emese Revfy <re.emese@gmail.com>

On Mon, Nov 30, 2015 at 1:14 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 11/29/15 00:05, Ingo Molnar wrote:
>>
>> * Andy Lutomirski <luto@amacapital.net> wrote:
>>
>>>>>  - print a warning and a backtrace, and just mark the page read-write
>>>>> so that the machine survives, but we get notified and can fix whatever
>>>>> broken code
>>>>
>>>> This seems very easy to add. Should I basically reverse the effects of
>>>> mark_rodata_ro(), or should I only make the new ro-after-init section as RW?
>>>> (I think the former would be easier.)
>>>
>>> I'd suggest verifying that the page in question is .data..ro_after_init and, if
>>> so, marking that one page RW.
>>
>> Yes, this was PaX's suggestion as well, and I agree: doing that turns a quite
>> possibly unrecoverable boot/shutdown time or suspend/resume time (suspend is
>> really a special category of 'bootup') crasher oops into a more informative stack
>> dump.
>>
>> These ro related faults tend to trigger when init/deinit is running, and oopsing
>> in those sequences is typically a lot less survivable than say oopsing in a high
>> level system call while not holding locks.
>>
>
> I think what should do is have a debug option which can be set to "rw",
> "log" or "oops"; the latter should probably be the default.

Can someone write that patch, and then I will include it in the
series? I haven't touched fault handler code, and it would be faster
if someone more familiar with that area did it. :)

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
