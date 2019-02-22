Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33372 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfBVVtx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Feb 2019 16:49:53 -0500
Received: by mail-lj1-f196.google.com with SMTP id z7so2652774lji.0
        for <linux-arch@vger.kernel.org>; Fri, 22 Feb 2019 13:49:52 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id v11sm853292lfb.46.2019.02.22.13.49.49
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 13:49:49 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id t14so2826440lfk.7
        for <linux-arch@vger.kernel.org>; Fri, 22 Feb 2019 13:49:49 -0800 (PST)
MIME-Version: 1.0
References: <20190222185026.10973-1-will.deacon@arm.com> <20190222185026.10973-2-will.deacon@arm.com>
In-Reply-To: <20190222185026.10973-2-will.deacon@arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Feb 2019 13:49:32 -0800
Message-ID: <CAHk-=wgamK0=rNsCfDfDzmNXUF_MqUHb0okzqN1Tir9vm65pNg@mail.gmail.com>
Subject: Re: [RFC PATCH 01/20] asm-generic/mmiowb: Add generic implementation
 of mmiowb() tracking
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <20190222214932.enxGpjR4AybriChtVivHHNxTHhGnh9VQ-uk1rz8SjII@z>

I love removing mmiowb(), but..

On Fri, Feb 22, 2019 at 10:50 AM Will Deacon <will.deacon@arm.com> wrote:
>
> +#ifndef mmiowb_set_pending
> +static inline void mmiowb_set_pending(void)
> +{
> +       __this_cpu_write(__mmiowb_state.mmiowb_pending, 1);
> +}
> +#endif
> +
> +#ifndef mmiowb_spin_lock
> +static inline void mmiowb_spin_lock(void)
> +{
> +       if (__this_cpu_inc_return(__mmiowb_state.nesting_count) == 1)
> +               __this_cpu_write(__mmiowb_state.mmiowb_pending, 0);
> +}
> +#endif

The case we want to go fast is the spin-lock and unlock case, not the
"set pending" case.

And the way you implemented this, it's exactly the wrong way around.

So I'd suggest instead doing

  static inline void mmiowb_set_pending(void)
  {
      __this_cpu_write(__mmiowb_state.mmiowb_pending,
__mmiowb_state.nesting_count);
  }

and

  static inline void mmiowb_spin_lock(void)
  {
      __this_cpu_inc(__mmiowb_state.nesting_count);
  }

which makes that spin-lock code much simpler and avoids the conditional there.

Then the unlock case could be something like

  static inline void mmiowb_spin_unlock(void)
  {
      if (unlikely(__this_cpu_read(__mmiowb_state.mmiowb_pending))) {
          __this_cpu_write(__mmiowb_state.mmiowb_pending, 0);
          mmiowb();
      }
      __this_cpu_dec(__mmiowb_state.nesting_count);
  }

or something (xchg is generally much more expensive than read, and the
common case for spinlocks is that nobody did IO inside of it).

And we don't need atomicity, since even if there's an interrupt that
does more IO while we're in the spinlock, _those_ IO's don't need to
be serialized by that spinlock.

Hmm? Entirely untested, and maybe I have a thinko somewhere, but the
above would seem to be better for the common case that really matters.
No?

             Linus
