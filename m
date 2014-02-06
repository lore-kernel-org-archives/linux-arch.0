From: David Howells <dhowells@redhat.com>
Subject: Re: [RFC][PATCH 0/5] arch: atomic rework
Date: Thu, 06 Feb 2014 18:25:49 +0000
Message-ID: <21984.1391711149@warthog.procyon.org.uk>
References: <20140206134825.305510953@infradead.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46593 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150AbaBFS0Y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 6 Feb 2014 13:26:24 -0500
In-Reply-To: <20140206134825.305510953@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, mingo@kernel.org, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, ramana.radhakrishnan@arm.com


Is it worth considering a move towards using C11 atomics and barriers and
compiler intrinsics inside the kernel?  The compiler _ought_ to be able to do
these.

One thing I'm not sure of, though, is how well gcc's atomics will cope with
interrupt handlers touching atomics on CPUs without suitable atomic
instructions - that said, userspace does have to deal with signals getting
underfoot. but then userspace can't normally disable interrupts.

David
