Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbeIBApi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 1 Sep 2018 20:45:38 -0400
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F8F22084D
        for <linux-arch@vger.kernel.org>; Sat,  1 Sep 2018 20:32:30 +0000 (UTC)
Received: by mail-wm0-f47.google.com with SMTP id y139-v6so8022418wmc.2
        for <linux-arch@vger.kernel.org>; Sat, 01 Sep 2018 13:32:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHmME9pP-rfzE9VAysm-tRiQrrKXpP2=8VEUrbS5Xt-wpEXCcA@mail.gmail.com>
References: <20180824213849.23647-1-Jason@zx2c4.com> <20180824213849.23647-2-Jason@zx2c4.com>
 <alpine.DEB.2.21.1808261234240.1195@nanos.tec.linutronix.de>
 <CAHmME9qrc_f6uqGOrRVpnO_sTXHg2cg-WwWg4ik3yqu=HCOZSg@mail.gmail.com>
 <alpine.DEB.2.21.1808261602250.1195@nanos.tec.linutronix.de> <CAHmME9pP-rfzE9VAysm-tRiQrrKXpP2=8VEUrbS5Xt-wpEXCcA@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Sat, 1 Sep 2018 13:32:08 -0700
Message-ID: <CALCETrUdjCKcjg9R7P7hXxOt_Nt-htTVrJN9cwLfteh4aBz7Gw@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] asm: simd context helper API
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Andrew Lutomirski <luto@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Samuel Neves <sneves@dei.uc.pt>, linux-arch <linux-arch@vger.kernel.org>, Rik van Riel <riel@surriel.com>
Message-ID: <20180901203208.BVJLCCVkgt_XEZy-6wDxSO80f9185s98TEnUsZFqsKE@z>

On Sat, Sep 1, 2018 at 1:19 PM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Hey Thomas,
>
> I'd like to move ahead with my patchset and make some forward progress
> in LKML submission. If you've got something brewing regarding the FPU
> context on x86 and ARM, I'm happy to wait a bit longer so as to build
> on that. But if that is instead a far-off theoretical eventual thing,
> perhaps it's better for me to move ahead as planned, and we can switch
> to the superior FPU semantics whenever you get around to it? Either
> way, please let me know what you have in mind so our plans can stay
> somewhat sync'd.

I tend to think the right approach is to merge Jason's code and then
make it better later.  Even with a totally perfect lazy FPU restore
implementation on x86, we'll probably still need some way of dealing
with SIMD contexts.  I think we're highly unlikely to ever a allow
SIMD usage in all NMI contexts, for example, and there will always be
cases where we specifically don't want to use all available SIMD
capabilities even if we can.  For example, generating random numbers
does crypto, but we probably don't want to do *SIMD* crypto, since
that will force a save and restore and will probably fire up the
AVX512 unit, and that's not worth it unless we're already using it for
some other reason.

Also, as Rik has discovered, lazy FPU restore is conceptually
straightforward but isn't entirely trivial :)

--Andy
