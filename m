Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:59736 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764Ab1DUWTM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 Apr 2011 18:19:12 -0400
Received: from hpaq14.eem.corp.google.com (hpaq14.eem.corp.google.com [172.25.149.14])
	by smtp-out.google.com with ESMTP id p3LMJ9aZ019525
	for <linux-arch@vger.kernel.org>; Thu, 21 Apr 2011 15:19:09 -0700
Received: from pvf33 (pvf33.prod.google.com [10.241.210.97])
	by hpaq14.eem.corp.google.com with ESMTP id p3LMHxlw023330
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Thu, 21 Apr 2011 15:19:07 -0700
Received: by pvf33 with SMTP id 33so102559pvf.24
        for <linux-arch@vger.kernel.org>; Thu, 21 Apr 2011 15:19:07 -0700 (PDT)
Date: Thu, 21 Apr 2011 15:19:01 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v3] mm: make expand_downwards symmetrical to
 expand_upwards
In-Reply-To: <1303401997.4025.8.camel@mulgrave.site>
Message-ID: <alpine.DEB.2.00.1104211517150.20201@chino.kir.corp.google.com>
References: <20110420102314.4604.A69D9226@jp.fujitsu.com> <BANLkTi=mxWwLPEnB+rGg29b06xNUD0XvsA@mail.gmail.com> <20110420161615.462D.A69D9226@jp.fujitsu.com> <BANLkTimfpY3gq8oY6bPDajBW7JN6Hp+A0A@mail.gmail.com> <20110420112020.GA31296@parisc-linux.org>
 <BANLkTim+m-v-4k17HUSOYSbmNFDtJTgD6g@mail.gmail.com> <1303308938.2587.8.camel@mulgrave.site> <alpine.DEB.2.00.1104200943580.9266@router.home> <1303311779.2587.19.camel@mulgrave.site> <alpine.DEB.2.00.1104201018360.9266@router.home>
 <alpine.DEB.2.00.1104201437180.31768@chino.kir.corp.google.com> <1303401997.4025.8.camel@mulgrave.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, Matthew Wilcox <matthew@wil.cx>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-parisc@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, x86 maintainers <x86@kernel.org>, linux-arch@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>
Message-ID: <20110421221901.H6B7mBmfqiiP-j-d5Wq5PkdmD0kpj8XcQqrTSwpSbXk@z>

On Thu, 21 Apr 2011, James Bottomley wrote:

> diff --git a/mm/slub.c b/mm/slub.c
> index 94d2a33..243bd9c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -235,7 +235,11 @@ int slab_is_available(void)
>  
>  static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
>  {
> +#ifdef CONFIG_NUMA
>  	return s->node[node];
> +#else
> +	return s->node[0];
> +#endif
>  }
>  
>  /* Verify that a pointer has an address that is valid within a slab page */

Looks like parisc may have been just fine before 7340cc84141d (slub: 
reduce differences between SMP and NUMA), which was merged into 2.6.37?
