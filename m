Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:29959 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751303AbWISIDg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Sep 2006 04:03:36 -0400
Subject: Re: [PATCH 2/6] Introduce CONFIG_ZONE_DMA
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <Pine.LNX.4.64.0609181027440.19312@schroedinger.engr.sgi.com>
References: <20060911222729.4849.69497.sendpatchset@schroedinger.engr.sgi.com>
	 <20060911222739.4849.79915.sendpatchset@schroedinger.engr.sgi.com>
	 <20060918135559.GB15096@infradead.org> <1158588487.31364.3.camel@localhost>
	 <Pine.LNX.4.64.0609181027440.19312@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Tue, 19 Sep 2006 10:03:32 +0200
Message-Id: <1158653012.17979.2.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Lameter <clameter@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-mm@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>, linux-ia64@vger.kernel.org, Marcelo Tosatti <marcelo@kvack.org>, Arjan van de Ven <arjan@infradead.org>, Martin Bligh <mbligh@google.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2006-09-18 at 10:28 -0700, Christoph Lameter wrote:
> > s390 needs ZONE_DMA for the memory area below 2GB. That is required for
> > the control structure of channel based I/O. It is not ISA but
> > conceptually related. Can we rename GENERIC_ISA_DMA into GENERIC_IO_DMA
> > or something similar?
> 
> The patchset defines CONFIG_ZONE_DMA for s390 so you are fine.

Ok, I've looked at the patch and defining ZONE_DMA is the
straightforward solution. No need to make detours over GENERIC_ISA_DMA.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


