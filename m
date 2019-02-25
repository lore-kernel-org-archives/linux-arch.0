Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42977 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfBYJ0F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Feb 2019 04:26:05 -0500
MIME-Version: 1.0
References: <20190222185026.10973-1-will.deacon@arm.com> <20190222185026.10973-9-will.deacon@arm.com>
In-Reply-To: <20190222185026.10973-9-will.deacon@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 25 Feb 2019 10:25:52 +0100
Message-ID: <CAMuHMdXq5N1e+=dTPUu+AtSgh4QzuDzmhBowG_HFoVHwmndvkg@mail.gmail.com>
Subject: Re: [RFC PATCH 08/20] m68k: io: Remove useless definition of mmiowb()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Linux/m68k <linux-m68k@vger.kernel.org>
Message-ID: <20190225092552.Nj8r1-9mtE40pNZ_TtuFbSyjQxzUUcu7v9D8rhJYEZ8@z>

Hi Will,

On Fri, Feb 22, 2019 at 7:51 PM Will Deacon <will.deacon@arm.com> wrote:
> m68k includes asm-generic/io.h, which provides a dummy definition of
> mmiowb() if one isn't already provided by the architecture.
>
> Remove the useless definition.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Thanks!
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Do you want me to queue this in the m68k tree for v5.2, or would
you prefer to apply the whole series?
In case of the latter:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
