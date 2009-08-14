From: David Miller <davem@davemloft.net>
Subject: Re: [patch 0/3] Allow inlined spinlocks again V3
Date: Fri, 14 Aug 2009 15:23:58 -0700 (PDT)
Message-ID: <20090814.152358.16603090.davem@davemloft.net>
References: <20090814.131900.229343660.davem@davemloft.net>
	<alpine.LFD.2.01.0908141345000.3162@localhost.localdomain>
	<alpine.LFD.2.01.0908141350420.3162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:48435
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753215AbZHNWXs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 14 Aug 2009 18:23:48 -0400
In-Reply-To: <alpine.LFD.2.01.0908141350420.3162@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: heiko.carstens@de.ibm.com, akpm@linux-foundation.org, a.p.zijlstra@chello.nl, mingo@elte.hu, linux-arch@vger.kernel.org, schwidefsky@de.ibm.com, arnd@arndb.de, horsth@linux.vnet.ibm.com, ehrhardt@linux.vnet.ibm.com

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Aug 2009 14:10:45 -0700 (PDT)

> On Fri, 14 Aug 2009, Linus Torvalds wrote:
>> 
>> But not inline in the code, though. So yeah, it has a memory footprint, 
>> but shouldn't have a cache footprint.
> 
> An example of this: stack usage. This is the code with BUG_ON():
 ...
> and note how in the code, we're just jumping over something like four
> bytes ("ud2" plus that silly endless loop-jump just to make gcc happy
> are both 2 bytes on x86[-64]). 
> 
> Here's the same code with that horrid skb_under_panic():

Yes on x86 it's better even with verbose debugging because
of the inlining of the debug message pointer etc.

I'll have to do something more intelligent than I currently do on
sparc64, and I had always been meaning to do that. :-)
