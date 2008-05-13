From: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch 1/2] read_barrier_depends fixlets
Date: Tue, 13 May 2008 10:05:15 +0200
Message-ID: <20080513080515.GC19870@wotan.suse.de>
References: <20080505112021.GC5018@wotan.suse.de> <15818.1210087753@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38372 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757205AbYEMIFR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 May 2008 04:05:17 -0400
Content-Disposition: inline
In-Reply-To: <15818.1210087753@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Hugh Dickins <hugh@veritas.com>, linux-arch@vger.kernel.org, Linux Memory Management List <linux-mm@kvack.org>, Paul McKenney <paulmck@us.ibm.com>

On Tue, May 06, 2008 at 04:29:13PM +0100, David Howells wrote:
> Nick Piggin <npiggin@suse.de> wrote:
> 
> > While considering the impact of read_barrier_depends, it occurred to
> > me that it should really be really a noop for the compiler.
> 
> If you're defining it so, then you need to adjust memory-barriers.txt too.

_I'm_ not defining it so, it has always been defined so (code speaks
louder than words). So this document has always been wrong.i

> 
> 	========================
> 	EXPLICIT KERNEL BARRIERS
> 	========================
> 	...
> 	CPU MEMORY BARRIERS
> 	-------------------
> 
> 	The Linux kernel has eight basic CPU memory barriers:
> 
> 		TYPE		MANDATORY		SMP CONDITIONAL
> 		===============	=======================	===========================
> 		GENERAL		mb()			smp_mb()
> 		WRITE		wmb()			smp_wmb()
> 		READ		rmb()			smp_rmb()
> 		DATA DEPENDENCY	read_barrier_depends()	smp_read_barrier_depends()
> 
> 
> 	All CPU memory barriers unconditionally imply compiler barriers.
> 
> That last line needs modification, perhaps to say:
> 
> 	General, read and write memory barriers unconditionally imply general
> 	compiler barriers; data dependency barriers, however, imply a barrier
> 	only for the specific access being performed due to the fact that the
> 	instructions must be performed in a specific order.
> 
> David
