Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268342AbUHKXRK@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:64953 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268340AbUHKXQR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 19:16:17 -0400
Date: Wed, 11 Aug 2004 16:15:37 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: clear_user_highpage()
Message-Id: <20040811161537.5e24c2b6.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: torvalds@osdl.org
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


During a kernel build, this is what tops the profiling charts
for me on sparc64 currently.  This drives me crazy :-)

I've optimized the sparc64 page zero as much as I possibly
could, so that's not worth tinkering with any longer.

The PPC people used to zero out pages in the cpu idle loop
and I'd definitely like to do something along those lines
on sparc64 as well, I feel it would be extremely effective.

There is a lot of code path in there for alloc_pages_vma().
I don't think adding arch overridable stuff is the way
to go here.  Something generic in the per-cpu hot/cold
page list handling that the cpu_idle() loop of each architecture
could call.

Perhaps a page flags bit that says "pre-zeroed" or something.
Then my clear_user_page() code on sparc64 could just test the
page bit and return if it is set.  Page free would need to
clear that bit of course.

I have no real concrete ideas, but I know that while looking
at some source code in an editor, my cpus could zero out all
the free pages in the system in a second or two :-)

Comments?
