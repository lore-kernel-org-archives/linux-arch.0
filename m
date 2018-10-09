From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 3/6] parisc: add system call table generation support
Date: Tue, 9 Oct 2018 09:47:48 +0200
Message-ID: <CAK8P3a0D+GUzza--ETrT1NHGduTfFGVoCcSEn5LxvKTtMYisbA@mail.gmail.com>
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-4-git-send-email-firoz.khan@linaro.org> <CALxhOnj4r_MUuAa2zvkvxvhQttEvCZ98n2dA9d6CYyvVf2rB3g@mail.gmail.com>
 <20181008130301.GM32759@asgard.redhat.com> <CAK8P3a0eoCVBVOZs0VwybAnUw0OUoW4Z=NJYi8686EHKj076_Q@mail.gmail.com>
 <CALxhOniJZGNCP+Xw_9EF8hnUEG_AWwrnQ86Gbh7vAW6SrE8ykQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALxhOniJZGNCP+Xw_9EF8hnUEG_AWwrnQ86Gbh7vAW6SrE8ykQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Eugene Syromiatnikov <esyr@redhat.com>, Parisc List <linux-parisc@vger.kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 9, 2018 at 7:35 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> On Mon, 8 Oct 2018 at 19:27, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Oct 8, 2018 at 3:02 PM Eugene Syromiatnikov <esyr@redhat.com> wrote:
> > > > > +87      common  swapon                          sys_swapon
> > > > > +88      common  reboot                          sys_reboot
> > > > > +89      common  mmap2                           sys_mmap2
> > > > > +90      common  mmap                            sys_mmap
> > > > > +91      common  munmap                          sys_munmap
> > > > > +92      common  truncate                        sys_truncate                    compat_sys_truncate
> > > > > +93      common  ftruncate                       sys_ftruncate                   compat_sys_ftruncate
> > > > > +94      common  fchmod                          sys_fchmod
> > > > > +95      common  fchown                          sys_fchown
> > > > > +96      common  getpriority                     sys_getpriority
> > > > > +97      common  setpriority                     sys_setpriority
> > > > > +98      common  recv                            sys_recv
> > > > > +99      common  statfs                          sys_statfs                      compat_sys_statfs
> > > > > +100     common  fstatfs                         sys_fstatfs                     compat_sys_fstatfs
> > > > > +101     common  stat64                          sys_stat64
> > >
> > > It is probably worth adding a comment here that syscall 102 was
> > > socketcall, in order to make reason for this jump in syscall numeration
> > > self-evident.
> >
> > +1
> >
> > In general, I'd argue we want to keep all the nontrivial comments that
> > were present in either unistd.h or syscall_table.S.
>
> unistd_32.h, unistd_64.h, syscall_table_32.h, syscall_table_64.h and
> syscall_table_c32.h
> are generated files. unistd.h and syscall_table.S file include
> generated files. I had the
> support to keep the comments in the generated files.
>
> Eg:- from github
> https://github.com/frzkhn/system_call_table_generator/blob/5fe5fb5a3ad457b234e7600d8a4b61b2e3629acd/ia64/syscall.tbl#L105
>
> But I got to know the generated file don't carry any license info and
> comment section. That's
> why I removed it from all architecture.
>
> I'm ok to keep this support for all architecture. Please feel free to
> comment here.

I meant just have the comments in the .tbl file, but not act on them.
One way to do this would be to let the script ignore everything
past the first '#' character in a line by passing it through 'sed -e "s:#.*$::"'
or a similar step (there is probably a nicer way to do this with
shell built-ins).

> > I think this makes more sense, in particular on the other architectures
> > that have different macro names in some cases. When we do this,
> > the entries could get compressed to
> >
> > 108     32      pread64                         parisc_pread64
> > 108     64      pread64                         sys_pread64
> >
>
> Sure. I can do this thing. The above one may be applicable for parisc not other
> architecture. So the scripts might be slightly different. If we keep a
> standard way,
> the script will be unique. So the only difference will be Makefile and
> .tbl files for all
> architecture; I think that is our one of the goal.

I would expect the above to actually be more important on other
architectures. E.g. on powerpc:

291     32    fstatat64        sys_fstatat64      sys_fstatat64
291     64    newfstatat     newfstatat

or (simplified)

291     32    fstatat64        sys_fstatat64
291     64    newfstatat     newfstatat

makes much more sense than

291     32    fstatat64        sys_fstatat64
291     64    newfstatat     newfstatat           sys_fstatat64

        Arnd
