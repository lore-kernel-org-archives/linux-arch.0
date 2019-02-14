Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34710 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730972AbfBNRvn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Feb 2019 12:51:43 -0500
Received: by mail-lj1-f193.google.com with SMTP id l5so2610467lje.1
        for <linux-arch@vger.kernel.org>; Thu, 14 Feb 2019 09:51:42 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id a3-v6sm560086ljd.20.2019.02.14.09.51.38
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 09:51:38 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id l10so5179502lfh.9
        for <linux-arch@vger.kernel.org>; Thu, 14 Feb 2019 09:51:38 -0800 (PST)
MIME-Version: 1.0
References: <1550089932-6888-1-git-send-email-longman@redhat.com>
 <1550089932-6888-3-git-send-email-longman@redhat.com> <20190214103333.GH32494@hirez.programming.kicks-ass.net>
 <9e01d4ef-56df-7af8-a0f5-b49644e298bf@redhat.com>
In-Reply-To: <9e01d4ef-56df-7af8-a0f5-b49644e298bf@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Feb 2019 09:51:21 -0800
Message-ID: <CAHk-=whKmuranma_HUOKBbDJHGmdWZr9MYW-+cmGzsOiJ2N1Sg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] locking/rwsem: Optimize down_read_trylock()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Davidlohr Bueso <dave@stgolabs.net>, Andrew Morton <akpm@linux-foundation.org>, Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <20190214175121.N2nQClkbNYeSUMFJdn79ltljl4u3dTrW7wikNSGzJaY@z>

On Thu, Feb 14, 2019 at 6:53 AM Waiman Long <longman@redhat.com> wrote:
>
> The ARM64 result is what I would have expected given that the change was
> to optimize for the uncontended case. The x86-64 result is kind of an
> anomaly to me, but I haven't bothered to dig into that.

I would say that the ARM result is what I'd expect from something that
scales badly to begin with.

The x86-64 result is the expected one: yes, the cmpxchg is done one
extra time, but it results in fewer cache transitions (the cacheline
never goes into "shared" state), and cache transitions are what
matter.

The cost of re-doing the instruction should be low. The cacheline
ping-pong and the cache coherency messages is what hurts.

So I actually think both are very easily explained.

The x86-64 number improves, because there is less cache coherency traffic.

The arm64 numbers scaled horribly even before, and that's because
there is too much ping-pong, and it's probably because there is no
"stickiness" to the cacheline to the core, and thus adding the extra
loop can make the ping-pong issue even worse because now there is more
of it.

The cachelines not sticking at all to a core probably is good for
fairness issues (in particular, sticking *too* much can cause horrible
issues), but it's absolutely horrible if it means that you lose the
cacheline even before you get to complete the second cmpxchg.

                  Linus
