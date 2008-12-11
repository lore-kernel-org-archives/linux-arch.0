From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] make INIT_FS use the __RW_LOCK_UNLOCKED initialization
Date: Wed, 10 Dec 2008 19:01:17 -0500 (EST)
Message-ID: <alpine.DEB.1.10.0812101900080.21545@gandalf.stny.rr.com>
References: <alpine.DEB.1.10.0812101832200.21545@gandalf.stny.rr.com> <20081210234307.GI28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:37316 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820AbYLKABT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Dec 2008 19:01:19 -0500
In-Reply-To: <20081210234307.GI28946@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>


On Wed, 10 Dec 2008, Al Viro wrote:

> On Wed, Dec 10, 2008 at 06:37:28PM -0500, Steven Rostedt wrote:
> > 
> > The following patch is in:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git
> > 
> >     branch: cleanups
> 
> Would be better to take init_fs to something in fs/ or kernel/ and kill
> the duplicates, along with INIT_FS macro itself...

What about putting it in init/main.c?

It would then also need to become a global variable (it is currently 
static). But I do not think that should be an issue.

-- Steve
