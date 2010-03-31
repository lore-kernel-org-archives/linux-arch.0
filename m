From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: start_kernel(): bug: interrupts were enabled early
Date: Wed, 31 Mar 2010 15:36:26 -0700
Message-ID: <4BB3CE6A.2080406@zytor.com>
References: <20100325194100.GA2364@debian>	 <20100331134048.da4e35a7.akpm@linux-foundation.org>	 <4BB3B4DB.7040904@kernel.org> <1270074687.7101.74.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:58322 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755213Ab0CaWke (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Mar 2010 18:40:34 -0400
In-Reply-To: <1270074687.7101.74.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Yinghai Lu <yinghai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Rabin Vincent <rabin@rab.in>, lkml <linux-kernel@vger.kernel.org>, penberg@cs.helsinki.fi, cl@linux-foundation.org, linux-arch@vger.kernel.org

On 03/31/2010 03:31 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2010-03-31 at 13:47 -0700, Yinghai Lu wrote:
>>> perhaps the second one isn't needed?  Perhaps no architecture
>> requires
>>> that local interrupts be disabled across the above initialisations?
>>         
>> spin_unlock_irq from arm is different from other archs?
> 
> No, it's not, it will enable IRQs and thats illegal to do so early
> during boot. We've been over that one again and again, the problem is
> that people want to keep using that instead of irqsave/restore because
> it's a nano-optimisation on x86... oh well...
> 

Well, guess what... the particular user in this case *isn't used at all
on x86* so it is a non-issue here.  So I take it we have your particular
vote to use irqsave/irqrestore in lib/rwsem-spinlock.c?

	-hpa
