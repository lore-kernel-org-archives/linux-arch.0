From: Hagen Paul Pfeifer <hagen@jauu.net>
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
Date: Tue, 28 Apr 2020 08:39:35 +0200
Message-ID: <20200428063935.GA5660@laniakea>
References: <CAHk-=wga3O=BoKZXR27-CDnAFareWcMxXhpWerwtCffdaH6_ow@mail.gmail.com>
 <B7A115CB-0C8C-4719-B97B-74D94231CD1E@amacapital.net>
 <CAHk-=whQzOsh9O2uhUO2VETD+hrzjKMpEJpzoUby5QHMcvgPKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout-p-201.mailbox.org ([80.241.56.171]:9918 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgD1Gjr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Apr 2020 02:39:47 -0400
Content-Disposition: inline
In-Reply-To: <CAHk-=whQzOsh9O2uhUO2VETD+hrzjKMpEJpzoUby5QHMcvgPKg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner <christian.brauner@ubuntu.com>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Jann Horn <jannh@google.com>, kernel list <linux-kernel@vger.kernel.org>, Florian Weimer <fweimer@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>, Sami Tolvanen <samitolvanen@google.com>, David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Sargun

* Linus Torvalds | 2020-04-27 21:28:14 [-0700]:

>> I hate to say this, but I’m not convinced that asking the gdb folks is
>> the right approach. GDB has an ancient architecture and is
>> *incredibly* buggy. I’m sure ptrace is somewhere on the pain point
>> list, but I suspect it’s utterly dwarfed by everything else.
>
>You may be right. However, if gdbn isn't going to use it, then I
>seriously don't think it's worth changing much.
>
>It might be worth looking at people who don't use ptrace() for
>debugging, but for "incidental" reasons. IOW sandboxing, tracing,
>things like that.
>
>Maybe those people want things that are simpler and don't actually
>need the kinds of hard serialization that ptrace() wants.
>
>I'd rather add a few really simple things that might not be a full
>complement of operations for a debugger, but exactly because they
>aren't a full debugger, maybe they are things that we can tell are
>obviously secure and simple?

Okay, to sum up the the whole discussion: we go forward with Jann's proposal
by simple adding PTRACE_ATTACH_PIDFD and friends. This is the minimal invasive
solution and the risk of an potenial security problem is almost not present[TM].

Changing the whole ptrace API is a different beast. I rather believe that I
see Linus Linux successor rather than a ptrace successor.

I am fine with PTRACE_ATTACH_PIDFD!

Hagen
