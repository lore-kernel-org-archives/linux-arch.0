Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730728AbeKWDde (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Nov 2018 22:33:34 -0500
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E1EC2147D
        for <linux-arch@vger.kernel.org>; Thu, 22 Nov 2018 16:53:21 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id r11-v6so9580444wmb.2
        for <linux-arch@vger.kernel.org>; Thu, 22 Nov 2018 08:53:21 -0800 (PST)
MIME-Version: 1.0
References: <20181119214809.6086-1-yu-cheng.yu@intel.com>
In-Reply-To: <20181119214809.6086-1-yu-cheng.yu@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 22 Nov 2018 08:53:08 -0800
Message-ID: <CALCETrWLtpfkecfUAXJ64Z5xDeHPJxTQSci+T4RCem7vCqorTw@mail.gmail.com>
Subject: Re: [RFC PATCH v6 00/26] Control-flow Enforcement: Shadow Stack
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, Florian Weimer <fweimer@redhat.com>, Carlos O'Donell <carlos@redhat.com>, Rich Felker <dalias@libc.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>
Message-ID: <20181122165308.LKc6bMoNzmR92RIqh18LIbB4i5GxUpE5cKTG-yqhexU@z>

[cc some more libc folks]

I have a general question about this patch set:

If I'm writing a user program, and I write a signal handler, there are
two things I want to make sure I can still do:

1. I want to be able to unwind directly from the signal handler
without involving sigreturn() -- that is, I want to make sure that
siglongjmp() works.  How does this work?  Is INCSSP involved?  How
exactly does the user program know how much to increment SSP by?  (And
why on Earth does INCSSP only consider the low 8 bits of its argument?
 That sounds like a mistake.  Can Intel still fix that?  On the other
hand, what happens if you INCSSP off the end of the shadow stack
entirely?  I assume the next access will fault as long as there's an
appropriate guard page.)

2. I want to be able to modify the signal context from a signal
handler such that, when the signal handler returns, it will return to
a frame higher up on the call stack than where the signal started and
to a different RIP value.  How can I do this?  I guess I can modify
the shadow stack with WRSS if WR_SHSTK_EN=1, but how do I tell the
kernel to kindly skip the frames I want to skip when I do sigreturn()?

The reason I'm asking #2 is that I think it's time to resurrect my old
vDSO syscall cancellation helper series here:

https://lwn.net/Articles/679434/

and it's not at all clear to me that __vdso_abort_pending_syscall()
can work without kernel assistance when CET is enabled.  I want to
make sure that it can be done, or I want to come up with some other
way to allow a signal handler to abort a syscall while CET is on.  I
could probably change __vdso_abort_pending_syscall() to instead point
RIP to __kernel_vsyscall's epilogue so that we con't change the depth
of the call stack.  But I could imagine that other user programs might
engage in similar shenanigans and want to have some way to unwind a
signal's return context without actually jumping there a la
siglongjmp().

Also, what is the intended setting of WR_SHSTK_EN with this patch set applied?

(I suppose we could just say that 32-bit processes should not use CET,
but that seems a bit sad.)
