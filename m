Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from frisell.zx2c4.com ([192.95.5.64]:55739 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbeHZR2C (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 26 Aug 2018 13:28:02 -0400
MIME-Version: 1.0
References: <20180824213849.23647-1-Jason@zx2c4.com> <20180824213849.23647-2-Jason@zx2c4.com>
 <alpine.DEB.2.21.1808261234240.1195@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1808261234240.1195@nanos.tec.linutronix.de>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Sun, 26 Aug 2018 07:45:10 -0600
Message-ID: <CAHmME9qrc_f6uqGOrRVpnO_sTXHg2cg-WwWg4ik3yqu=HCOZSg@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] asm: simd context helper API
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Andrew Lutomirski <luto@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org, Rik van Riel <riel@surriel.com>
Message-ID: <20180826134510.y-LYYN03ez94Z-nFMJ8dIU871NeBnvG8-mo0kD08n4k@z>

Hey Thomas,

On Sun, Aug 26, 2018 at 6:10 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> I'm not too fond of this simply because it requires that relax() step in
> all code pathes. I'd rather make that completely transparent by just
> marking the task as FPU using and let the context switch code deal with it
> in case that it gets preempted. I'll let one of my engineers look into
> that next week.

Do you mean to say you intend to make kernel_fpu_end() and
kernel_neon_end() only actually do something upon context switch, but
not when it's actually called? So that multiple calls to
kernel_fpu_begin() and kernel_neon_begin() can be made without
penalty? If so, that'd be great, and I'd certainly prefer this to the
simd_context_t passing. I consider the simd_get/put/relax API a
stopgap measure until something like that is implemented.

Jason
