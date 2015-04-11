From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Remove execution domain support
Date: Sun, 12 Apr 2015 09:25:17 +1000
Message-ID: <1428794717.18187.174.camel@kernel.crashing.org>
References: <1428785283-20501-1-git-send-email-richard@nod.at>
	 <CA+55aFyXWGUYg7W5xZzh-3BT+NuCib-s5t_Ho3YTh3+QK26jSA@mail.gmail.com>
	 <55298E4F.50502@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:41891 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907AbbDKX2l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 11 Apr 2015 19:28:41 -0400
In-Reply-To: <55298E4F.50502@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, hskinnemoen@gmail.com, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Miao Steven <realmz6@gmail.com>, Mark Salter <msalter@redhat.com>, "JACQUIOT-XID, Aurelien" <a-jacquiot@ti.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, David Howells <dhowells@redhat.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux>

On Sat, 2015-04-11 at 23:12 +0200, Richard Weinberger wrote:
> Am 11.04.2015 um 22:52 schrieb Linus Torvalds:
> > On Sat, Apr 11, 2015 at 1:47 PM, Richard Weinberger <richard@nod.at> wrote:
> >>
> >> The removal will make architecutre specific signal handling easier
> >> and there is no need to keep execuction domains as this feature is
> >> obviously incomplete and abandoned
> > 
> > Ack. The whole exec domain made some code code pretty inscrutable.
> > 
> > So I'd certainly be willing to pull this during the 4.1 merge window
> > if nobody complains.
> > 
> > Anybody?
> 
> It would be great to have an Ack from sparc folks.
> I had to recalculate the values of their TI_* constants
> and I don't have a sparc box to test it.

That's what qemu is for :-)

> Using asm-offsets.c for that seems to be impossible on sparc
> as sparc's asm-offsets.c depends on sched.h which depends again
> on thread_info.h...
> Resolving this circular dependency without the ability to run-time
> test my changes was too risky for me.
> 
> Thanks,
> //richard
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
