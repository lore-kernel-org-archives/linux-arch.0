Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from frisell.zx2c4.com ([192.95.5.64]:39257 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730304AbeIFU2f (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Sep 2018 16:28:35 -0400
MIME-Version: 1.0
References: <20180824213849.23647-1-Jason@zx2c4.com> <20180824213849.23647-2-Jason@zx2c4.com>
 <alpine.DEB.2.21.1808261234240.1195@nanos.tec.linutronix.de>
 <CAHmME9qrc_f6uqGOrRVpnO_sTXHg2cg-WwWg4ik3yqu=HCOZSg@mail.gmail.com>
 <alpine.DEB.2.21.1808261602250.1195@nanos.tec.linutronix.de>
 <CAHmME9pP-rfzE9VAysm-tRiQrrKXpP2=8VEUrbS5Xt-wpEXCcA@mail.gmail.com>
 <CALCETrUdjCKcjg9R7P7hXxOt_Nt-htTVrJN9cwLfteh4aBz7Gw@mail.gmail.com>
 <CAHmME9rL2omQxqMVCcX-jPMpcQDk8ftEn3YXWcFhS=AkVK8ZXw@mail.gmail.com> <alpine.DEB.2.21.1809061542330.1570@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809061542330.1570@nanos.tec.linutronix.de>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 6 Sep 2018 09:52:13 -0600
Message-ID: <CAHmME9pNd2WiLQy=EYOj+Pn-55OmaPk__=mzQq07Y5GX7-vJOA@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] asm: simd context helper API
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Lutomirski <luto@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org, Rik van Riel <riel@surriel.com>
Message-ID: <20180906155213.P4AeYQnHbXeH3T1vQq353HjVYYhL3463JxuvAhw3Kck@z>

Hi Thomas,

On Thu, Sep 6, 2018 at 9:29 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sat, 1 Sep 2018, Jason A. Donenfeld wrote:
> > On Sat, Sep 1, 2018 at 2:32 PM Andy Lutomirski <luto@kernel.org> wrote:
> > > I tend to think the right approach is to merge Jason's code and then
> > > make it better later.  Even with a totally perfect lazy FPU restore
> > > implementation on x86, we'll probably still need some way of dealing
> > > with SIMD contexts.  I think we're highly unlikely to ever a allow
> > > SIMD usage in all NMI contexts, for example, and there will always be
> > > cases where we specifically don't want to use all available SIMD
> > > capabilities even if we can.  For example, generating random numbers
> > > does crypto, but we probably don't want to do *SIMD* crypto, since
> > > that will force a save and restore and will probably fire up the
> > > AVX512 unit, and that's not worth it unless we're already using it for
> > > some other reason.
> > >
> > > Also, as Rik has discovered, lazy FPU restore is conceptually
> > > straightforward but isn't entirely trivial :)
> >
> > Sounds good. I'll move ahead on this basis.
>
> Fine with me.

Do you want to pull this single patch [01/17] into your tree now, and
then when I submit v3 of WireGuard and such, I can just drop this
patch from it, and then the rest will enter like usual networking
stuff through Dave's tree?

Jason
