Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org ([63.228.1.57]:16062 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263364AbUDWAHB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2004 20:07:01 -0400
Subject: Re: [Patch] SMP call function cleanup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040422123703.GY22027@krispykreme>
References: <1082636511.1332.34.camel@halo>
	 <20040422122818.GR743@holomorphy.com>  <20040422123703.GY22027@krispykreme>
Content-Type: text/plain
Message-Id: <1082678709.22255.128.camel@gaston>
Mime-Version: 1.0
Date: Fri, 23 Apr 2004 10:05:10 +1000
Content-Transfer-Encoding: 7bit
To: Anton Blanchard <anton@samba.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, Jan Glauber <glauber@gmx.de>, Linux Arch list <linux-arch@vger.kernel.org>, schwidefsky@de.ibm.com
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2004-04-22 at 22:37, Anton Blanchard wrote:
> Hi,
> 
> > Any chance we could get an smp_call_function_cpumask()?
> 
> Unless there is a need Id prefer not to. Some arches do not support IPI
> to a cpumask, whereas they should do send to all and send to single.

It's easy for those archs to implement it with a send-all and a software
filtering. For the cases where it would be an optimisation to send to
a cpumask, it makes sense to provide that function.

Ben.
