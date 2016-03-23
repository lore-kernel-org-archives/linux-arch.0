From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
Date: Wed, 23 Mar 2016 08:53:59 +0100
Message-ID: <20160323075359.GH6356@twins.programming.kicks-ass.net>
References: <1458667179-19630-1-git-send-email-cmetcalf@mellanox.com>
 <54039485.X1biSGXPBa@vostro.rjw.lan>
 <20160322224557.GG6356@twins.programming.kicks-ass.net>
 <8028886.DUEJzF47F1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:59049 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752820AbcCWHyK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 Mar 2016 03:54:10 -0400
Content-Disposition: inline
In-Reply-To: <8028886.DUEJzF47F1@vostro.rjw.lan>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Chris Metcalf <cmetcalf@mellanox.com>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, Mar 23, 2016 at 01:50:00AM +0100, Rafael J. Wysocki wrote:

> > > Well, what about intel_idle_freeze()?  Or do we not care?
> > 
> > I argued against it; when you're suspended the NMI watchdog is stopped
> > too.
> 
> Is it also stopped for suspend-to-idle?  I'm not sure about that.
> 
> Where do I need to look to find out?

Hmm I have memories of writing a patch to that effect when we were
starting with that suspend-to-idle stuff, because people didn't like
being woken up all the time.

But now that I look I cannot find it either..
