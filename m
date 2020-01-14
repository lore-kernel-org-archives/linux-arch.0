From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 4/4] ARC: uaccess: use optimized generic __strnlen_user/__strncpy_from_user
Date: Tue, 14 Jan 2020 21:42:15 +0100
Message-ID: <CAK8P3a2GUqmcA_q33=20OrK1+cU4f3mCrgci_bO3ho4B5PRODg@mail.gmail.com>
References: <20200114200846.29434-1-vgupta@synopsys.com> <20200114200846.29434-5-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:51325 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgANUmf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jan 2020 15:42:35 -0500
In-Reply-To: <20200114200846.29434-5-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Christian Brauner <christian.brauner@ubuntu.com>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, Linus Torvalds <torvalds@linux-foundation.org>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Tue, Jan 14, 2020 at 9:08 PM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:

> diff --git a/arch/arc/include/asm/word-at-a-time.h b/arch/arc/include/asm/word-at-a-time.h
> new file mode 100644
> index 000000000000..00e92be70987
> --- /dev/null
> +++ b/arch/arc/include/asm/word-at-a-time.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2020 Synopsys Inc.
> + */
> +#ifndef __ASM_ARC_WORD_AT_A_TIME_H
> +#define __ASM_ARC_WORD_AT_A_TIME_H
> +
> +#ifdef __LITTLE_ENDIAN__
> +
> +#include <linux/kernel.h>
> +
> +struct word_at_a_time {
> +       const unsigned long one_bits, high_bits;
> +};

What's wrong with the generic version on little-endian? Any
chance you can find a way to make it work as well for you as
this copy?

> +static inline unsigned long find_zero(unsigned long mask)
> +{
> +#ifdef CONFIG_64BIT
> +       return fls64(mask) >> 3;
> +#else
> +       return fls(mask) >> 3;
> +#endif

The CONFIG_64BIT check not be needed, unless you are adding
support for 64-bit ARC really soon.

       Arnd
