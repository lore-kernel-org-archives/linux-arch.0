Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org ([63.228.1.57]:26558 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263147AbUDWAee (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2004 20:34:34 -0400
Subject: Re: [Patch] SMP call function cleanup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040423002141.GI22027@krispykreme>
References: <1082636511.1332.34.camel@halo>
	 <20040422122818.GR743@holomorphy.com> <20040422123703.GY22027@krispykreme>
	 <1082678709.22255.128.camel@gaston>  <20040423002141.GI22027@krispykreme>
Content-Type: text/plain
Message-Id: <1082680360.2077.139.camel@gaston>
Mime-Version: 1.0
Date: Fri, 23 Apr 2004 10:32:41 +1000
Content-Transfer-Encoding: 7bit
To: Anton Blanchard <anton@samba.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, Jan Glauber <glauber@gmx.de>, Linux Arch list <linux-arch@vger.kernel.org>, schwidefsky@de.ibm.com
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2004-04-23 at 10:21, Anton Blanchard wrote:
>  > It's easy for those archs to implement it with a send-all and a software
> > filtering. For the cases where it would be an optimisation to send to
> > a cpumask, it makes sense to provide that function.
> 
> Then someone uses it in a performance critical place and my big SMP
> ppc64 performance sucks.

Ah ? OpenPIC can nicely IPI to CPU masks iirc, can't xics ? :)-

> We still havent been given a place in generic code where this
> optimisation makes sense.

I had a few cases where I wanted it until I found different ways to
do things (using RCU mostly), like the PTE freeing race. So far, I
avoided it. But I regulary come up with some idea which would
involve such a thing.

Ben.
