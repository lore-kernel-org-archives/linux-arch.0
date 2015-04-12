Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35633 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbbDLV4R (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 12 Apr 2015 17:56:17 -0400
MIME-Version: 1.0
In-Reply-To: <552AE0D2.8070406@nod.at>
References: <1428785283-20501-1-git-send-email-richard@nod.at>
	<552ADC1D.5050206@nod.at>
	<20150413071312.5279b56e@canb.auug.org.au>
	<552AE0D2.8070406@nod.at>
Date: Sun, 12 Apr 2015 14:56:16 -0700
Message-ID: <CA+55aFwx8AC-xF3BXTdb_hVYE8Twn0jJfskxLCnvvGkAYc37Tw@mail.gmail.com>
Subject: Re: Remove execution domain support v2
From: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, =?UTF-8?Q?H=C3=A5vard_Skinnemoen?= <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Miao Steven <realmz6@gmail.com>, Mark Salter <msalter@redhat.com>, "JACQUIOT-XID, Aurelien" <a-jacquiot@ti.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, David Howells <dhowells@redhat.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, liqin.linux@gmail.com, Lennox Wu <lennox.wu@gmail.com>, David Miller <davem@davemloft.net>, cmetcalf@ezchip.com, Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, Christoph Hellwig <hch@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Guenter Roeck <linux@roeck-us.net>
Message-ID: <20150412215616.UdrQcfx15zAgiNrJImm-i7_Z_bd22QaBG-tdTOKaz1k@z>

On Sun, Apr 12, 2015 at 2:17 PM, Richard Weinberger <richard@nod.at> wrote:
>>
>> On Sun, 12 Apr 2015 22:57:01 +0200 Richard Weinberger <richard@nod.at> wrote:
>>>
>>> Stephen, can you please add the tree to -next?
>>
>> Added from today.  I'll remove it after Linus merges it, OK?
>
> sure.

Richard, I'll do 4.0 today and start merging, but since this is going
into -next, let's wait a few days to verify that there are no issues,
and then please send me a "final" pull request mid next weeks or so.

Otherwise I'll probably forget in the chaos that is the early merge
window for me.

Ok?

                          Linus
