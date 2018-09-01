Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from frisell.zx2c4.com ([192.95.5.64]:41311 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbeIBAcW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 1 Sep 2018 20:32:22 -0400
MIME-Version: 1.0
References: <20180824213849.23647-1-Jason@zx2c4.com> <20180824213849.23647-2-Jason@zx2c4.com>
 <alpine.DEB.2.21.1808261234240.1195@nanos.tec.linutronix.de>
 <CAHmME9qrc_f6uqGOrRVpnO_sTXHg2cg-WwWg4ik3yqu=HCOZSg@mail.gmail.com> <alpine.DEB.2.21.1808261602250.1195@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1808261602250.1195@nanos.tec.linutronix.de>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Sat, 1 Sep 2018 14:19:01 -0600
Message-ID: <CAHmME9pP-rfzE9VAysm-tRiQrrKXpP2=8VEUrbS5Xt-wpEXCcA@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] asm: simd context helper API
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Andrew Lutomirski <luto@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org, Rik van Riel <riel@surriel.com>
Message-ID: <20180901201901.Qgfj9sSMX8mPUGuN-LmtGc6XGZPmLz05JB8uq7O2lKY@z>

Hey Thomas,

I'd like to move ahead with my patchset and make some forward progress
in LKML submission. If you've got something brewing regarding the FPU
context on x86 and ARM, I'm happy to wait a bit longer so as to build
on that. But if that is instead a far-off theoretical eventual thing,
perhaps it's better for me to move ahead as planned, and we can switch
to the superior FPU semantics whenever you get around to it? Either
way, please let me know what you have in mind so our plans can stay
somewhat sync'd.

Talk soon,
Jason
