From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] make INIT_FS use the __RW_LOCK_UNLOCKED initialization
Date: Thu, 11 Dec 2008 22:22:28 +0100
Message-ID: <20081211212228.GB27223@uranus.ravnborg.org>
References: <alpine.DEB.1.10.0812101832200.21545@gandalf.stny.rr.com> <20081210234307.GI28946@ZenIV.linux.org.uk> <8bd0f97a0812101707p7df7745dk9840b05c0b26184b@mail.gmail.com> <alpine.DEB.1.10.0812102010100.29200@gandalf.stny.rr.com> <20081211023439.GJ28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pfepb.post.tele.dk ([195.41.46.236]:52692 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756099AbYLKVVC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Dec 2008 16:21:02 -0500
Content-Disposition: inline
In-Reply-To: <20081211023439.GJ28946@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mike Frysinger <vapier.adi@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>

> 
> Guys, let's not take it to init/main.c, please.  That file is basically
> a trashcan and I'd rather take that stuff to more or less relevant places
> in kernel/* and fs/*.  FWIW, I've done that with init_files (fs/file.c)
> some time ago.  For init_fs...  Hell knows.  Might make sense to take
> that to separate file, actually (kernel/exit.c and kernel/fork.c bits
> related to fs_struct).
> 
> BTW, why does sparc64 export put_fs_struct?
I have sent a patch to davem now to get it removed.

	Sam
