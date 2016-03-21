From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
Date: Mon, 21 Mar 2016 22:49:35 +0100
Message-ID: <20160321214935.GF6344@twins.programming.kicks-ass.net>
References: <1458147733-29338-1-git-send-email-cmetcalf@mellanox.com>
 <1458147733-29338-5-git-send-email-cmetcalf@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:56272 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbcCUVtt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2016 17:49:49 -0400
Content-Disposition: inline
In-Reply-To: <1458147733-29338-5-git-send-email-cmetcalf@mellanox.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Wed, Mar 16, 2016 at 01:02:13PM -0400, Chris Metcalf wrote:
> When doing an nmi backtrace of many cores, most of which are idle,
> the output is a little overwhelming and very uninformative.  Suppress
> messages for cpus that are idling when they are interrupted and just
> emit one line, "NMI backtrace for N skipped: idling at pc 0xNNN".

This is still 100+ lines on a modern system, but better than the many
many thousands it would otherwise generate.

> We do this by grouping all the cpuidle code together into a new
> .cpuidle.text section, and then checking the address of the
> interrupted PC to see if it lies within that section.
> 
> Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Please Cc Rafael on the next posting.
