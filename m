Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:2445
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S2992772AbWJUCLd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Oct 2006 22:11:33 -0400
Date: Fri, 20 Oct 2006 19:11:34 -0700 (PDT)
Message-Id: <20061020.191134.63996591.davem@davemloft.net>
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0610201733490.3962@g5.osdl.org>
References: <Pine.LNX.4.64.0610201625190.3962@g5.osdl.org>
	<20061021000609.GA32701@linux-mips.org>
	<Pine.LNX.4.64.0610201733490.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: torvalds@osdl.org
Cc: ralf@linux-mips.org, nickpiggin@yahoo.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp, linux-arch@vger.kernel.org, schwidefsky@de.ibm.com, James.Bottomley@steeleye.com
List-ID: <linux-arch.vger.kernel.org>

From: Linus Torvalds <torvalds@osdl.org>
Date: Fri, 20 Oct 2006 17:38:32 -0700 (PDT)

> I think (but may be mistaken) that ARM _does_ have pure virtual caches 
> with a process ID, but people have always ended up flushing them at 
> context switch simply because it just causes too much trouble.
> 
> Sparc? VIPT too? Davem?

sun4c is VIVT, but has no SMP variants.
sun4m has both VIPT and PIPT.

> But it would be good to have something for the early -rc1 sequence for 
> 2.6.20, and maybe the MIPS COW D$ patches are it, if it has performance 
> advantages on MIPS that can also be translated to other virtual cache 
> users..

I think it could help for sun4m highmem configs.
