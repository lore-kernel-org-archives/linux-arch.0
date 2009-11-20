From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [PATCH/RFC 2/6] numa:  x86_64:  use generic percpu var numa_node_id()
 implementation
Date: Fri, 20 Nov 2009 10:48:47 -0500 (EST)
Message-ID: <alpine.DEB.1.10.0911201047260.25879@V090114053VZO-1>
References: <20091113211714.15074.29078.sendpatchset@localhost.localdomain> <20091113211726.15074.92063.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20091113211726.15074.92063.sendpatchset@localhost.localdomain>
Sender: owner-linux-mm@kvack.org
To: Lee Schermerhorn <lee.schermerhorn@hp.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, Mel Gorman <mel@csn.ul.ie>, Christoph Lameter <clameter@sgi.com>, Nick Piggin <npiggin@suse.de>, David Rientjes <rientjes@google.com>, eric.whitney@hp.com
List-Id: linux-arch.vger.kernel.org

On Fri, 13 Nov 2009, Lee Schermerhorn wrote:

>     [I think!  What about cpu_to_node() func in x86/mm/numa_64.c ???]

If thats too early for per cpu operations then it cannot be used there.

> ===================================================================
> --- linux-2.6.32-rc5-mmotm-091101-1001.orig/arch/x86/include/asm/percpu.h
> +++ linux-2.6.32-rc5-mmotm-091101-1001/arch/x86/include/asm/percpu.h
> @@ -150,10 +150,12 @@ do {							\
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


What does percpu generic stuff do here?

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
