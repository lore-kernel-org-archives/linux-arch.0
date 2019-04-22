Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f178.google.com ([209.85.208.178]:39997 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbfDVQ2V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Apr 2019 12:28:21 -0400
Received: by mail-lj1-f178.google.com with SMTP id q66so10792763ljq.7
        for <linux-arch@vger.kernel.org>; Mon, 22 Apr 2019 09:28:19 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id v13sm2771014lje.84.2019.04.22.09.28.14
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 09:28:15 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id t30so9381281lfd.8
        for <linux-arch@vger.kernel.org>; Mon, 22 Apr 2019 09:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000043fe9c058720a5d3@google.com> <ad884b18-0e03-d6be-02b0-4e5273f068ce@kernel.dk>
In-Reply-To: <ad884b18-0e03-d6be-02b0-4e5273f068ce@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 22 Apr 2019 09:27:58 -0700
Message-ID: <CAHk-=wgG=RqK8T5kWiZfH7da6rBuqp3kAesP=ETgceb6RzvZng@mail.gmail.com>
Subject: Re: WARNING in percpu_ref_kill_and_confirm
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: syzbot <syzbot+10d25e23199614b7721f@syzkaller.appspotmail.com>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, "Darrick J. Wong" <darrick.wong@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Anvin <hpa@zytor.com>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Andrew Lutomirski <luto@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Thomas Gleixner <tglx@linutronix.de>, Al Viro <viro@zeniv.linux.org.uk>, the arch/x86 maintainers <x86@kernel.org>
Message-ID: <20190422162758.I7teUUkK6jXC9Zob0R0OU4OFT5UlhGGMgp_4YktFTWU@z>

[ Crossed emails ]

On Mon, Apr 22, 2019 at 9:23 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> I think the below should fix this. Very early versions of io_uring didn't
> have this issue, since we did the percpu ref tryget for io_uring_register().

Ok, so I like your patch better than mine, but note how syzbot
bisected this to the initial merge of the io_uring code.

I agree that code shouldn't have had this particular issue, but it
looks like it does.

Is there some way to race with io_ring_ctx_wait_and_kill(), which
_also_ does that ref_kill() thing? I'm not seeing how that could
happen, but maybe if the file ref counts get screwed up you have
->release() called early..

                  Linus
