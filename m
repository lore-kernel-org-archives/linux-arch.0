Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34297 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447AbbDNHsz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Apr 2015 03:48:55 -0400
MIME-Version: 1.0
In-Reply-To: <1428785283-20501-12-git-send-email-richard@nod.at>
References: <1428785283-20501-1-git-send-email-richard@nod.at>
	<1428785283-20501-12-git-send-email-richard@nod.at>
Date: Tue, 14 Apr 2015 09:48:53 +0200
Message-ID: <CAMuHMdULR65Jp+=03ykpTwvORVQtRywZizca0_4h6RPM298LPg@mail.gmail.com>
Subject: Re: [PATCH 11/24] m68k: Remove signal translation and exec_domain
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, =?UTF-8?Q?H=C3=A5vard_Skinnemoen?= <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Miao Steven <realmz6@gmail.com>, Mark Salter <msalter@redhat.com>, "a-jacquiot@ti.com" <a-jacquiot@ti.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, David Howells <dhowells@redhat.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, "David S. Miller" <davem@davemloft.net>, cmetcalf@ezchip.com, Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, Christoph Hellwig <hch@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20150414074853.UyMguDvHVtVHba7E4BOKD4kmz5q1LQV-9608ajyQ0u8@z>

On Sat, Apr 11, 2015 at 10:47 PM, Richard Weinberger <richard@nod.at> wrote:
> As execution domain support is gone we can remove
> signal translation from the signal code and remove
> exec_domain from thread_info.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>

For the m68k changes:

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
