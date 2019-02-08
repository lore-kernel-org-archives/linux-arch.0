Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44830 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfBHT6N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Feb 2019 14:58:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so3978447lji.11
        for <linux-arch@vger.kernel.org>; Fri, 08 Feb 2019 11:58:12 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id l7-v6sm553884ljb.76.2019.02.08.11.58.10
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 11:58:10 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id f5so3395867lfc.13
        for <linux-arch@vger.kernel.org>; Fri, 08 Feb 2019 11:58:10 -0800 (PST)
MIME-Version: 1.0
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
In-Reply-To: <1549566446-27967-1-git-send-email-longman@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 8 Feb 2019 11:50:40 -0800
Message-ID: <CAHk-=wjfyrFBjifzmgMVrkrvEePEPaBTDq7D=f2i5kD2E=SqRQ@mail.gmail.com>
Subject: Re: [PATCH-tip 00/22] locking/rwsem: Rework rwsem-xadd & enable new
 rwsem features
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Davidlohr Bueso <dave@stgolabs.net>, Andrew Morton <akpm@linux-foundation.org>, Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <20190208195040.0ymtJPkqYwkeczy_CMixpDN8rOdLalpzwTjBxH4-95c@z>

On Thu, Feb 7, 2019 at 11:08 AM Waiman Long <longman@redhat.com> wrote:
>
> This patchset revamps the current rwsem-xadd implementation to make
> it saner and easier to work with. This patchset removes all the
> architecture specific assembly code and uses generic C code for all
> architectures. This eases maintenance and enables us to enhance the
> code more easily.
>
> This patchset also implements the following 3 new features:
>
>  1) Waiter lock handoff
>  2) Reader optimistic spinning
>  3) Store write-lock owner in the atomic count (x86-64 only)

The patches are kind of hard to read, with most of them just doing
prep-work that doesn't necessarily matter to the big picture.

What I'd really like to see is

 (a) an overview of the new locking logic

 (b) what's the new fastpath case

 (c) some performance numbers

to explain the changes from a "this is the point of the whole
exercise" standpoint.

And yes, I realize that the lock handoff and optimistic spinning is a
big deal, since I've seen the same regression numbers that presumably
caused this effort to be resurrected. So it's not that I don't find
this intriguing and worthwhile, it's literally that I'd like a summary
not so much of the individual patches, but of the new model.

Please?

             Linus
