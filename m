From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: New syscalls (was: Re: linux-next: manual merge of the pidfd tree
 with the y2038 tree (now block and tip trees))
Date: Mon, 11 Mar 2019 22:38:07 +0100
Message-ID: <CAK8P3a1zHm-WjYjEA65PomrKe7+5Sd110KbXv13=wiMVpxyuaQ@mail.gmail.com>
References: <20190122141027.70cd9166@canb.auug.org.au> <20190213162212.500a7cd5@canb.auug.org.au>
 <CAK8P3a1hw03ik+tZSG8PnP7Rd=Pzwbo7n59HLJW04ncndyqzsg@mail.gmail.com> <CAMuHMdUmPBeQ=jcDufVBDEGiO1Yk4bWWBSg488Jm_wwAuySHBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUmPBeQ=jcDufVBDEGiO1Yk4bWWBSg488Jm_wwAuySHBQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Christian Brauner <christian@brauner.io>, Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 11, 2019 at 9:36 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Feb 13, 2019 at 3:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wed, Feb 13, 2019 at 6:22 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > On Tue, 22 Jan 2019 14:10:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > > Today's linux-next merge of the pidfd tree got conflicts in:
> > > >
> > > >   arch/x86/entry/syscalls/syscall_32.tbl
> > > >   arch/x86/entry/syscalls/syscall_64.tbl
> > > >   include/uapi/asm-generic/unistd.h
> > > >
> > > > between commits:
> > > >
> > > >   63a96220ad45 ("arch: add split IPC system calls where needed")
> > > >   0bd4bb9c5612 ("y2038: add 64-bit time_t syscalls to all 32-bit architectures")
> > > >
> > > > from the y2038 tree and commit:
> > > >
> > > >   3d2991bc7a67 ("signal: add pidfd_send_signal() syscall")
> > > >
> > > > from the pidfd tree.
> > >
> > > This is now a conflict between the block, tip and pidfd trees.  The
> > > resolution now looks like below.
> >
> > Checked it again, still looks good. Thanks,
>
> What's the plan with adding new syscalls to all architectures?
>
>   + <stdin>: warning: #warning syscall io_uring_enter not implemented
> [-Wcpp]:  => 1481:2
>   + <stdin>: warning: #warning syscall io_uring_register not
> implemented [-Wcpp]:  => 1484:2
>   + <stdin>: warning: #warning syscall io_uring_setup not implemented
> [-Wcpp]:  => 1478:2
>
> and more seem to be planned for this merge window.
>
> Shall each architcture maintainer take care of this hxxself, or will
> this be done in
> a coordinated way?

I was planning to send a patch for all architectures this time
(after all three sets are merged, which is now), and ask future
submitters to do it themselves when first adding a new system
call.

       Arnd
