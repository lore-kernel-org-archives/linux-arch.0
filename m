Return-Path: <glauber@gmx.de>
Received: from mtagate4.de.ibm.com ([195.212.29.153]:10380 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S264064AbUDVOB0
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2004 10:01:26 -0400
Subject: Re: [Patch] SMP call function cleanup
From: Jan Glauber <glauber@gmx.de>
Reply-To: glauber@gmx.de
In-Reply-To: <20040422123318.GX22027@krispykreme>
References: <1082636511.1332.34.camel@halo>
	 <20040422123318.GX22027@krispykreme>
Content-Type: text/plain
Message-Id: <1082642408.1332.56.camel@halo>
Mime-Version: 1.0
Date: Thu, 22 Apr 2004 16:00:08 +0200
Content-Transfer-Encoding: 7bit
To: Anton Blanchard <anton@samba.org>
Cc: Linux Architecture List <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2004-04-22 at 14:33, Anton Blanchard wrote:
>  Hi,
> 
> > I've been looking into the SMP call function stuff on different
> > archs and found many different functions...
> > 
> > In the common code part there are 2 functions:
> > smp_call_function()  	// call a function on all CPUs but my own
> > on_each_cpu()		// call a function on all CPUs
> > 
> > Many archs need an additional function to call a function on a 
> > specific CPU:
> 
> We noticed this too. Rusty created on_one_cpu below and had a generic
> (but costly) implementation so architectures could switch across when they
> wanted.

Hm, why can't you just do a:

for_each_cpu_mask(cpu, mask)
        send_IPI_single(cpu)

Jan

---
Jan Glauber
Linux on zSeries Development
IBM Deutschland Entwicklung GmbH
Phone: +49 7031 161911   Mail: jang@de.ibm.com
