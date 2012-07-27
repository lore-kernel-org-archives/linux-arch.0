Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:36970 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164Ab2G0IDx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Jul 2012 04:03:53 -0400
Message-ID: <1343376091.32120.23.camel@twins>
Subject: Re: [RFC][PATCH 0/2] fun with tlb flushing on s390
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 27 Jul 2012 10:01:31 +0200
In-Reply-To: <20120727085718.19c33cce@de.ibm.com>
References: <1343317634-13197-1-git-send-email-schwidefsky@de.ibm.com>
	 <1343331770.32120.6.camel@twins> <20120727085718.19c33cce@de.ibm.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Mime-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, Zachary Amsden <zach@vmware.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Message-ID: <20120727080131.C5t5ADsWhnsXWfmrtUdaNMyhwAtEoeMxREIGlq6_8B4@z>

On Fri, 2012-07-27 at 08:57 +0200, Martin Schwidefsky wrote:
> > > powerpc 
> > 
> > I have a patch that makes sparc64 do the same thing.
> 
> That is good, I guess we are in agreement then to add the mm
> argument. 

Ah, what I meant was make sparc64 use the lazy_mmu stuff just like ppc64
does. I haven't so far had a need for extra arguments.


