From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [PATCH/RFC 6/6] numa: slab:  use numa_mem_id() for slab local
 memory node
Date: Fri, 20 Nov 2009 10:56:16 -0500 (EST)
Message-ID: <alpine.DEB.1.10.0911201054320.25879@V090114053VZO-1>
References: <20091113211714.15074.29078.sendpatchset@localhost.localdomain> <20091113211823.15074.1305.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.ultrahosting.com ([74.213.174.254]:37930 "EHLO
	smtp.ultrahosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048AbZKTQAh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Nov 2009 11:00:37 -0500
Received: from localhost (smtp.ultrahosting.com [127.0.0.1])
	by smtp.ultrahosting.com (Postfix) with ESMTP id E2E9D82C37E
	for <linux-arch@vger.kernel.org>; Fri, 20 Nov 2009 11:00:43 -0500 (EST)
Received: from smtp.ultrahosting.com ([74.213.174.254])
	by localhost (smtp.ultrahosting.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ihhUwmvhUyQV for <linux-arch@vger.kernel.org>;
	Fri, 20 Nov 2009 11:00:43 -0500 (EST)
Received: from V090114053VZO-1 (unknown [74.213.171.31])
	by smtp.ultrahosting.com (Postfix) with ESMTP id 4B6A182C340
	for <linux-arch@vger.kernel.org>; Fri, 20 Nov 2009 10:59:34 -0500 (EST)
In-Reply-To: <20091113211823.15074.1305.sendpatchset@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lee Schermerhorn <lee.schermerhorn@hp.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, Mel Gorman <mel@csn.ul.ie>, Christoph Lameter <clameter@sgi.com>, Nick Piggin <npiggin@suse.de>, David Rientjes <rientjes@google.com>, eric.whitney@hp.com, Pekka Enberg <penberg@cs.helsinki.fi>

On Fri, 13 Nov 2009, Lee Schermerhorn wrote:

> N.B.:  incomplete.  slab will need to handle node and memory hotplug
> that could change the value returned by numa_mem_id() for any given
> node.  This will be addressed by a subsequent patch, if we decide to
> go this route.

It needs to be verified that this actually works. Locking is highly
depending on numa locality in slab. Can you run this under load with
lockdep? See also the lockdep issue that Pekka is dealing with right now.

>
> 2.6.32-rc5+mmotm-091101		no-patch	this-patch
> no memoryless nodes [avg of 10]:  12.700	  12.856  ~1.2%
> cpus all on memless nodes  [20]: 261.530	  27.700 ~10x speedup

This is due to memoryless nodes being able to use per cpu queues in slab
now. So far memoryless nodes always use fallback_alloc().
