Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nlpi129.sbcis.sbc.com ([207.115.36.143]:59768 "EHLO
	nlpi129.prodigy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755235Ab0CDSv3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Mar 2010 13:51:29 -0500
Date: Thu, 4 Mar 2010 12:47:12 -0600 (CST)
From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [PATCH/RFC 3/8] numa:  x86_64:  use generic percpu var for
 numa_node_id() implementation
In-Reply-To: <20100304170716.10606.24477.sendpatchset@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1003041245280.21776@router.home>
References: <20100304170654.10606.32225.sendpatchset@localhost.localdomain> <20100304170716.10606.24477.sendpatchset@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lee Schermerhorn <lee.schermerhorn@hp.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-numa@vger.kernel.org, Tejun Heo <tj@kernel.org>, Mel Gorman <mel@csn.ul.ie>, Andi Kleen <andi@firstfloor.org>, Nick Piggin <npiggin@suse.de>, David Rientjes <rientjes@google.com>, akpm@linux-foundation.org, eric.whitney@hp.com
Message-ID: <20100304184712.9A3gZDodV634vLWXQheYcxcpRueA9APr_IUVOeY7Sbg@z>

On Thu, 4 Mar 2010, Lee Schermerhorn wrote:

> Index: linux-2.6.33-mmotm-100302-1838/arch/x86/include/asm/percpu.h
> ===================================================================
> --- linux-2.6.33-mmotm-100302-1838.orig/arch/x86/include/asm/percpu.h
> +++ linux-2.6.33-mmotm-100302-1838/arch/x86/include/asm/percpu.h
> @@ -208,10 +208,12 @@ do {									\
>  #define percpu_or(var, val)		percpu_to_op("or", var, val)
>  #define percpu_xor(var, val)		percpu_to_op("xor", var, val)
>
> +#define __this_cpu_read(pcp)		percpu_from_op("mov", (pcp), "m"(pcp))
>  #define __this_cpu_read_1(pcp)		percpu_from_op("mov", (pcp), "m"(pcp))
>  #define __this_cpu_read_2(pcp)		percpu_from_op("mov", (pcp), "m"(pcp))
>  #define __this_cpu_read_4(pcp)		percpu_from_op("mov", (pcp), "m"(pcp))
>
> +#define __this_cpu_write(pcp, val)	percpu_to_op("mov", (pcp), val)
>  #define __this_cpu_write_1(pcp, val)	percpu_to_op("mov", (pcp), val)
>  #define __this_cpu_write_2(pcp, val)	percpu_to_op("mov", (pcp), val)
>  #define __this_cpu_write_4(pcp, val)	percpu_to_op("mov", (pcp), val)


The functions added are already defined in linux/percpu.h and their
definition here is wrong since the u64 case is not handled (percpu.h does
that correctly).

