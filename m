From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC][PATCH 10/24] m68k: Provide atomic_{or,xor,and}
Date: Fri, 10 Jul 2015 11:13:48 +0200
Message-ID: <CAMuHMdV8Km5Ko2-uvZaALNsLOb0bSCeBp9N_U0ayDSwyQg7srQ@mail.gmail.com>
References: <20150709172855.564686637@infradead.org>
	<20150709175308.927665458@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33438 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104AbbGJJNs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2015 05:13:48 -0400
In-Reply-To: <20150709175308.927665458@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, =?UTF-8?Q?H=C3=A5vard_Skinnemoen?= <hskinnemoen@gmail.com>, Miao Steven <realmz6@gmail.com>, David Howells <dhowells@redhat.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Chris Metcalf <cmetcalf@ezchip.com>, Ingo Molnar <mingo@kernel.org>

On Thu, Jul 9, 2015 at 7:29 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> Implement atomic logic ops -- atomic_{or,xor,and}.
>
> These will replace the atomic_{set,clear}_mask functions that are
> available on some archs.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

(it builds, even if I add a user of atomic_xor())

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
