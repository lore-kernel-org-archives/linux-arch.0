From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v9 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
Date: Tue, 30 Aug 2016 17:46:41 +0200
Message-ID: <20160830154641.GD4554@pathway.suse.cz>
References: <1472487169-14923-1-git-send-email-cmetcalf@mellanox.com>
 <1472487169-14923-5-git-send-email-cmetcalf@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754042AbcH3Pqu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Aug 2016 11:46:50 -0400
Content-Disposition: inline
In-Reply-To: <1472487169-14923-5-git-send-email-cmetcalf@mellanox.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon 2016-08-29 12:12:49, Chris Metcalf wrote:
> When doing an nmi backtrace of many cores, most of which are idle,
> the output is a little overwhelming and very uninformative.  Suppress
> messages for cpus that are idling when they are interrupted and just
> emit one line, "NMI backtrace for N skipped: idling at pc 0xNNN".
> 
> We do this by grouping all the cpuidle code together into a new
> .cpuidle.text section, and then checking the address of the
> interrupted PC to see if it lies within that section.
> 
> This commit suitably tags x86 and tile idle routines, and only
> adds in the minimal framework for other architectures.
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Daniel Thompson <daniel.thompson@linaro.org> [arm]
> Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>

This version works even with my configuration. Feel free to
add

Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
