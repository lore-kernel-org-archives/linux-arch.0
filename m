From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 06/10] x86/cet: Add arch_prctl functions for shadow stack
Date: Fri, 8 Jun 2018 07:57:22 -0700
Message-ID: <CALCETrUyapFiiXrHH23NW8XbqEkfKdGGU2wMUZ2DU=A+GWGqvw@mail.gmail.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-7-yu-cheng.yu@intel.com>
 <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
 <1528403417.5265.35.camel@2b52.sc.intel.com> <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
 <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com>
 <CALCETrV1GG5rq_kwxkS-o3x8Ldr72ThdYgkJKQ9cx9Q63SxgTQ@mail.gmail.com>
 <CAMe9rOpeDrkwi-AG0vsiZy4NwkmavhB5Empv58FSHxtr3rpapw@mail.gmail.com>
 <CALCETrWhMmqGWKx-yw55YKHMJwGyLZio5f8Pskh8X69zfQMy7A@mail.gmail.com> <CAMe9rOpLDzWk=xdZqN1QJVnP-c_dti5Fy=C_GqbeQpS_a=0ewA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMe9rOpLDzWk=xdZqN1QJVnP-c_dti5Fy=C_GqbeQpS_a=0ewA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. J. Lu" <hjl.tools@gmail.com>, Cyrill Gorcunov <gorcunov@openvz.org>, Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: Andrew Lutomirski <luto@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
List-Id: linux-arch.vger.kernel.org

On Fri, Jun 8, 2018 at 5:24 AM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> On Thu, Jun 7, 2018 at 9:38 PM, Andy Lutomirski <luto@kernel.org> wrote:
> > On Thu, Jun 7, 2018 at 9:10 PM H.J. Lu <hjl.tools@gmail.com> wrote:
> >>
> >> On Thu, Jun 7, 2018 at 4:01 PM, Andy Lutomirski <luto@kernel.org> wrote:
> >>
> >
> > By the time malicious code issue its own syscalls, you've already lost
> > the battle.  I could probably be convinced that a lock-CET-on feature
> > that applies *only* to the calling thread and is not inherited by
> > clone() is a decent idea, but I'd want to see someone who understands
> > the state of the art in exploit design justify it.  You're also going
> > to need to figure out how to make CRIU work if you allow locking CET
> > on.
> >
> > A priori, I think we should just not provide a lock mechanism.
>
> We need a door for CET.  But it is a very bad idea to leave it open
> all the time.  I don't know much about CRIU,  If it is Checkpoint/Restore
> In Userspace.  Can you free any application with AVX512 on AVX512
> machine and restore it on non-AVX512 machine?

Presumably not -- if the program uses AVX512 and AVX512 goes away,
then the program won't be happy.

Anyway, having thought about this, here's a straw man proposal.  We
add a lock flag like in these patches.  The lock flag is set by
arch_prctl(), inherited on clone, and cleared on exec().  ptrace()
gains a new API to clear the lock flag and can modify the CET
configuration regardless of the lock flag.  (So ptrace() needs APIs to
read and write SSP, to read and write the shadow stack itself, and to
change the mode.)  By the time an attacker has gotten enough control
of a victim process to get it to use ptrace(), I don't think that
trying to protect CET serves any purpose.

As an aside, where are the latest CET docs?  I've found the "CET
technology preview 2.0", but it doesn't seem to be very clear or
entirely complete.

On Fri, Jun 8, 2018 at 5:17 AM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> On Thu, Jun 7, 2018 at 9:35 PM, Andy Lutomirski <luto@kernel.org> wrote:

> > Is there any reason you can't use LD_CET=force to do it for
> > dynamically linked binaries?
>
> We need to enable shadow stack from the start.  Otherwise function
> return will fail when returning from callee with shadow stack to caller
> without shadow stack.

I don't see the problem.  A CET-supporting ld.so will be started with
CET on regardless of what the final binary says.  If ld.so sees
LD_CET=force, it can keep CET on regardless of the flags in the loaded
binary.

>
> > I find it quite hard to believe that forcibly CET-ifying a legacy
> > statically linked binary is a good idea.
>
> We'd like to provide protection as much as we can.
>

I agree that this is a nice sentiment, but I don't think that a simple
"force CET on next exec()" flag is a good way to accomplish this.
I've had the pleasure of using legacy binaries, and there are all
kinds of gotchas.  First, a bunch of them aren't binaries at all --
they're shell scripts.  There's big_expensive_program that starts with
#!/bin/bash and eventually execs
/opt/blahblahblah/big_expensive_program_bin, and that involves two
execs.  (Heck, even Firefox is set up more or less like this.)  Some
programs can re-exec themselves.  All of this is not to mention that
it would be really annoying when your program crashes after you've
been using it for hours because you finally triggered the code path
that did longjmp() and CET kills it.

And you don't really need kernel support for this anyway.  It should
be relatively straightforward to write a loader that opens and loads a
static binary.

I think that this entire CET-on-exec concept should be dropped from
this patch series.  If someone really wants it, make it a separate
patch on top after everything has been merged, and we can poke holes
in it them.
