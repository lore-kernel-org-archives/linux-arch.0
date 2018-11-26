Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725739AbeK0FYu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Nov 2018 00:24:50 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D19020862
        for <linux-arch@vger.kernel.org>; Mon, 26 Nov 2018 18:29:53 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id k198so19662488wmd.3
        for <linux-arch@vger.kernel.org>; Mon, 26 Nov 2018 10:29:53 -0800 (PST)
MIME-Version: 1.0
References: <20181119214809.6086-1-yu-cheng.yu@intel.com> <CALCETrWLtpfkecfUAXJ64Z5xDeHPJxTQSci+T4RCem7vCqorTw@mail.gmail.com>
 <35b33f293bc392df71710102f38fa6a40d0bb996.camel@intel.com>
In-Reply-To: <35b33f293bc392df71710102f38fa6a40d0bb996.camel@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 26 Nov 2018 10:29:40 -0800
Message-ID: <CALCETrV4BP6gTgVZos19WZrbgEH7t4PqPOeP2VJte1kE=ehokg@mail.gmail.com>
Subject: Re: [RFC PATCH v6 00/26] Control-flow Enforcement: Shadow Stack
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Andrew Lutomirski <luto@kernel.org>, Florian Weimer <fweimer@redhat.com>, Carlos O'Donell <carlos@redhat.com>, Rich Felker <dalias@libc.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>
Message-ID: <20181126182940.GfFaPH857nCnkqP5Dem17zVjYXjH_F9_AdVQoDbY9VY@z>

On Mon, Nov 26, 2018 at 9:44 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> On Thu, 2018-11-22 at 08:53 -0800, Andy Lutomirski wrote:
> > [cc some more libc folks]

>
> >
> > 2. I want to be able to modify the signal context from a signal
> > handler such that, when the signal handler returns, it will return to
> > a frame higher up on the call stack than where the signal started and
> > to a different RIP value.  How can I do this?  I guess I can modify
> > the shadow stack with WRSS if WR_SHSTK_EN=1, but how do I tell the
> > kernel to kindly skip the frames I want to skip when I do sigreturn()?
> >
> > The reason I'm asking #2 is that I think it's time to resurrect my old
> > vDSO syscall cancellation helper series here:
> >
> > https://lwn.net/Articles/679434/
>
> If tools/testing/selftests/x86/unwind_vdso.c passes, can we say the kernel does
> the right thing?  Or do you have other tests that I can run?

I haven't written the relevant test yet.  Hopefully soon :)
