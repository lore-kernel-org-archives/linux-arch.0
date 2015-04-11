Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:65276 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753800AbbDKVMx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 11 Apr 2015 17:12:53 -0400
Message-ID: <55298E4F.50502@nod.at>
Date: Sat, 11 Apr 2015 23:12:47 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
Subject: Re: Remove execution domain support
References: <1428785283-20501-1-git-send-email-richard@nod.at> <CA+55aFyXWGUYg7W5xZzh-3BT+NuCib-s5t_Ho3YTh3+QK26jSA@mail.gmail.com>
In-Reply-To: <CA+55aFyXWGUYg7W5xZzh-3BT+NuCib-s5t_Ho3YTh3+QK26jSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, hskinnemoen@gmail.com, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Miao Steven <realmz6@gmail.com>, Mark Salter <msalter@redhat.com>, "JACQUIOT-XID, Aurelien" <a-jacquiot@ti.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, David Howells <dhowells@redhat.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, liqin.linux@gmail.com, Lennox Wu <lennox.wu@gmail.com>, David Miller <davem@davemloft.net>, cmetcalf@ezchip.com, Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, Christoph Hellwig <hch@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <20150411211247.POA1bNdjP-wMx2K3NrI5x13l_Ixi1SAWwV4wZuNyhJY@z>

Am 11.04.2015 um 22:52 schrieb Linus Torvalds:
> On Sat, Apr 11, 2015 at 1:47 PM, Richard Weinberger <richard@nod.at> wrote:
>>
>> The removal will make architecutre specific signal handling easier
>> and there is no need to keep execuction domains as this feature is
>> obviously incomplete and abandoned
> 
> Ack. The whole exec domain made some code code pretty inscrutable.
> 
> So I'd certainly be willing to pull this during the 4.1 merge window
> if nobody complains.
> 
> Anybody?

It would be great to have an Ack from sparc folks.
I had to recalculate the values of their TI_* constants
and I don't have a sparc box to test it.

Using asm-offsets.c for that seems to be impossible on sparc
as sparc's asm-offsets.c depends on sched.h which depends again
on thread_info.h...
Resolving this circular dependency without the ability to run-time
test my changes was too risky for me.

Thanks,
//richard
