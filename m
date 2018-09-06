Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:34066 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729842AbeIFSSa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Sep 2018 14:18:30 -0400
Date: Thu, 6 Sep 2018 15:42:44 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 01/17] asm: simd context helper API
In-Reply-To: <CAHmME9rL2omQxqMVCcX-jPMpcQDk8ftEn3YXWcFhS=AkVK8ZXw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809061542330.1570@nanos.tec.linutronix.de>
References: <20180824213849.23647-1-Jason@zx2c4.com> <20180824213849.23647-2-Jason@zx2c4.com> <alpine.DEB.2.21.1808261234240.1195@nanos.tec.linutronix.de> <CAHmME9qrc_f6uqGOrRVpnO_sTXHg2cg-WwWg4ik3yqu=HCOZSg@mail.gmail.com> <alpine.DEB.2.21.1808261602250.1195@nanos.tec.linutronix.de>
 <CAHmME9pP-rfzE9VAysm-tRiQrrKXpP2=8VEUrbS5Xt-wpEXCcA@mail.gmail.com> <CALCETrUdjCKcjg9R7P7hXxOt_Nt-htTVrJN9cwLfteh4aBz7Gw@mail.gmail.com> <CAHmME9rL2omQxqMVCcX-jPMpcQDk8ftEn3YXWcFhS=AkVK8ZXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andrew Lutomirski <luto@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org, Rik van Riel <riel@surriel.com>
Message-ID: <20180906134244.fxwP6bH_68w_cKNq4T-gDV-vZKgCjUFlI00fy5fgdWM@z>

On Sat, 1 Sep 2018, Jason A. Donenfeld wrote:
> On Sat, Sep 1, 2018 at 2:32 PM Andy Lutomirski <luto@kernel.org> wrote:
> > I tend to think the right approach is to merge Jason's code and then
> > make it better later.  Even with a totally perfect lazy FPU restore
> > implementation on x86, we'll probably still need some way of dealing
> > with SIMD contexts.  I think we're highly unlikely to ever a allow
> > SIMD usage in all NMI contexts, for example, and there will always be
> > cases where we specifically don't want to use all available SIMD
> > capabilities even if we can.  For example, generating random numbers
> > does crypto, but we probably don't want to do *SIMD* crypto, since
> > that will force a save and restore and will probably fire up the
> > AVX512 unit, and that's not worth it unless we're already using it for
> > some other reason.
> >
> > Also, as Rik has discovered, lazy FPU restore is conceptually
> > straightforward but isn't entirely trivial :)
> 
> Sounds good. I'll move ahead on this basis.

Fine with me.
