From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [patch 00/41] cpu alloc / cpu ops v3: Optimize per cpu access
Date: Fri, 30 May 2008 12:00:22 -0600
Message-ID: <20080530180021.GJ22636@parisc-linux.org>
References: <20080530035620.587204923@sgi.com> <20080529215827.b659d032.akpm@linux-foundation.org> <Pine.LNX.4.64.0805292159360.12107@schroedinger.engr.sgi.com> <20080529222143.5d7aa1e5.akpm@linux-foundation.org> <Pine.LNX.4.64.0805292224540.12329@schroedinger.engr.sgi.com> <48401169.3050706@sgi.com> <Pine.LNX.4.64.0805301048070.14564@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:56786 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbYE3SAX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 14:00:23 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0805301048070.14564@schroedinger.engr.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Mike Travis <travis@sgi.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>

On Fri, May 30, 2008 at 10:50:04AM -0700, Christoph Lameter wrote:
> cpu alloc v2 had an extendable per cpu space. You have the patches. We 
> could put this on top of this patchset if necessary. But then it not so 
> nice and simple anymore. Maybe we can rstrict the use of cpu alloc 
> instead to users with objects < cache_line_size() or so?

Restricting the use of cpu_alloc based on size of object is no good when
you're trying to allocate 45,000 objects.  Extending the per CPU space
is the only option.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
