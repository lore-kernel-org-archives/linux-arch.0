From: David Miller <davem@davemloft.net>
Subject: Re: LMB bits
Date: Tue, 13 Jul 2010 09:45:18 -0700 (PDT)
Message-ID: <20100713.094518.133409593.davem@davemloft.net>
References: <20100712.153455.108790468.davem@davemloft.net>
	<1279005164.28659.407.camel@pasglop>
	<AANLkTikkqL9ppLDaLP6ISkuAawgGF-4ly28sAhdLW3AM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:36544
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756958Ab0GMQpE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 Jul 2010 12:45:04 -0400
In-Reply-To: <AANLkTikkqL9ppLDaLP6ISkuAawgGF-4ly28sAhdLW3AM@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: benh@kernel.crashing.org, yinghai@kernel.org, mingo@elte.hu, hpa@zytor.com, tglx@linutronix.de, linux-arch@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 13 Jul 2010 08:11:57 -0700

> On Tue, Jul 13, 2010 at 12:12 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>>
>> Ingo, Linus, how to you want to proceed ? We could get the rename patch
>> in now, that would make things easier for the ARM folks who have started
>> using LMB as well and are currently clashing in linux-next, and keep the
>> rest of the rework for the merge window ? Or keep the whole thing for
>> the merge window ?
> 
> If it's just a rename, and the accidental lmb renames have been all
> sorted out, then I'm ok with taking a pure rename that changes nothing
> else now, just to make things easier to merge later.

I'd also be real happy if we did this now too.
