From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 00/41] cpu alloc / cpu ops v3: Optimize per cpu access
Date: Fri, 30 May 2008 11:12:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0805301111570.14564@schroedinger.engr.sgi.com>
References: <20080530035620.587204923@sgi.com> <20080529215827.b659d032.akpm@linux-foundation.org>
 <Pine.LNX.4.64.0805292159360.12107@schroedinger.engr.sgi.com>
 <20080529222143.5d7aa1e5.akpm@linux-foundation.org>
 <Pine.LNX.4.64.0805292224540.12329@schroedinger.engr.sgi.com>
 <48401169.3050706@sgi.com> <Pine.LNX.4.64.0805301048070.14564@schroedinger.engr.sgi.com>
 <20080530180021.GJ22636@parisc-linux.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:33467 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752753AbYE3SMS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 14:12:18 -0400
In-Reply-To: <20080530180021.GJ22636@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Mike Travis <travis@sgi.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>

On Fri, 30 May 2008, Matthew Wilcox wrote:

> On Fri, May 30, 2008 at 10:50:04AM -0700, Christoph Lameter wrote:
> > cpu alloc v2 had an extendable per cpu space. You have the patches. We 
> > could put this on top of this patchset if necessary. But then it not so 
> > nice and simple anymore. Maybe we can rstrict the use of cpu alloc 
> > instead to users with objects < cache_line_size() or so?
> 
> Restricting the use of cpu_alloc based on size of object is no good when
> you're trying to allocate 45,000 objects.  Extending the per CPU space
> is the only option.

Ok guess we need to bring the virtually mapped per cpu patches forward.
