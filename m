Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:41771 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbeHZRt3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Aug 2018 13:49:29 -0400
Date: Sun, 26 Aug 2018 16:06:32 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 01/17] asm: simd context helper API
In-Reply-To: <CAHmME9qrc_f6uqGOrRVpnO_sTXHg2cg-WwWg4ik3yqu=HCOZSg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1808261602250.1195@nanos.tec.linutronix.de>
References: <20180824213849.23647-1-Jason@zx2c4.com> <20180824213849.23647-2-Jason@zx2c4.com> <alpine.DEB.2.21.1808261234240.1195@nanos.tec.linutronix.de> <CAHmME9qrc_f6uqGOrRVpnO_sTXHg2cg-WwWg4ik3yqu=HCOZSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Andrew Lutomirski <luto@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org, Rik van Riel <riel@surriel.com>
Message-ID: <20180826140632.rqNBPwbdeYO2CEikqRyIEkSCMweRDHNK6Sv7luLTusg@z>

Jason,

On Sun, 26 Aug 2018, Jason A. Donenfeld wrote:
> On Sun, Aug 26, 2018 at 6:10 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > I'm not too fond of this simply because it requires that relax() step in
> > all code pathes. I'd rather make that completely transparent by just
> > marking the task as FPU using and let the context switch code deal with it
> > in case that it gets preempted. I'll let one of my engineers look into
> > that next week.
> 
> Do you mean to say you intend to make kernel_fpu_end() and
> kernel_neon_end() only actually do something upon context switch, but
> not when it's actually called? So that multiple calls to
> kernel_fpu_begin() and kernel_neon_begin() can be made without
> penalty?

On context switch and exit to user. That allows to keep those code pathes
fully preemptible. Still twisting my brain around the details.

> If so, that'd be great, and I'd certainly prefer this to the
> simd_context_t passing. I consider the simd_get/put/relax API a
> stopgap measure until something like that is implemented.

I really want to avoid this stopgap^Wducttape thing.

Thanks,

	tglx
