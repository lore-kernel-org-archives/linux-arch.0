From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v7 0/5] parisc: system call table generation support
Date: Fri, 16 Nov 2018 15:20:57 -0800
Message-ID: <CAK8P3a2g-7iR594Fs_goYCYPqgO6FRML5oi9vodDC_wKHF64bA@mail.gmail.com>
References: <1542177301-25844-1-git-send-email-firoz.khan@linaro.org>
 <58c3c4a4-7f55-bf08-1c96-ef1aa7f97072@gmx.de> <CALxhOngc1cSSDVznnX+iLg-Ne9+k0ct0wT-z0MXKSeKxJE3Vsg@mail.gmail.com>
 <20181116215502.GA6585@ls3530.dellerweb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181116215502.GA6585@ls3530.dellerweb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Helge Deller <deller@gmx.de>
Cc: Firoz Khan <firoz.khan@linaro.org>, Parisc List <linux-parisc@vger.kernel.org>, James.Bottomley@hansenpartnership.com, John David Anglin <dave.anglin@bell.net>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Thomas Gleixner <tglx@linutronix.de>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Nov 16, 2018 at 1:55 PM Helge Deller <deller@gmx.de> wrote:
> > On Fri, 16 Nov 2018 at 01:01, Helge Deller <deller@gmx.de> wrote:
> > >
> > > On 14.11.2018 07:34, Firoz Khan wrote:
> > > > The purpose of this patch series is, we can easily
> > > > add/modify/delete system call table support by cha-
> > > > nging entry in syscall.tbl file instead of manually
> > > > changing many files. The other goal is to unify the
> > > > system call table generation support implementation
> > > > across all the architectures.
> > > >
> > > > The system call tables are in different format in
> > > > all architecture. It will be difficult to manually
> > > > add, modify or delete the system calls in the resp-
> > > > ective files manually. To make it easy by keeping a
> > > > script and which'll generate uapi header file and
> > > > syscall table file.
> > > >
> > > > syscall.tbl contains the list of available system
> > > > calls along with system call number and correspond-
> > > > ing entry point. Add a new system call in this arch-
> > > > itecture will be possible by adding new entry in the
> > > > syscall.tbl file.
> > > >
> > > > Adding a new table entry consisting of:
> > > >         - System call number.
> > > >         - ABI.
> > > >         - System call name.
> > > >         - Entry point name.
> > > >
> > > > ....
> > > > Firoz Khan (5):
> > > >   parisc: move __IGNORE* entries to non uapi header
> > > >   parisc: add __NR_syscalls along with __NR_Linux_syscalls
> > > >   parisc: add system call table generation support
> > > >   parisc: generate uapi header and system call table files
> > > >   parisc: syscalls: ignore nfsservctl for other architectures
> > >
> > > Firoz, you may add
> > > Acked-by: Helge Deller <deller@gmx.de>
> > > to the whole parisc series.
> >
> > Sure, will do.
> > I'm on a vacation right now. will send mid next week.
>
> That's ok, there is no urgency.
>
> Actually, I noticed that the generated files unistd_32.h
> and unistd_64.h do have the same contents, since on parisc
> we keep the syscall numbers the same for 32- and 64-bit.
> With that in mind, we can simply generate on unistd.h
> file for both variants.

It depends on what we want to do in the future. When we add
around 20 new system calls fro y2038, my plan was to
only add them for 32-bit architectures, leaving holes on
64-bit ones. We can also assign the new numbers on parisc64
but they would have the same entry point as existing calls.

If you prefer doing it like that, your patch seems fine for that,
it's just slightly inconsistent with the other 64-bit architectures
then.

          Arnd
