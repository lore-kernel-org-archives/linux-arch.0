Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35772 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeJQW6z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Oct 2018 18:58:55 -0400
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <d83762614122402ba4b55524e35b418c9f6baf53.1539655731.git.ren_guo@c-sky.com>
In-Reply-To: <d83762614122402ba4b55524e35b418c9f6baf53.1539655731.git.ren_guo@c-sky.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 Oct 2018 17:02:33 +0200
Message-ID: <CAK8P3a3bNST+ZuPjLG0_sHjC=Ac0ir1omhHvMn9tz4zs+Kg9yw@mail.gmail.com>
Subject: Re: [PATCH V9 05/21] csky: System Call
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, gregkh <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Message-ID: <20181017150233.g_npmzfKXrwxb9S-CvXBsAeI82QYM4oBb8z9bVQ_FBY@z>

On Tue, Oct 16, 2018 at 5:01 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This patch adds files related to syscall.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I had a detailed look at this one and provided lots of comments, however
one tiny thing escaped me:

> +#define __NR_set_thread_area   (__NR_arch_specific_syscall + 0)
> +__SYSCALL(__NR_set_thread_area, sys_set_thread_area)
> +#define __NR_cacheflush                (__NR_arch_specific_syscall + 4)
> +__SYSCALL(__NR_cacheflush, sys_cacheflush)

It's odd that the second one uses __NR_arch_specific_syscall + 4 rather
than +1. If you can still change that changing too much other stuff,
that might avoid some head-scratching later. If it causes problems,
just leave it and maybe add a comment saying that the numbers
inbetween are still available.

      Arnd
