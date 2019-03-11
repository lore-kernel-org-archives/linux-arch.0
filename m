Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35476 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbfCKVnM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Mar 2019 17:43:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id g19so586463edp.2
        for <linux-arch@vger.kernel.org>; Mon, 11 Mar 2019 14:43:11 -0700 (PDT)
Date: Mon, 11 Mar 2019 22:43:08 +0100
From: Christian Brauner <christian@brauner.io>
Subject: Re: New syscalls (was: Re: linux-next: manual merge of the pidfd
 tree with the y2038 tree (now block and tip trees))
Message-ID: <20190311214307.domy6azaoi4ggtiu@brauner.io>
References: <20190122141027.70cd9166@canb.auug.org.au>
 <20190213162212.500a7cd5@canb.auug.org.au>
 <CAK8P3a1hw03ik+tZSG8PnP7Rd=Pzwbo7n59HLJW04ncndyqzsg@mail.gmail.com>
 <CAMuHMdUmPBeQ=jcDufVBDEGiO1Yk4bWWBSg488Jm_wwAuySHBQ@mail.gmail.com>
 <CAK8P3a1zHm-WjYjEA65PomrKe7+5Sd110KbXv13=wiMVpxyuaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a1zHm-WjYjEA65PomrKe7+5Sd110KbXv13=wiMVpxyuaQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20190311214308.45nXt26wPgP-wEk68ItNYib1cZtwXRASpU9l7RLM_K8@z>

On Mon, Mar 11, 2019 at 10:38:07PM +0100, Arnd Bergmann wrote:
> On Mon, Mar 11, 2019 at 9:36 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, Feb 13, 2019 at 3:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Wed, Feb 13, 2019 at 6:22 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > > On Tue, 22 Jan 2019 14:10:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > > > Today's linux-next merge of the pidfd tree got conflicts in:
> > > > >
> > > > >   arch/x86/entry/syscalls/syscall_32.tbl
> > > > >   arch/x86/entry/syscalls/syscall_64.tbl
> > > > >   include/uapi/asm-generic/unistd.h
> > > > >
> > > > > between commits:
> > > > >
> > > > >   63a96220ad45 ("arch: add split IPC system calls where needed")
> > > > >   0bd4bb9c5612 ("y2038: add 64-bit time_t syscalls to all 32-bit architectures")
> > > > >
> > > > > from the y2038 tree and commit:
> > > > >
> > > > >   3d2991bc7a67 ("signal: add pidfd_send_signal() syscall")
> > > > >
> > > > > from the pidfd tree.
> > > >
> > > > This is now a conflict between the block, tip and pidfd trees.  The
> > > > resolution now looks like below.
> > >
> > > Checked it again, still looks good. Thanks,
> >
> > What's the plan with adding new syscalls to all architectures?
> >
> >   + <stdin>: warning: #warning syscall io_uring_enter not implemented
> > [-Wcpp]:  => 1481:2
> >   + <stdin>: warning: #warning syscall io_uring_register not
> > implemented [-Wcpp]:  => 1484:2
> >   + <stdin>: warning: #warning syscall io_uring_setup not implemented
> > [-Wcpp]:  => 1478:2
> >
> > and more seem to be planned for this merge window.
> >
> > Shall each architcture maintainer take care of this hxxself, or will
> > this be done in
> > a coordinated way?
> 
> I was planning to send a patch for all architectures this time
> (after all three sets are merged, which is now), and ask future

Just to clarify, are you referring to your sets? I think Linus hasn't
gotten around to reviewing the PR for pidfd_send_signal() yet. :)

Christian

> submitters to do it themselves when first adding a new system
> call.
> 
>        Arnd
