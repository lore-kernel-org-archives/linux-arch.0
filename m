Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:42572 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbeH1VVS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Aug 2018 17:21:18 -0400
From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Oops running iptables -F OUTPUT
References: <87bm9n68gq.fsf@igel.home>
        <20180828140632.593291cf@roar.ozlabs.ibm.com>
        <CAKv+Gu8ROLamoxFZzbqrzSHq1cUQg5hn02HrKGB_0AT=EcBJpg@mail.gmail.com>
        <CAKv+Gu_hPaxrVtsBOoviRraYk4FWnT9zQVCVF=i27xd_nGHryw@mail.gmail.com>
Date: Tue, 28 Aug 2018 19:28:32 +0200
In-Reply-To: <CAKv+Gu_hPaxrVtsBOoviRraYk4FWnT9zQVCVF=i27xd_nGHryw@mail.gmail.com>
        (Ard Biesheuvel's message of "Tue, 28 Aug 2018 18:09:09 +0200")
Message-ID: <87y3cqbdtr.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Nicholas Piggin <nicholas.piggin@gmail.com>, "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>, linuxppc-dev@ozlabs.org, Jessica Yu <jeyu@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20180828172832.uY0hbKwytBs6C5g3kro8eWTvJXKPfgQFzcgM_MsTBcY@z>

On Aug 28 2018, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 6a501b25dd85..57d09d5ceb1a 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -779,7 +779,6 @@ EXPORT_SYMBOL(__per_cpu_offset);
>
>  void __init setup_per_cpu_areas(void)
>  {
> -       const size_t dyn_size = PERCPU_MODULE_RESERVE + PERCPU_DYNAMIC_RESERVE;
>         size_t atom_size;
>         unsigned long delta;
>         unsigned int cpu;
> @@ -795,7 +794,9 @@ void __init setup_per_cpu_areas(void)
>         else
>                 atom_size = 1 << 20;
>
> -       rc = pcpu_embed_first_chunk(0, dyn_size, atom_size, pcpu_cpu_distance,
> +       rc = pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
> +                                   PERCPU_DYNAMIC_RESERVE,
> +                                   atom_size, pcpu_cpu_distance,
>                                     pcpu_fc_alloc, pcpu_fc_free);
>         if (rc < 0)
>                 panic("cannot initialize percpu area (err=%d)", rc);

That didn't help.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
