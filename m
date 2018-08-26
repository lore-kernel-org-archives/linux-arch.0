Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:41712 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeHZPxO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Aug 2018 11:53:14 -0400
Date: Sun, 26 Aug 2018 14:10:35 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 01/17] asm: simd context helper API
In-Reply-To: <20180824213849.23647-2-Jason@zx2c4.com>
Message-ID: <alpine.DEB.2.21.1808261234240.1195@nanos.tec.linutronix.de>
References: <20180824213849.23647-1-Jason@zx2c4.com> <20180824213849.23647-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, David Miller <davem@davemloft.net>, Andy Lutomirski <luto@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org, Rik van Riel <riel@surriel.com>
Message-ID: <20180826121035.s4XSmRrRHdcGB3Z3qx2CzeU_MHQFFKb-yOlastLAA60@z>

On Fri, 24 Aug 2018, Jason A. Donenfeld wrote:

> Sometimes it's useful to amortize calls to XSAVE/XRSTOR and the related
> FPU/SIMD functions over a number of calls, because FPU restoration is
> quite expensive. This adds a simple header for carrying out this pattern:
> 
>     simd_context_t simd_context = simd_get();
>     while ((item = get_item_from_queue()) != NULL) {
>         encrypt_item(item, simd_context);
>         simd_context = simd_relax(simd_context);
>     }
>     simd_put(simd_context);

I'm not too fond of this simply because it requires that relax() step in
all code pathes. I'd rather make that completely transparent by just
marking the task as FPU using and let the context switch code deal with it
in case that it gets preempted. I'll let one of my engineers look into
that next week.

Thanks,

	tglx
