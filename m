Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:36837 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbcFPKI3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jun 2016 06:08:29 -0400
MIME-Version: 1.0
In-Reply-To: <20160531102642.333689893@infradead.org>
References: <20160531101925.702692792@infradead.org> <20160531102642.333689893@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Jun 2016 12:08:27 +0200
Message-ID: <CAMuHMdXG4veEOqr5vcZQEQH55=CT6CPXOfqrc_m=fpXEseAdLA@mail.gmail.com>
Subject: Re: [PATCH -v2 14/33] locking,m68k: Implement atomic_fetch_{add,sub,and,or,xor}()
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, boqun.feng@gmail.com, waiman.long@hpe.com, =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@arm.linux.org.uk>, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, Miao Steven <realmz6@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, cmetcalf@mellanox.com, Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, dbueso@suse.de, Wu Fengguang <fengguang.wu@intel.com>, linux-m68k <linux-m68k@lists.linux-m68k.org>
Message-ID: <20160616100827.Unn1t3o0mpB9b6n0YBBrLK6DdSBuyiCfrlU3M2MkyMU@z>

Hi Peter,

On Tue, May 31, 2016 at 12:19 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> Implement FETCH-OP atomic primitives, these are very similar to the
> existing OP-RETURN primitives we already have, except they return the
> value of the atomic variable _before_ modification.
>
> This is especially useful for irreversible operations -- such as
> bitops (because it becomes impossible to reconstruct the state prior
> to modification).
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/m68k/include/asm/atomic.h |   53 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 49 insertions(+), 4 deletions(-)
>
> --- a/arch/m68k/include/asm/atomic.h
> +++ b/arch/m68k/include/asm/atomic.h
> @@ -38,6 +38,13 @@ static inline void atomic_##op(int i, at
>
>  #ifdef CONFIG_RMW_INSNS
>
> +/*
> + * Am I reading these CAS loops right in that %2 is the old value and the first
> + * iteration uses an uninitialized value?
> + *
> + * Would it not make sense to add: tmp = atomic_read(v); to avoid this?
> + */
> +
>  #define ATOMIC_OP_RETURN(op, c_op, asm_op)                             \
>  static inline int atomic_##op##_return(int i, atomic_t *v)             \
>  {                                                                      \

Do we want the above comment in the code?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
