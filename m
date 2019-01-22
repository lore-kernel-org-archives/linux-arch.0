From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: linux-next: manual merge of the pidfd tree with the y2038 tree
Date: Tue, 22 Jan 2019 10:26:56 +0100
Message-ID: <CAK8P3a0ej9NcJM8wXNPbcGUyOUZYX+VLoDFdbenW3s3114oQZw@mail.gmail.com>
References: <20190121143951.68956db3@canb.auug.org.au> <CAK8P3a0Yth+f8AANE6g8c_zE0Zt1CvCdzMDFK=pr8eNqmrBV0Q@mail.gmail.com>
 <20190121191306.ifga5aw5atu2vvb7@brauner.io> <CAK8P3a2CkXJ=giXQgxEcQAeH1Wt8jKc_P+YTOLJpUPVKYU8m9g@mail.gmail.com>
 <20190121202328.rgrv54lybilsvitu@brauner.io> <da262bd9-1de0-eabb-ee44-e0ee152d15bb@kernel.dk>
 <20190121224811.gbvg22vg4kgg4kbs@brauner.io>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121224811.gbvg22vg4kgg4kbs@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Brauner <christian@brauner.io>
Cc: Jens Axboe <axboe@kernel.dk>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 21, 2019 at 11:48 PM Christian Brauner <christian@brauner.io> wrote:
>
> On Mon, Jan 21, 2019 at 03:44:17PM -0700, Jens Axboe wrote:
> > On 1/21/19 1:23 PM, Christian Brauner wrote:
> > > On Mon, Jan 21, 2019 at 09:15:27PM +0100, Arnd Bergmann wrote:
> > >> On Mon, Jan 21, 2019 at 8:13 PM Christian Brauner <christian@brauner.io> wrote:
> > >>> On Mon, Jan 21, 2019 at 06:16:22PM +0100, Arnd Bergmann wrote:
> > >>>> On Mon, Jan 21, 2019 at 4:40 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >>>
> > >>> I plan on sending the pidfd branch with the new pidfd_send_signal()
> > >>> syscall for the 5.1 window. Should we somehow coordinate so that our
> > >>> branches don't conflict? Any suggestions?
> > >>
> > >> A conflict can't be avoided, but if you pick system call number 427
> > >> for pidfd_send_signal, and Jens picks numbers 424 through 426 for
> > >
> > > That sounds good to me. Since it's only one syscall for the pidfd branch
> > > is there anything that speaks against me using 424? Given that the other
> > > patchset has 4 new syscalls. :)
> > > Jens, any objections?
> >
> > I'm fine with either one, I'll have to renumber in any case. But it's 3
> > new syscalls (424, 425, 426), not 4.
> >
> > Arnd, what's the best way to make this switch now, in my tree? Would be
>
> Yeah, I'd like to know that as well.
>
> > great if I didn't have to change it again once I make the change.

I'd suggest that you each just take the numbers we talked about and
add them in your respective git trees, at the end of the current tables.

Stephen and Linus can then do a trivial add/add merge between the
three trees that does not involve changing any of the lines besides
keeping them in the right order. The result should then be

== arch/x86/entry/syscalls/syscall_32.tbl
422    i386    futex_time64        sys_futex            __ia32_sys_futex
423    i386    sched_rr_get_interval_time64
sys_sched_rr_get_interval    __ia32_sys_sched_rr_get_interval
424    i386    pidfd_send_signal     sys_pidfd_send_signal
__ia32_sys_pidfd_send_signal
425    i386    io_uring_setup          sys_io_uring_setup
__ia32_compat_sys_io_uring_setup
426    i386    io_uring_enter          sys_io_uring_enter
 __ia32_sys_io_uring_enter
427    i386    io_uring_register       sys_io_uring_register
__ia32_sys_io_uring_register

== arch/x86/entry/syscalls/syscall_64.tbl
...
334    common  rseq                    __x64_sys_rseq
# don't use numbers 387 through 423, add new calls after the last
# 'common' entry
424    common    pidfd_send_signal      __x64_sys_pidfd_send_signal
425    common    io_uring_setup           __x64_sys_io_uring_setup
426    common    io_uring_enter           __x64_sys_io_uring_enter
427    common    io_uring_register        __x64_sys_io_uring_register
#
# x32-specific system call numbers start at 512 to avoid cache impact
# for native 64-bit operation. The __x32_compat_sys stubs are created
# on-the-fly for compat_sys_*() compatibility system calls if X86_X32
# is defined.
#
512     x32     rt_sigaction            __x32_compat_sys_rt_sigaction
...

My hope is that in the future, any new system call will get added to
all 16 syscall.tbl files at once, but let's maybe not do this for 5.1
yet, since that only causes more conflicts. I can simply follow up
with a patch to add pidfd_send_signal and io_uring_* everywhere
during the merge window.

      Arnd
