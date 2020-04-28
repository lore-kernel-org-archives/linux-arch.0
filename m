From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
Date: Mon, 27 Apr 2020 21:28:14 -0700
Message-ID: <CAHk-=whQzOsh9O2uhUO2VETD+hrzjKMpEJpzoUby5QHMcvgPKg@mail.gmail.com>
References: <CAHk-=wga3O=BoKZXR27-CDnAFareWcMxXhpWerwtCffdaH6_ow@mail.gmail.com>
 <B7A115CB-0C8C-4719-B97B-74D94231CD1E@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <B7A115CB-0C8C-4719-B97B-74D94231CD1E@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner <christian.brauner@ubuntu.com>, Arnd Bergmann <arnd@arndb.de>, Hagen Paul Pfeifer <hagen@jauu.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Jann Horn <jannh@google.com>, kernel list <linux-kernel@vger.kernel.org>, Florian Weimer <fweimer@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>, Sami Tolvanen <samitolvanen@google.com>, David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Sargun
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 27, 2020 at 9:17 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
> I hate to say this, but I=E2=80=99m not convinced that asking the gdb fol=
ks is
> the right approach. GDB has an ancient architecture and is
> *incredibly* buggy. I=E2=80=99m sure ptrace is somewhere on the pain poin=
t
> list, but I suspect it=E2=80=99s utterly dwarfed by everything else.

You may be right. However, if gdbn isn't going to use it, then I
seriously don't think it's worth changing much.

It might be worth looking at people who don't use ptrace() for
debugging, but for "incidental" reasons. IOW sandboxing, tracing,
things like that.

Maybe those people want things that are simpler and don't actually
need the kinds of hard serialization that ptrace() wants.

I'd rather add a few really simple things that might not be a full
complement of operations for a debugger, but exactly because they
aren't a full debugger, maybe they are things that we can tell are
obviously secure and simple?

               Linus
