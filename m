From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 00/10] Control Flow Enforcement - Part (3)
Date: Mon, 18 Jun 2018 14:44:33 -0700
Message-ID: <CALCETrWCEjuM56J8dqXPR==MevJTYKan5dnAMFJaXzFMYr8Q_A@mail.gmail.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <bbfde1b3-5e1b-80e3-30e8-fd1e46a2ceb1@gmail.com>
 <1528815820.8271.16.camel@2b52.sc.intel.com> <814fc15e80908d8630ff665be690ccbe6e69be88.camel@gmail.com>
 <1528988176.13101.15.camel@2b52.sc.intel.com> <2b77abb17dfaf58b7c23fac9d8603482e1887337.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2b77abb17dfaf58b7c23fac9d8603482e1887337.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Balbir Singh <bsingharora@gmail.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
List-Id: linux-arch.vger.kernel.org

On Sat, Jun 16, 2018 at 8:16 PM Balbir Singh <bsingharora@gmail.com> wrote:
>
> On Thu, 2018-06-14 at 07:56 -0700, Yu-cheng Yu wrote:
> > On Thu, 2018-06-14 at 11:07 +1000, Balbir Singh wrote:
> > > On Tue, 2018-06-12 at 08:03 -0700, Yu-cheng Yu wrote:
> > > > On Tue, 2018-06-12 at 20:56 +1000, Balbir Singh wrote:
> > > > >
> > > > > On 08/06/18 00:37, Yu-cheng Yu wrote:
> > > > > > This series introduces CET - Shadow stack
> > > > > >
> > > > > > At the high level, shadow stack is:
> > > > > >
> > > > > >       Allocated from a task's address space with vm_flags VM_SHSTK;
> > > > > >       Its PTEs must be read-only and dirty;
> > > > > >       Fixed sized, but the default size can be changed by sys admin.
> > > > > >
> > > > > > For a forked child, the shadow stack is duplicated when the next
> > > > > > shadow stack access takes place.
> > > > > >
> > > > > > For a pthread child, a new shadow stack is allocated.
> > > > > >
> > > > > > The signal handler uses the same shadow stack as the main program.
> > > > > >
> > > > >
> > > > > Even with sigaltstack()?
> > > > >
> > > >
> > > > Yes.
> > >
> > > I am not convinced that it would work, as we switch stacks, oveflow might
> > > be an issue. I also forgot to bring up setcontext(2), I presume those
> > > will get new shadow stacks
> >
> > Do you mean signal stack/sigaltstack overflow or swapcontext in a signal
> > handler?
> >
>
> I meant any combination of that. If there is a user space threads implementation that uses sigaltstack for switching threads
>

Anyone who does that is nuts.  The whole point of user space threads
is speed, and signals are very slow.  For userspace threads to work,
we need an API to allocate new shadow stacks, and we need to use the
extremely awkwardly defined RSTORSSP stuff to switch.  (I assume this
is possible on an ISA level.  The docs are bad, and the mnemonics for
the relevant instructions are nonsensical.)
