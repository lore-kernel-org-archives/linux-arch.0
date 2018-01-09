From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 16/18] net: mpls: prevent bounds-check bypass via speculative execution
Date: Mon, 08 Jan 2018 21:11:56 -0600
Message-ID: <87lgh7n2tf.fsf@xmission.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
        <151520108080.32271.16420298348259030860.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:51325 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbeAIDMn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jan 2018 22:12:43 -0500
In-Reply-To: <151520108080.32271.16420298348259030860.stgit@dwillia2-desk3.amr.corp.intel.com>
        (Dan Williams's message of "Fri, 05 Jan 2018 17:11:20 -0800")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, peterz@infradead.org, netdev@vger.kernel.org, gregkh@linuxfoundation.org, tglx@linutronix.de, torvalds@linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Elena Reshetova <elena.reshetova@intel.com>, alan@linux.intel.com

Dan Williams <dan.j.williams@intel.com> writes:

> Static analysis reports that 'index' may be a user controlled value that
> is used as a data dependency reading 'rt' from the 'platform_label'
> array.  In order to avoid potential leaks of kernel memory values, block
> speculative execution of the instruction stream that could issue further
> reads based on an invalid 'rt' value.


In detail.
a) This code is fast path packet forwarding code.  Introducing an
   unconditional pipeline stall is not ok.

   AKA either there is no speculation and so this is invulnerable
   or there is speculation and you are creating an unconditional
   pipeline stall here.

   My back of the napkin caluculations say that a pipeline stall
   is about 20 cycles.  Which is about the same length of time
   as a modern cache miss.

   On a good day this code will perform with 0 cache misses. On a less
   good day 1 cache miss.  Which means you are quite possibly doubling
   the runtime of mpls_forward.

b) The array is dynamically allocated which should provide some
   protection, as it will be more difficult to predict the address
   of the array which is needed to craft an malicious userspace value.

c) The code can be trivially modified to say:

static struct mpls_route *mpls_route_input_rcu(struct net *net, unsigned index)
{
	struct mpls_route *rt = NULL;

	if (index < net->mpls.platform_labels) {
		struct mpls_route __rcu **platform_label =
			rcu_dereference(net->mpls.platform_label);
		rt = rcu_dereference(platform_label[index & ((1 << 20) - 1)]);
	}
	return rt;
}

AKA a static mask will ensure that there is not a primitive that can be
used to access all of memory.  That is max a 1 cycle slowdown in the
code, which is a much better trade off.

d) If we care more it is straight forward to modify
   resize_platform_label_table() to ensure that the size of the array
   is always a power of 2.

e) The fact that a pointer is returned from the array and it is treated
   like a pointer would seem to provide a defense against the
   exfiltration technique of using the value read as an index into
   a small array, that user space code can probe aliased cached
   lines of, to see which value was dereferenced.


So to this patch in particular.
Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

This code path will be difficult to exploit.  This change messes with
performance.  There are ways to make this code path useless while
preserving the performance of the code.

Eric

>
> Based on an original patch by Elena Reshetova.
>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  net/mpls/af_mpls.c |   12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> index 8ca9915befc8..ebcf0e246cfe 100644
> --- a/net/mpls/af_mpls.c
> +++ b/net/mpls/af_mpls.c
> @@ -8,6 +8,7 @@
>  #include <linux/ipv6.h>
>  #include <linux/mpls.h>
>  #include <linux/netconf.h>
> +#include <linux/compiler.h>
>  #include <linux/vmalloc.h>
>  #include <linux/percpu.h>
>  #include <net/ip.h>
> @@ -77,12 +78,13 @@ static void rtmsg_lfib(int event, u32 label, struct mpls_route *rt,
>  static struct mpls_route *mpls_route_input_rcu(struct net *net, unsigned index)
>  {
>  	struct mpls_route *rt = NULL;
> +	struct mpls_route __rcu **platform_label =
> +		rcu_dereference(net->mpls.platform_label);
> +	struct mpls_route __rcu **rtp;
>  
> -	if (index < net->mpls.platform_labels) {
> -		struct mpls_route __rcu **platform_label =
> -			rcu_dereference(net->mpls.platform_label);
> -		rt = rcu_dereference(platform_label[index]);
> -	}
> +	if ((rtp = nospec_array_ptr(platform_label, index,
> +					net->mpls.platform_labels)))
> +		rt = rcu_dereference(*rtp);
>  	return rt;
>  }
>  
