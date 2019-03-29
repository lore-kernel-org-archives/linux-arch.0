Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46186 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729846AbfC2SMi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Mar 2019 14:12:38 -0400
Received: by mail-lj1-f193.google.com with SMTP id h21so2746089ljk.13
        for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2019 11:12:36 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id m77sm481286lje.67.2019.03.29.11.12.34
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 11:12:34 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id t4so2800121ljc.2
        for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2019 11:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230512.486297455@goodmis.org> <CAHk-=whtDB2HiEgyKcJPN7m8c83GrY=hQ=p-m-um1N6eSqxczg@mail.gmail.com>
 <20190329134045.3fb2e69f@gandalf.local.home>
In-Reply-To: <20190329134045.3fb2e69f@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Mar 2019 11:12:18 -0700
Message-ID: <CAHk-=wjOQpkGb43zE8+djZ99tiVRefJ7mmWFOUN=v6RFRTBvCQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/4 v2] sycalls: Remove args i and n from syscall_get_arguments()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Dmitry V. Levin" <ldv@altlinux.org>
Message-ID: <20190329181218.ruXLe_2R9tmCkjZfMar2Aoarw5VTYrmz7qqslvsMLJc@z>

On Fri, Mar 29, 2019 at 10:40 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I'll keep it around for now, but this should go as a warning to Dmitry,
> to get something using it soon, or they may be dropped.

I don't think _that_ is the argument.

Quite the reverse: nobody has ever used it, why have it around, and
much less try to hurry some new pointless user to use it?

The "get system call arguments" code at least can be used somewhat
generically for things like tracing and strace.

The "set system call arguments" can NOT.

Anybody who sets system call arguments had better intimately know the
details anyway, and any user code has to have any legacy ptrace
interface anyway for all but the newest kernels.

So I will just say "NO". No new stupid interface that doesn't have a
truly immensely convincing reason for it.

And definitely not hurried along by "nobody has ever usefully done
this before and now people are noticing how bad the interfaces are, so
let's cobble some sh*t together quickly".

                     Linus
