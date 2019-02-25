From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 08/20] m68k: io: Remove useless definition of mmiowb()
Date: Mon, 25 Feb 2019 10:25:52 +0100
Message-ID: <CAMuHMdXq5N1e+=dTPUu+AtSgh4QzuDzmhBowG_HFoVHwmndvkg@mail.gmail.com>
References: <20190222185026.10973-1-will.deacon@arm.com> <20190222185026.10973-9-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190222185026.10973-9-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@i>
List-Id: linux-arch.vger.kernel.org

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
