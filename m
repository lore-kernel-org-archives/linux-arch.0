From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] make INIT_FS use the __RW_LOCK_UNLOCKED initialization
Date: Wed, 10 Dec 2008 23:43:07 +0000
Message-ID: <20081210234307.GI28946@ZenIV.linux.org.uk>
References: <alpine.DEB.1.10.0812101832200.21545@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:40465 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045AbYLJXnK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Dec 2008 18:43:10 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0812101832200.21545@gandalf.stny.rr.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Dec 10, 2008 at 06:37:28PM -0500, Steven Rostedt wrote:
> 
> The following patch is in:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git
> 
>     branch: cleanups

Would be better to take init_fs to something in fs/ or kernel/ and kill
the duplicates, along with INIT_FS macro itself...
