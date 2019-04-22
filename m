Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f176.google.com ([209.85.166.176]:38470 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbfDVQvA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Apr 2019 12:51:00 -0400
Received: by mail-it1-f176.google.com with SMTP id q19so1075494itk.3
        for <linux-arch@vger.kernel.org>; Mon, 22 Apr 2019 09:50:59 -0700 (PDT)
Subject: Re: WARNING in percpu_ref_kill_and_confirm
References: <00000000000043fe9c058720a5d3@google.com>
 <ad884b18-0e03-d6be-02b0-4e5273f068ce@kernel.dk>
 <CAHk-=wgG=RqK8T5kWiZfH7da6rBuqp3kAesP=ETgceb6RzvZng@mail.gmail.com>
 <53a17444-9539-5810-82a0-ceeefa742508@kernel.dk>
 <cfa6be6d-4125-6d1e-8993-e9ec9dbaa7bb@kernel.dk>
 <CAHk-=wh=kKEb6qbuhnSWh5S55SbQBOE33991ULSFUgVrEnzivA@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4179bb56-0285-9e14-5ae9-7a16957b6210@kernel.dk>
Date: Mon, 22 Apr 2019 10:50:56 -0600
MIME-Version: 1.0
In-Reply-To: <CAHk-=wh=kKEb6qbuhnSWh5S55SbQBOE33991ULSFUgVrEnzivA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: syzbot <syzbot+10d25e23199614b7721f@syzkaller.appspotmail.com>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, "Darrick J. Wong" <darrick.wong@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Anvin <hpa@zytor.com>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Andrew Lutomirski <luto@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Thomas Gleixner <tglx@linutronix.de>, Al Viro <viro@zeniv.linux.org.uk>, the arch/x86 maintainers <x86@kernel.org>
Message-ID: <20190422165056.IgqbF19mj5OQN-Xgp-HEhvf6CUelczAb4yxySx56nJ8@z>

On 4/22/19 10:48 AM, Linus Torvalds wrote:
> On Mon, Apr 22, 2019 at 9:38 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> With the mutex change in, I can trigger it in a second or so. Just ran
>> the reproducer with that change reverted, and I'm not seeing any badness.
>> So I do wonder if the bisect results are accurate?
> 
> Looking at the syzbot report, it's syzbot being confused.
> 
> The actual WARNING in percpu_ref_kill_and_confirm() only happens with
> recent kernels.
> 
> But then syzbot mixes it up with a completely different bug:
> 
>    crash: BUG: MAX_STACK_TRACE_ENTRIES too low!
>    BUG: MAX_STACK_TRACE_ENTRIES too low!
> 
> and for some reason decides that *that* bug is the same thing entirely.
> 
> So yeah, I think the simple percpu_ref_is_dying() check is sufficient,
> and that the syzbot bisection is completely bogus.

Ah good, that makes me feel better. I'll queue the fix up, thanks.

-- 
Jens Axboe
