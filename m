From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 00/31] Clean up smp_mb__ barriers
Date: Wed, 19 Mar 2014 10:07:19 +0000
Message-ID: <13861.1395223639@warthog.procyon.org.uk>
References: <20140319095807.GF27632@laptop.programming.kicks-ass.net> <20140319064729.660482086@infradead.org> <13632.1395222905@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37401 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756193AbaCSKIB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 19 Mar 2014 06:08:01 -0400
In-Reply-To: <20140319095807.GF27632@laptop.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, mingo@kernel.org, will.deacon@arm.com, paulmck@linux.vnet.ibm.com

Peter Zijlstra <peterz@infradead.org> wrote:

> > Shouldn't the mass-conversion patch (patch 31) go first?
> 
> You mean; make the kernel use primitives that aren't there yet?

Never mind.  I misread the conditionals in patch 3 adding the deprecated
versions.

David
