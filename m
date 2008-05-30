From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 00/41] cpu alloc / cpu ops v3: Optimize per cpu access
Date: Fri, 30 May 2008 10:50:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0805301048070.14564@schroedinger.engr.sgi.com>
References: <20080530035620.587204923@sgi.com> <20080529215827.b659d032.akpm@linux-foundation.org>
 <Pine.LNX.4.64.0805292159360.12107@schroedinger.engr.sgi.com>
 <20080529222143.5d7aa1e5.akpm@linux-foundation.org>
 <Pine.LNX.4.64.0805292224540.12329@schroedinger.engr.sgi.com>
 <48401169.3050706@sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:60997 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752111AbYE3RuG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 13:50:06 -0400
In-Reply-To: <48401169.3050706@sgi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Travis <travis@sgi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>

On Fri, 30 May 2008, Mike Travis wrote:

> > No there is no limit. It just wastes lots of space (pointer arrays, 
> > alignment etc) that we could use to configure sufficiently large per cpu 
> > areas.
> 
> Is there any reason why the per_cpu area couldn't be made extensible?  Maybe
> a simple linked list of available areas?  (And use a config variable and/or
> boot param for initial size and increment size?)  [Ignoring the problem of
> reclaiming the space...]

cpu alloc v2 had an extendable per cpu space. You have the patches. We 
could put this on top of this patchset if necessary. But then it not so 
nice and simple anymore. Maybe we can rstrict the use of cpu alloc 
instead to users with objects < cache_line_size() or so?
