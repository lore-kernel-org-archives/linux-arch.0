From: David Howells <dhowells@redhat.com>
Subject: Re: [patch 1/2] read_barrier_depends fixlets
Date: Tue, 06 May 2008 16:29:13 +0100
Message-ID: <15818.1210087753@redhat.com>
References: <20080505112021.GC5018@wotan.suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:43427 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755064AbYEFPaS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 6 May 2008 11:30:18 -0400
In-Reply-To: <20080505112021.GC5018@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: dhowells@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>, Hugh Dickins <hugh@veritas.com>, linux-arch@vger.kernel.org, Linux Memory Management List <linux-mm@kvack.org>, Paul McKenney <paulmck@us.ibm.com>

Nick Piggin <npiggin@suse.de> wrote:

> While considering the impact of read_barrier_depends, it occurred to
> me that it should really be really a noop for the compiler.

If you're defining it so, then you need to adjust memory-barriers.txt too.

	========================
	EXPLICIT KERNEL BARRIERS
	========================
	...
	CPU MEMORY BARRIERS
	-------------------

	The Linux kernel has eight basic CPU memory barriers:

		TYPE		MANDATORY		SMP CONDITIONAL
		===============	=======================	===========================
		GENERAL		mb()			smp_mb()
		WRITE		wmb()			smp_wmb()
		READ		rmb()			smp_rmb()
		DATA DEPENDENCY	read_barrier_depends()	smp_read_barrier_depends()


	All CPU memory barriers unconditionally imply compiler barriers.

That last line needs modification, perhaps to say:

	General, read and write memory barriers unconditionally imply general
	compiler barriers; data dependency barriers, however, imply a barrier
	only for the specific access being performed due to the fact that the
	instructions must be performed in a specific order.

David
