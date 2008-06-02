From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 01/41] cpu_alloc: Increase percpu area size to 128k
Date: Tue, 3 Jun 2008 09:48:25 +1000
Message-ID: <200806030948.25448.rusty@rustcorp.com.au>
References: <20080530035620.587204923@sgi.com> <20080530040010.806208523@sgi.com> <1FE6DD409037234FAB833C420AA843EC0177822B@orsmsx424.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:41738 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753291AbYFBXv1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 2 Jun 2008 19:51:27 -0400
In-Reply-To: <1FE6DD409037234FAB833C420AA843EC0177822B@orsmsx424.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Christoph Lameter <clameter@sgi.com>, akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Mike Travis <travis@sgi.com>

On Tuesday 03 June 2008 03:58:17 Luck, Tony wrote:
> > The per cpu allocator requires more per cpu space and we are already near
> > the limit on IA64. Increase the maximum size of the IA64 per cpu area
> > from 64K to 128K.
> >
> > -#define PERCPU_PAGE_SHIFT	16	/* log2() of max. size of per-CPU area */
> > +#define PERCPU_PAGE_SHIFT	17	/* log2() of max. size of per-CPU area */
>
> Don't you need some more changes to the alt_dtlb_miss handler in
> ivt.S for this to work?  128K is not a supported pagesize on any
> processor model.

Yes, this was one of the issues with IA64 and extending the per-cpu area.  
It's probable that the IA64 TLB nailing trick might have to give way for 
dynamic per-cpu...

Rusty.
