Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org ([63.228.1.57]:14270 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263147AbUDWAGW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2004 20:06:22 -0400
Subject: Re: [Patch] SMP call function cleanup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1082636511.1332.34.camel@halo>
References: <1082636511.1332.34.camel@halo>
Content-Type: text/plain
Message-Id: <1082678647.22367.126.camel@gaston>
Mime-Version: 1.0
Date: Fri, 23 Apr 2004 10:04:08 +1000
Content-Transfer-Encoding: 7bit
To: glauber@gmx.de
Cc: Linux Arch list <linux-arch@vger.kernel.org>, schwidefsky@de.ibm.com
List-ID: <linux-arch.vger.kernel.org>


> there are 3 different kinds of SMP calls:
> 1. all CPUs
> 2. all CPUs but my own
> 3. one CPU
> 
> only _one_ basic function is needed to implement all variants:

Well, I'd go further and allow an arbitraty cpu_mask. There are
cases where that could be an interesting optimisation to be able
to send an IPI to a "set" of CPUs. If the HW can't do it easily,
just send on all and software mask who gets the actual function
call.

Ben.
