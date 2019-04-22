Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41695 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfDVQYO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Apr 2019 12:24:14 -0400
Received: by mail-lf1-f66.google.com with SMTP id t30so9371646lfd.8
        for <linux-arch@vger.kernel.org>; Mon, 22 Apr 2019 09:24:13 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id s16sm2715700lji.61.2019.04.22.09.24.10
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 09:24:10 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id h16so10762994ljg.11
        for <linux-arch@vger.kernel.org>; Mon, 22 Apr 2019 09:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000043fe9c058720a5d3@google.com>
In-Reply-To: <00000000000043fe9c058720a5d3@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 22 Apr 2019 09:23:53 -0700
Message-ID: <CAHk-=wgC5mNgPN5excXyTNtFpOyF4+9jk3tLiC+s-VezgGbVTA@mail.gmail.com>
Subject: Re: WARNING in percpu_ref_kill_and_confirm
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: syzbot <syzbot+10d25e23199614b7721f@syzkaller.appspotmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>, Borislav Petkov <bp@alien8.de>, "Darrick J. Wong" <darrick.wong@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Anvin <hpa@zytor.com>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Andrew Lutomirski <luto@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Thomas Gleixner <tglx@linutronix.de>, Al Viro <viro@zeniv.linux.org.uk>, the arch/x86 maintainers <x86@kernel.org>
Message-ID: <20190422162353._npDYt3nrPKSN1RpRBSoHPJGoFuFsbUVY2mXjzu8NVQ@z>

On Mon, Apr 22, 2019 at 9:06 AM syzbot
<syzbot+10d25e23199614b7721f@syzkaller.appspotmail.com> wrote:
>
>
> The bug was bisected to:
>
> commit 38e7571c07be01f9f19b355a9306a4e3d5cb0f5b
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Fri Mar 8 22:48:40 2019 +0000
>
>      Merge tag 'io_uring-2019-03-06' of git://git.kernel.dk/linux-block
>
> percpu_ref_kill_and_confirm called more than once on io_ring_ctx_ref_free!

So I don't see how that happens in the original code (because
__io_uring_register() is called with the uring_lock held), but let's
see.

HOWEVER.

I do see how it happens now as of the latest kernel as of commit
b19062a56726 ("io_uring: fix possible deadlock between
io_uring_{enter,register}") where the code explicitly drops the mutex
in order to wait for other uring users to finish.

So Jens, I think that commit was buggy. I suspect that
io_uring_register() should perhaps do something like

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2934,7 +2934,10 @@ static int __io_uring_register(struct
io_ring_ctx *ctx, unsigned opcode,
 {
        int ret;

+       if (!percpu_ref_tryget(&ctx->refs))
+               return -EBUSY;
        percpu_ref_kill(&ctx->refs);
+       percpu_ref_put(&ctx->refs);

        /*
         * Drop uring mutex before waiting for references to exit. If another

to guarantee that it's the *only* case of io_uring_register() doing that kill.

Hmm?

                Linus
