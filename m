Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f180.google.com ([209.85.208.180]:45844 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfDVQ4W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Apr 2019 12:56:22 -0400
Received: by mail-lj1-f180.google.com with SMTP id y6so10850728ljd.12
        for <linux-arch@vger.kernel.org>; Mon, 22 Apr 2019 09:56:20 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id e17sm2812175ljj.20.2019.04.22.09.56.19
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 09:56:19 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id a28so9442086lfo.7
        for <linux-arch@vger.kernel.org>; Mon, 22 Apr 2019 09:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000043fe9c058720a5d3@google.com> <ad884b18-0e03-d6be-02b0-4e5273f068ce@kernel.dk>
 <CAHk-=wgG=RqK8T5kWiZfH7da6rBuqp3kAesP=ETgceb6RzvZng@mail.gmail.com>
 <53a17444-9539-5810-82a0-ceeefa742508@kernel.dk> <cfa6be6d-4125-6d1e-8993-e9ec9dbaa7bb@kernel.dk>
In-Reply-To: <cfa6be6d-4125-6d1e-8993-e9ec9dbaa7bb@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 22 Apr 2019 09:48:08 -0700
Message-ID: <CAHk-=wh=kKEb6qbuhnSWh5S55SbQBOE33991ULSFUgVrEnzivA@mail.gmail.com>
Subject: Re: WARNING in percpu_ref_kill_and_confirm
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: syzbot <syzbot+10d25e23199614b7721f@syzkaller.appspotmail.com>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, "Darrick J. Wong" <darrick.wong@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Anvin <hpa@zytor.com>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Andrew Lutomirski <luto@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Thomas Gleixner <tglx@linutronix.de>, Al Viro <viro@zeniv.linux.org.uk>, the arch/x86 maintainers <x86@kernel.org>
Message-ID: <20190422164808.hs3pkvtRe_Y4IBfO8OwiFb4ToNrJ6BgbQDovaEgCKcw@z>

On Mon, Apr 22, 2019 at 9:38 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> With the mutex change in, I can trigger it in a second or so. Just ran
> the reproducer with that change reverted, and I'm not seeing any badness.
> So I do wonder if the bisect results are accurate?

Looking at the syzbot report, it's syzbot being confused.

The actual WARNING in percpu_ref_kill_and_confirm() only happens with
recent kernels.

But then syzbot mixes it up with a completely different bug:

   crash: BUG: MAX_STACK_TRACE_ENTRIES too low!
   BUG: MAX_STACK_TRACE_ENTRIES too low!

and for some reason decides that *that* bug is the same thing entirely.

So yeah, I think the simple percpu_ref_is_dying() check is sufficient,
and that the syzbot bisection is completely bogus.

                Linus
