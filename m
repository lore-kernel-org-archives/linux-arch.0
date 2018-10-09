From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v3 3/6] parisc: add system call table generation support
Date: Tue, 9 Oct 2018 11:05:36 +0530
Message-ID: <CALxhOniJZGNCP+Xw_9EF8hnUEG_AWwrnQ86Gbh7vAW6SrE8ykQ@mail.gmail.com>
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-4-git-send-email-firoz.khan@linaro.org> <CALxhOnj4r_MUuAa2zvkvxvhQttEvCZ98n2dA9d6CYyvVf2rB3g@mail.gmail.com>
 <20181008130301.GM32759@asgard.redhat.com> <CAK8P3a0eoCVBVOZs0VwybAnUw0OUoW4Z=NJYi8686EHKj076_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a0eoCVBVOZs0VwybAnUw0OUoW4Z=NJYi8686EHKj076_Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: esyr@redhat.com, linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Eugene, Arnd,

On Mon, 8 Oct 2018 at 19:27, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Oct 8, 2018 at 3:02 PM Eugene Syromiatnikov <esyr@redhat.com> wrote:
> > > On Mon, 8 Oct 2018 at 10:47, Firoz Khan <firoz.khan@linaro.org> wrote:
> > > > diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> >
> > > > +84      common  lstat                           sys_newlstat                    compat_sys_newlstat
> > > > +85      common  readlink                        sys_readlink
> > > > +86      common  uselib                          sys_ni_syscall
> >
> > Why uselib is declared, contrary to all the skipped syscalls below,
> > that were sys_ni_syscall previously? Only __NR_socketcall was explicitly
> > undefined in arch/parisc/include/uapi/asm/unistd.h.
>
> Good catch, I didn't see that in my earlier review. I agree we want the
> files to be identical to the version they replace, so the macros need to
> be there for now.
>
> We may later decide to clean this up and remove all __NR_* that have
> no entry point, but the conversion to the new table format needs to
> otherwise be a nop.
>
> > > > +87      common  swapon                          sys_swapon
> > > > +88      common  reboot                          sys_reboot
> > > > +89      common  mmap2                           sys_mmap2
> > > > +90      common  mmap                            sys_mmap
> > > > +91      common  munmap                          sys_munmap
> > > > +92      common  truncate                        sys_truncate                    compat_sys_truncate
> > > > +93      common  ftruncate                       sys_ftruncate                   compat_sys_ftruncate
> > > > +94      common  fchmod                          sys_fchmod
> > > > +95      common  fchown                          sys_fchown
> > > > +96      common  getpriority                     sys_getpriority
> > > > +97      common  setpriority                     sys_setpriority
> > > > +98      common  recv                            sys_recv
> > > > +99      common  statfs                          sys_statfs                      compat_sys_statfs
> > > > +100     common  fstatfs                         sys_fstatfs                     compat_sys_fstatfs
> > > > +101     common  stat64                          sys_stat64
> >
> > It is probably worth adding a comment here that syscall 102 was
> > socketcall, in order to make reason for this jump in syscall numeration
> > self-evident.
>
> +1
>
> In general, I'd argue we want to keep all the nontrivial comments that
> were present in either unistd.h or syscall_table.S.

unistd_32.h, unistd_64.h, syscall_table_32.h, syscall_table_64.h and
syscall_table_c32.h
are generated files. unistd.h and syscall_table.S file include
generated files. I had the
support to keep the comments in the generated files.

Eg:- from github
https://github.com/frzkhn/system_call_table_generator/blob/5fe5fb5a3ad457b234e7600d8a4b61b2e3629acd/ia64/syscall.tbl#L105

But I got to know the generated file don't carry any license info and
comment section. That's
why I removed it from all architecture.

I'm ok to keep this support for all architecture. Please feel free to
comment here.

>
> > > > +103     common  syslog                          sys_syslog
> > > > +104     common  setitimer                       sys_setitimer                   compat_sys_setitimer
> > > > +105     common  getitimer                       sys_getitimer                   compat_sys_getitimer
> > > > +106     common  capget                          sys_capget
> > > > +107     common  capset                          sys_capset
> >
> > > > +108     32      pread64                         parisc_pread64
> > > > +108     64      pread64                         sys_pread64                     parisc_pread64
> >
> > It would be probably nice to have some syntax that would allow avoid
> > this duplication (as compat handler on 64 bit and native on 32 bit are
> > the same).
>
> I think I would prefer to have the compat table be generated with the '32'
> abi rather than the '64' abi, so we end up with
>
> 108     32      pread64                         parisc_pread64
>    parisc_pread64
> 108     64      pread64                         sys_pread64
>
> I think this makes more sense, in particular on the other architectures
> that have different macro names in some cases. When we do this,
> the entries could get compressed to
>
> 108     32      pread64                         parisc_pread64
> 108     64      pread64                         sys_pread64
>

Sure. I can do this thing. The above one may be applicable for parisc not other
architecture. So the scripts might be slightly different. If we keep a
standard way,
the script will be unique. So the only difference will be Makefile and
.tbl files for all
architecture; I think that is our one of the goal.

> > > > +348     common  pwritev2                        sys_pwritev2                    compat_sys_pwritev2
> > > > +349     common  statx                           sys_statx
> > > > +350    common  io_pgetevents                   sys_io_pgetevents               compat_sys_io_pgetevents
> > > > \ No newline at end of file
>
> As others have commented several times, Firoz still needs to fix
> the missing newline.

Sure. I was wondering why the checkpatch script is not catching this one.
Where ever I came across I fixed it.

Thanks
Firoz

>
> Firoz, please fix all the newlines before you repost any further
> patches.
>
>       Arnd
