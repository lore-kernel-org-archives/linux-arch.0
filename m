From: David Miller <davem@davemloft.net>
Subject: Re: Remove execution domain support
Date: Sat, 11 Apr 2015 15:31:11 -0700 (PDT)
Message-ID: <20150411.153111.1993644186381489454.davem@davemloft.net>
References: <1428785283-20501-1-git-send-email-richard@nod.at>
	<CA+55aFyXWGUYg7W5xZzh-3BT+NuCib-s5t_Ho3YTh3+QK26jSA@mail.gmail.com>
	<55298E4F.50502@nod.at>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:40180 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013AbbDKWWE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 11 Apr 2015 18:22:04 -0400
In-Reply-To: <55298E4F.50502@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: richard@nod.at
Cc: torvalds@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, monstr@monstr.eu, ralf@linux-mips.org, lftan@altera.com, jonas@southpole.se, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, liqin.linux@gmail.com, lennox.wu@gmail.com, cmetcalf@ezchip.com, jdike@addtoit.com, akpm@linux-foundation.org, oleg@redhat.com, hch@

From: Richard Weinberger <richard@nod.at>
Date: Sat, 11 Apr 2015 23:12:47 +0200

> Am 11.04.2015 um 22:52 schrieb Linus Torvalds:
>> On Sat, Apr 11, 2015 at 1:47 PM, Richard Weinberger <richard@nod.at> wrote:
>>>
>>> The removal will make architecutre specific signal handling easier
>>> and there is no need to keep execuction domains as this feature is
>>> obviously incomplete and abandoned
>> 
>> Ack. The whole exec domain made some code code pretty inscrutable.
>> 
>> So I'd certainly be willing to pull this during the 4.1 merge window
>> if nobody complains.
>> 
>> Anybody?
> 
> It would be great to have an Ack from sparc folks.
> I had to recalculate the values of their TI_* constants
> and I don't have a sparc box to test it.

I'm fine with it, I'll fix it up if needed:

Acked-by: David S. Miller <davem@davemloft.net>
