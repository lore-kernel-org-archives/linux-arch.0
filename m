Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sat, 19 Mar 2005 23:38:52 -0800
Message-Id: <200503200738.j2K7cq0a015891@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH] Remove spurious BUG from posix-cpu-timers
In-Reply-To: Matthew Wilcox's message of  Saturday, 19 March 2005 04:59:20 +0000 <20050319045920.GL21986@parcelfarce.linux.theplanet.co.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

I put those BUG_ON's in places where I was using spin_lock on a lock that
requires irqs disabled.  Those places are called in contexts that already
require irqs disabled for some other reason, so I didn't use
irqsave/irqrestore there to skip the unnecessary overhead.  (Of course it's
the same the BUG_ON's have, but those can be compiled out.)  I really don't
recall at the moment if there was a deeper reason, i.e. that the code itself in
some other way relies on interrupts being disabled for its proper operation.
But I don't see any reason to change it.


Thanks,
Roland
