From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Wed, 03 Jan 2018 23:01:06 -0600
Message-ID: <87vagiusj1.fsf@xmission.com>
References: <20180103223827.39601-1-mark.rutland@arm.com>
        <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
        <20180104010754.22ca6a74@alans-desktop>
        <alpine.LRH.2.00.1801040221070.27010@gjva.wvxbf.pm>
        <CAPcyv4ic=X3nMz7deg9NMyvj994+SM9XYoP0u7WvgKaAFSGAYw@mail.gmail.com>
        <CA+55aFx7eJqRA8EWwSCrC+Lr1ZjUvRXSuhrxo+af_Dx3YWKbOQ@mail.gmail.com>
        <1515035438.20588.4.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:38220 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeADFBs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jan 2018 00:01:48 -0500
In-Reply-To: <1515035438.20588.4.camel@intel.com> (Dan J. Williams's message
        of "Thu, 4 Jan 2018 03:10:51 +0000")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "alan@linux.intel.com" <alan@linux.intel.com>, "Reshetova, Elena" <elena.reshetova@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "gnomes@lxorguk.ukuu.org.uk" <gnomes@lxorguk.ukuu.org.uk>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jikos@kernel.org" <jikos@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

"Williams, Dan J" <dan.j.williams@intel.com> writes:



> Note that these are "a human looked at static analysis reports and
> could not rationalize that these are false positives". Specific domain
> knowledge about these paths may find that some of them are indeed false
> positives.
>
> The change to m_start in kernel/user_namespace.c is interesting because
> that's an example where the nospec_load() approach by itself would need
> to barrier speculation twice whereas if_nospec can do it once for the
> whole block.


This user_namespace.c change is very convoluted for what it is trying to
do.  It simplifies to a one liner that just adds osb() after pos >=
extents. AKA:

	if (pos >= extents)
        	return NULL;
+ 	osb();

Is the intent to hide which branch branch we take based on extents,
after the pos check?

I suspect this implies that using a user namespace and a crafted uid
map you can hit this in stat, on the fast path.

At which point I suspect we will be better off extending struct
user_namespace by a few pointers, so there is no union and remove the
need for blocking speculation entirely.

> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 246d4d4ce5c7..aa0be8cef2d4 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -648,15 +648,18 @@ static void *m_start(struct seq_file *seq, loff_t *ppos,
>  {
>  	loff_t pos = *ppos;
>  	unsigned extents = map->nr_extents;
> -	smp_rmb();
>  
> -	if (pos >= extents)
> -		return NULL;
> +	/* paired with smp_wmb in map_write */
> +	smp_rmb();
>  
> -	if (extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
> -		return &map->extent[pos];
> +	if (pos < extents) {
> +		osb();
> +		if (extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
> +			return &map->extent[pos];
> +		return &map->forward[pos];
> +	}
>  
> -	return &map->forward[pos];
> +	return NULL;
>  }
>  
>  static void *uid_m_start(struct seq_file *seq, loff_t *ppos)



> diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> index 8ca9915befc8..7f83abdea255 100644
> --- a/net/mpls/af_mpls.c
> +++ b/net/mpls/af_mpls.c
> @@ -81,6 +81,8 @@ static struct mpls_route *mpls_route_input_rcu(struct net *net, unsigned index)
>  	if (index < net->mpls.platform_labels) {
>  		struct mpls_route __rcu **platform_label =
>  			rcu_dereference(net->mpls.platform_label);
> +
> +		osb();
>  		rt = rcu_dereference(platform_label[index]);
>  	}
>  	return rt;

Ouch!  This adds a barrier in the middle of an rcu lookup, on the
fast path for routing mpls packets.  Which if memory serves will
noticably slow down software processing of mpls packets.

Why does osb() fall after the branch for validity?  So that we allow
speculation up until then? 

I suspect it would be better to have those barriers in the tun/tap
interfaces where userspace can inject packets and thus time them.  Then
the code could still speculate and go fast for remote packets.

Or does the speculation stomping have to be immediately at the place
where we use data from userspace to perform a table lookup?

Eric

p.s. osb() seems to be mispelled. obs() would make much more sense.
