Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 1 Mar 2005 15:30:00 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] set_pte() part 1 (was Re: [PATCH] ppc32: Wrong vaddr in
 flush_hash_one_pte())
Message-Id: <20050301153000.0aaf5ec2.davem@davemloft.net>
In-Reply-To: <OFD7F7A9B4.F974A695-ON41256FB6.0032AFFD-41256FB6.0033EA43@de.ibm.com>
References: <20050225154340.6351ad34.davem@davemloft.net>
	<OFD7F7A9B4.F974A695-ON41256FB6.0032AFFD-41256FB6.0033EA43@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: benh@au1.ibm.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 28 Feb 2005 10:27:03 +0100
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> > In that case, please fix this simply by turning ptep_clear_flush()
> > (and thus ptep_establish) into a macro to fix the build as we have
> > done on the other platforms.
> 
> Please don't. There are too many macros from hell as things are now.
> I prefer to sort out the compile errors with my inline functions than
> to introduce more of that macro crap.
> 
> Simply expand the pte_clear inline into ptep_get_and_clear &
> ptep_clear_flush gets you around the problem with deferencing "vma"
> because on s390 we don't need the mm struct in pte_clear.

I'll do as you wish no problem.

But you will need to address this should you ever want to
experiment with batched TLB flushing.  And I highly encourage
anyone with TLBs lacking true range flushing in hardware to
do so :-)  It is such an incredible improvement.
