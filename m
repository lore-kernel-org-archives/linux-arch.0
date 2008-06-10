From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [patch 01/41] cpu_alloc: Increase percpu area size to 128k
Date: Tue, 10 Jun 2008 12:54:44 -0700
Message-ID: <1FE6DD409037234FAB833C420AA843EC0188382F@orsmsx424.amr.corp.intel.com>
References: <20080530035620.587204923@sgi.com> <20080530040010.806208523@sgi.com> <1FE6DD409037234FAB833C420AA843EC0177822B@orsmsx424.amr.corp.intel.com> <Pine.LNX.4.64.0806101022190.17093@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:31132 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257AbYFJTyq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jun 2008 15:54:46 -0400
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.64.0806101022190.17093@schroedinger.engr.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Mike Travis <travis@sgi.com>

> > > -#define PERCPU_PAGE_SHIFT	16	/* log2() of max. size of per-CPU area */
> > > +#define PERCPU_PAGE_SHIFT	17	/* log2() of max. size of per-CPU area */
> > 
> > Don't you need some more changes to the alt_dtlb_miss handler in
> > ivt.S for this to work?  128K is not a supported pagesize on any
> > processor model.
>
> Ok so this needs to be 18?

Yes. 18 will work (256K is an architected page size, guaranteed to be supported
by all processor models ... SDM 2:52 table 4-4).

-Tony
