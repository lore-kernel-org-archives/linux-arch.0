Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34307 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756142AbbDKUwW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 11 Apr 2015 16:52:22 -0400
MIME-Version: 1.0
In-Reply-To: <1428785283-20501-1-git-send-email-richard@nod.at>
References: <1428785283-20501-1-git-send-email-richard@nod.at>
Date: Sat, 11 Apr 2015 13:52:21 -0700
Message-ID: <CA+55aFyXWGUYg7W5xZzh-3BT+NuCib-s5t_Ho3YTh3+QK26jSA@mail.gmail.com>
Subject: Re: Remove execution domain support
From: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, hskinnemoen@gmail.com, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Miao Steven <realmz6@gmail.com>, Mark Salter <msalter@redhat.com>, "JACQUIOT-XID, Aurelien" <a-jacquiot@ti.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, David Howells <dhowells@redhat.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, yasutake.koichi@jp.panasonic.com, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, liqin.linux@gmail.com, Lennox Wu <lennox.wu@gmail.com>, David Miller <davem@davemloft.net>, cmetcalf@ezchip.com, Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, Christoph Hellwig <hch@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <20150411205221._KlRj8YBslRDqg_m1cjbfEWW80jr2I_3cR3_6CRqw5k@z>

On Sat, Apr 11, 2015 at 1:47 PM, Richard Weinberger <richard@nod.at> wrote:
>
> The removal will make architecutre specific signal handling easier
> and there is no need to keep execuction domains as this feature is
> obviously incomplete and abandoned

Ack. The whole exec domain made some code code pretty inscrutable.

So I'd certainly be willing to pull this during the 4.1 merge window
if nobody complains.

Anybody?

                        Linus
