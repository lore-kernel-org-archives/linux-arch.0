From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
Date: Mon, 27 Apr 2020 18:36:36 -0700
Message-ID: <CAHk-=wga3O=BoKZXR27-CDnAFareWcMxXhpWerwtCffdaH6_ow@mail.gmail.com>
References: <20200426130100.306246-1-hagen@jauu.net> <20200426163430.22743-1-hagen@jauu.net>
 <20200427170826.mdklazcrn4xaeafm@wittgenstein> <CAG48ez0hskhN7OkxwHX-Bo5HGboJaVEk8udFukkTgiC=43ixcw@mail.gmail.com>
 <87zhawdc6w.fsf@x220.int.ebiederm.org> <20200427185929.GA1768@laniakea>
 <CAK8P3a2Ux1pDZEBjgRSPMJXvwUAvbPastX2ynVVC2iPTTDK_ow@mail.gmail.com>
 <20200427201303.tbiipopeapxofn6h@wittgenstein> <20200428004546.mlpwixgms2ekpfdm@yavin.dot.cyphar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726251AbgD1Bg5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Apr 2020 21:36:57 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFD5C03C1A8
        for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2020 18:36:57 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u15so19724048ljd.3
        for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2020 18:36:57 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id l2sm11307361ljg.89.2020.04.27.18.36.52
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 18:36:54 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id u15so19723954ljd.3
        for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2020 18:36:52 -0700 (PDT)
In-Reply-To: <20200428004546.mlpwixgms2ekpfdm@yavin.dot.cyphar.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>, Arnd Bergmann <arnd@arndb.de>, Hagen Paul Pfeifer <hagen@jauu.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Jann Horn <jannh@google.com>, kernel list <linux-kernel@vger.kernel.org>, Florian Weimer <fweimer@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>, Sami Tolvanen <samitolvanen@google.com>, David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Sargun Dhillon <sargun@sargun.me>, Linux

On Mon, Apr 27, 2020 at 5:46 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> I agree. It would be a shame to add a new ptrace syscall and not take
> the opportunity to fix the multitude of problems with the existing API.
> But that's a Pandora's box which we shouldn't open unless we want to
> wait a long time to get an API everyone is okay with -- a pretty high
> price to just get pidfds support in ptrace.

We should really be very very careful with some "smarter ptrace".
We've had _so_ many security issues with ptrace that it's not even
funny.

And that's ignoring all the practical issues we've had.

I would definitely not want to have anything that looks like ptrace AT
ALL using pidfd. If we have a file descriptor to specify the target
process, then we should probably take advantage of that file
descriptor to actually make it more of a asynchronous interface that
doesn't cause the kinds of deadlocks that we've had with ptrace.

The synchronous nature of ptrace() means that not only do we have
those nasty deadlocks, it's also very very expensive to use. It also
has some other fundamental problems, like the whole "take over parent"
and the SIGCHLD behavior.

It also is hard to ptrace a ptracer. Which is annoying when you're
debugging gdb or strace or whatever.

So I think the thing to do is ask the gdb (and strace) people if they
have any _very_ particular painpoints that we could perhaps help with.

And then very carefully think things through and not repeat all the
mistakes ptrace did.

I'm not very optimistic.

              Linus
