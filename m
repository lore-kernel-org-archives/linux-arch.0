From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [patch 1/2] read_barrier_depends fixlets
Date: Tue, 6 May 2008 12:09:18 -0700
Message-ID: <20080506190917.GA8369@linux.vnet.ibm.com>
References: <20080505112021.GC5018@wotan.suse.de> <15818.1210087753@redhat.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:37925 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765926AbYEFTJU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 May 2008 15:09:20 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m46J9KiJ027401
	for <linux-arch@vger.kernel.org>; Tue, 6 May 2008 15:09:20 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m46J9KHG217050
	for <linux-arch@vger.kernel.org>; Tue, 6 May 2008 13:09:20 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m46J9Jfb003306
	for <linux-arch@vger.kernel.org>; Tue, 6 May 2008 13:09:19 -0600
Content-Disposition: inline
In-Reply-To: <15818.1210087753@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Nick Piggin <npiggin@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Hugh Dickins <hugh@veritas.com>, linux-arch@vger.kernel.org, Linux Memory Management List <linux-mm@kvack.org>


> Nick Piggin <npiggin@suse.de> wrote:
> 
> > While considering the impact of read_barrier_depends, it occurred to
> > me that it should really be really a noop for the compiler.
> 
> If you're defining it so, then you need to adjust memory-barriers.txt too.
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

And to make sure the compiler preserves the ordering, you also need
the ACCESS_ONCE() in the general case.

							Thanx, Paul
