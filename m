Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org ([203.10.76.45]:26799 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263147AbUDWAZw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2004 20:25:52 -0400
Date: Fri, 23 Apr 2004 10:21:41 +1000
From: Anton Blanchard <anton@samba.org>
Subject: Re: [Patch] SMP call function cleanup
Message-ID: <20040423002141.GI22027@krispykreme>
References: <1082636511.1332.34.camel@halo> <20040422122818.GR743@holomorphy.com> <20040422123703.GY22027@krispykreme> <1082678709.22255.128.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082678709.22255.128.camel@gaston>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, Jan Glauber <glauber@gmx.de>, Linux Arch list <linux-arch@vger.kernel.org>, schwidefsky@de.ibm.com
List-ID: <linux-arch.vger.kernel.org>

 
> It's easy for those archs to implement it with a send-all and a software
> filtering. For the cases where it would be an optimisation to send to
> a cpumask, it makes sense to provide that function.

Then someone uses it in a performance critical place and my big SMP
ppc64 performance sucks.

We still havent been given a place in generic code where this
optimisation makes sense.

Anton
