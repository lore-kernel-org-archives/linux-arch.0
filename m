From: Christoph Lameter <clameter@sgi.com>
Subject: RE: [patch 01/41] cpu_alloc: Increase percpu area size to 128k
Date: Tue, 10 Jun 2008 10:22:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0806101022190.17093@schroedinger.engr.sgi.com>
References: <20080530035620.587204923@sgi.com> <20080530040010.806208523@sgi.com>
 <1FE6DD409037234FAB833C420AA843EC0177822B@orsmsx424.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757691AbYFJRWy@vger.kernel.org>
In-Reply-To: <1FE6DD409037234FAB833C420AA843EC0177822B@orsmsx424.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Mike Travis <travis@sgi.com>
List-Id: linux-arch.vger.kernel.org

On Mon, 2 Jun 2008, Luck, Tony wrote:

> > The per cpu allocator requires more per cpu space and we are already near
> > the limit on IA64. Increase the maximum size of the IA64 per cpu area from
> > 64K to 128K.
> 
> > -#define PERCPU_PAGE_SHIFT	16	/* log2() of max. size of per-CPU area */
> > +#define PERCPU_PAGE_SHIFT	17	/* log2() of max. size of per-CPU area */
> 
> Don't you need some more changes to the alt_dtlb_miss handler in
> ivt.S for this to work?  128K is not a supported pagesize on any
> processor model.

Ok so this needs to be 18?
