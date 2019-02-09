Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38032 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfBIAEE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Feb 2019 19:04:04 -0500
Received: by mail-lf1-f66.google.com with SMTP id j15so3826791lfh.5
        for <linux-arch@vger.kernel.org>; Fri, 08 Feb 2019 16:04:03 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id e132sm737684lfg.22.2019.02.08.16.04.00
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:04:00 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id l142so3851122lfe.2
        for <linux-arch@vger.kernel.org>; Fri, 08 Feb 2019 16:04:00 -0800 (PST)
MIME-Version: 1.0
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <CAHk-=wjfyrFBjifzmgMVrkrvEePEPaBTDq7D=f2i5kD2E=SqRQ@mail.gmail.com> <d7476dfb-1653-747b-b865-5597ba5fc1c1@redhat.com>
In-Reply-To: <d7476dfb-1653-747b-b865-5597ba5fc1c1@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 8 Feb 2019 16:03:43 -0800
Message-ID: <CAHk-=whzAGRJQE43NHaC8sCECLr-QnpHYst+TJq-qhfp9eK-Qw@mail.gmail.com>
Subject: Re: [PATCH-tip 00/22] locking/rwsem: Rework rwsem-xadd & enable new
 rwsem features
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Davidlohr Bueso <dave@stgolabs.net>, Andrew Morton <akpm@linux-foundation.org>, Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <20190209000343.pp8NOJtpEfXn1TAV0-I7MEipADnN5Jx5G7UN31nLBDw@z>

On Fri, Feb 8, 2019 at 12:31 PM Waiman Long <longman@redhat.com> wrote:
>
> >  (b) what's the new fastpath case
>
> The only change in the fastpath is the use of cmpxchg for writer lock.

.. since a big deal here was about using the generic atomic accessor
functions, I really was looking forward to seeing the *actual* fast
path code generation.

In other words, right now I have very little visibility in how it
actually affects the code. Looking at the patches themselves doesn't
make it obvious. I was hoping for the overview to really explain the
whole "before and after" situation, and it didn't. Not at the high
level, and not at a low level. And no performance numbers in the
overview either.

And yes, I see the numbers in the patches, but what I really hoped for
was some real load numbers. In particular, I would have loved to see
numbers from th ekernel test robot "will-it-scale.per_thread_ops"
case, which is the one that had a 65% regression due to the lack of
reader spinning.

So I was kind of hoping to hear whether that regression is basically
entirely gone with this patch series, or if we still have a regression
due to the extra downgrade, or what?

                 Linus
