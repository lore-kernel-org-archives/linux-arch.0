From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [patch 01/41] cpu_alloc: Increase percpu area size to 128k
Date: Mon, 2 Jun 2008 10:58:17 -0700
Message-ID: <1FE6DD409037234FAB833C420AA843EC0177822B@orsmsx424.amr.corp.intel.com>
References: <20080530035620.587204923@sgi.com> <20080530040010.806208523@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56433 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753424AbYFBR6S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Jun 2008 13:58:18 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080530040010.806208523@sgi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>, akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Mike Travis <travis@sgi.com>

> The per cpu allocator requires more per cpu space and we are already near
> the limit on IA64. Increase the maximum size of the IA64 per cpu area from
> 64K to 128K.

> -#define PERCPU_PAGE_SHIFT	16	/* log2() of max. size of per-CPU area */
> +#define PERCPU_PAGE_SHIFT	17	/* log2() of max. size of per-CPU area */

Don't you need some more changes to the alt_dtlb_miss handler in
ivt.S for this to work?  128K is not a supported pagesize on any
processor model.

-Tony
