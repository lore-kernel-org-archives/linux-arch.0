Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:35357 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbdECPFa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 May 2017 11:05:30 -0400
MIME-Version: 1.0
In-Reply-To: <20170503145141.4966-2-ynorov@caviumnetworks.com>
References: <20170503145141.4966-1-ynorov@caviumnetworks.com> <20170503145141.4966-2-ynorov@caviumnetworks.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 3 May 2017 17:05:29 +0200
Message-ID: <CAMuHMdXks7pXcg+MNvqYyRWHf-WUrNWLrG8GcPWy8ho49Wx7ug@mail.gmail.com>
Subject: Re: [PATCH 1/3] kernel/locking: #include <asm/spinlock.h> in qrwlock.c
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Adam Wallis <awallis@codeaurora.org>, Andrew Pinski <Andrew.Pinski@cavium.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Jan Glauber <jglauber@cavium.com>, Mark Rutland <mark.rutland@arm.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Message-ID: <20170503150529.h7HbgBX91YlZky-239vq1bOFERUj6IqI_7hZg-EmGU8@z>

On Wed, May 3, 2017 at 4:51 PM, Yury Norov <ynorov@caviumnetworks.com> wrote:
> --- a/kernel/locking/qrwlock.c
> +++ b/kernel/locking/qrwlock.c
> @@ -20,6 +20,7 @@
>  #include <linux/cpumask.h>
>  #include <linux/percpu.h>
>  #include <linux/hardirq.h>
> +#include <asm/spinlock.h>

linux/spinlock.h?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
