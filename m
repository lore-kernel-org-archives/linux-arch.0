From: David Miller <davem@davemloft.net>
Subject: Re: LMB bits
Date: Sat, 10 Jul 2010 13:14:18 -0700 (PDT)
Message-ID: <20100710.131418.246532639.davem@davemloft.net>
References: <20100709.172050.112604881.davem@davemloft.net>
	<20100709.205544.48508808.davem@davemloft.net>
	<1278759719.28659.155.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:50412
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751090Ab0GJUOF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 10 Jul 2010 16:14:05 -0400
In-Reply-To: <1278759719.28659.155.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: benh@kernel.crashing.org
Cc: mingo@elte.hu, yinghai@kernel.org, hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org, linux-arch@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 10 Jul 2010 21:01:59 +1000

> On Fri, 2010-07-09 at 20:55 -0700, David Miller wrote:
>> A quick update, I'm still chipping away to find the culprit,
>> I know so far that things are ok at least 14 patches into the
>> series.
>> 
>> I'll work more to try and track down the exact problem tomorrow. 
> 
> Thanks Dave !

The first guilty commit seems to be:

--------------------
From 869146ec57f449a5dd4bb5d939361841f4f7f3c6 Mon Sep 17 00:00:00 2001
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 6 Jul 2010 15:39:08 -0700
Subject: [PATCH 01/12] memblock: Make memblock_find_region() out of memblock_alloc_region()

This function will be used to locate a free area to put the new memblock
arrays when attempting to resize them. memblock_alloc_region() is gone,
the two callsites now call memblock_add_region().

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
--------------------

I wonder if there is some subtle way you've changed behavior here?
Previously if alloc block fails to do the add, it continues and
keeps trying.

Whereas now this add call happens a level higher and it's immediately
signalled as a hard failure.

Oh I see, your conversion of membase_alloc_nid_region() is buggy.
Instead of passing in "ret" as the base address to memblock_add_region(),
you're passing in the original value, "start".

The other conversion was done correctly, which is why you didn't see
this problem obviously :)

I'll make this fix and see how much further I can get.

> To save you that burden in the future, do you know if there's a sparc64
> box somewhere I can access to do tests ? Or an emulator maybe ?

Contact me on IRC sometime and I'll try to set you up with a machine
you can easily remotely reboot, power-on, and power-off to test
kernels on.
