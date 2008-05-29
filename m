From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 2/2] on_each_cpu(): kill unused 'retry' parameter
Date: Thu, 29 May 2008 14:54:29 +0200
Message-ID: <20080529125429.GE25504@kernel.dk>
References: <1212051661-12733-1-git-send-email-jens.axboe@oracle.com> <1212051661-12733-3-git-send-email-jens.axboe@oracle.com> <20080529125151.GA25124@Pilar.ictp.trieste.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from brick.kernel.dk ([87.55.233.238]:6859 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027AbYE2Myc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 29 May 2008 08:54:32 -0400
Content-Disposition: inline
In-Reply-To: <20080529125151.GA25124@Pilar.ictp.trieste.it>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Carlos R. Mafra" <crmafra2@gmail.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, npiggin@suse.de, linux-arch@vger.kernel.org, jeremy@goop.org, mingo@elte.hu, paulmck@linux.vnet.ibm.com

On Thu, May 29 2008, Carlos R. Mafra wrote:
> Hi,
> 
> Just a naive comment/question:
> 
> > -	if (on_each_cpu(ipi_imb, NULL, 1, 1))
> > +	if (on_each_cpu(ipi_imb, NULL, 1))
> 
> A few weeks ago I though about removing the second argument
> from on_each_cpu, which is NULL more or less 70% of the time.
> 
> Do you think it is possible?
> Have you already thought about it? 

It's the data argument to the function, I highly doubt you can get
rid of that I'm afraid. on_each_cpu() is just a thin wrapper on
top of smp_call_function() so that the caller doesn't have to
care about manually calling on the local CPU. So as long as
smp_call_function() has a data argument, on_each_cpu() should
carry it as well.

So nope, I don't think that's feasible (or even desired).

-- 
Jens Axboe
