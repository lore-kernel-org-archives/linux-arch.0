From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH] kmap_atomic_push
Date: Fri, 09 Oct 2009 00:29:02 +0200
Message-ID: <1255040942.17055.21.camel@laptop>
References: <1255016123.17055.17.camel@laptop> <13417.1255039961@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:46137 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755075AbZJHWaA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Oct 2009 18:30:00 -0400
In-Reply-To: <13417.1255039961@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, "hugh.dickins" <hugh.dickins@tiscali.co.uk>, lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Thu, 2009-10-08 at 23:12 +0100, David Howells wrote:
> Do we have any code that uses two slots and then calls more code that
> ultimately requires further slots?  In other words, do we need more than two
> slots?

I can think of code that does a lot more than that, suppose you have
both KM_USER[01], get an interrupt that takes KM_IRQ[01], take an NMI
that takes KM_NMI.

Maybe we can stack the SOFTIRQ ones in as well ;-)
