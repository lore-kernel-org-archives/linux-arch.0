Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39509 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406214AbfBNSKF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Feb 2019 13:10:05 -0500
Received: by mail-lj1-f195.google.com with SMTP id g80so6065784ljg.6
        for <linux-arch@vger.kernel.org>; Thu, 14 Feb 2019 10:10:04 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id z14sm607871lfj.21.2019.02.14.10.10.00
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 10:10:01 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id s5-v6so6039331ljd.12
        for <linux-arch@vger.kernel.org>; Thu, 14 Feb 2019 10:10:00 -0800 (PST)
MIME-Version: 1.0
References: <1550089932-6888-1-git-send-email-longman@redhat.com>
 <1550089932-6888-3-git-send-email-longman@redhat.com> <20190214103333.GH32494@hirez.programming.kicks-ass.net>
 <9e01d4ef-56df-7af8-a0f5-b49644e298bf@redhat.com> <CAHk-=whKmuranma_HUOKBbDJHGmdWZr9MYW-+cmGzsOiJ2N1Sg@mail.gmail.com>
In-Reply-To: <CAHk-=whKmuranma_HUOKBbDJHGmdWZr9MYW-+cmGzsOiJ2N1Sg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Feb 2019 10:09:44 -0800
Message-ID: <CAHk-=wi03J1jurebJNHPxGCVss7ARAN+2JuVthEGoEx=qkT4dQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] locking/rwsem: Optimize down_read_trylock()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Davidlohr Bueso <dave@stgolabs.net>, Andrew Morton <akpm@linux-foundation.org>, Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <20190214180944.96OBtTJuuOmjZ7wTN6bUFj1QPjZ3Q8t4VKB6QziXjbU@z>

On Thu, Feb 14, 2019 at 9:51 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The arm64 numbers scaled horribly even before, and that's because
> there is too much ping-pong, and it's probably because there is no
> "stickiness" to the cacheline to the core, and thus adding the extra
> loop can make the ping-pong issue even worse because now there is more
> of it.

Actually, if it's using the ll/sc, then I don't see why arm64 should
even change. It doesn't really even change the pattern: the initial
load of the value is just replaced with a "ll" that gets a non-zero
value, and then we re-try without even doing the "sc" part.

End result: exact same "load once, then do ll/sc to update". Just
using a slightly different instruction pattern.

But maybe "ll" does something different to the cacheline than a regular "ld"?

Alternatively, the machine you used is using LSE, and the "swp" thing
has some horrid behavior when it fails.

So I take it back. I'm actually surprised that arm64 performs worse. I
don't think it should. But numbers walk, bullshit talks, and it
clearly does make for worse numbers on arm64.

               Linus
