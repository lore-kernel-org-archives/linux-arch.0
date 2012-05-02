From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC] TIF_NOTIFY_RESUME, arch/*/*/*signal*.c and all such
Date: Wed, 2 May 2012 18:24:53 +0100
Message-ID: <20120502172453.GL6871@ZenIV.linux.org.uk>
References: <20120426231942.GJ6871@ZenIV.linux.org.uk>
 <20120429180535.GZ6871@ZenIV.linux.org.uk>
 <20120501043129.GF6871@ZenIV.linux.org.uk>
 <201205010106.38495.vapier@gentoo.org>
 <20120501055226.GH6871@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:51851 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755269Ab2EBRY4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 2 May 2012 13:24:56 -0400
Content-Disposition: inline
In-Reply-To: <20120501055226.GH6871@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Frysinger <vapier@gentoo.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>

On Tue, May 01, 2012 at 06:52:26AM +0100, Al Viro wrote:
> IOW, here's what I'd suggest doing:
> 
> * add that regs->orig_p0 = -1; to handle_restart()
> * add jump .Lresume_userspace_1 after the call of do_notify_resume()
> * instead of RESTORE_CONTEXT/rti in ret_from_fork and kernel_execve()
> have them jump to .Lresume_userspace.

arrrgh...  The last one is unfortunately not so simple - you have that
in the guts of _system_call, which is called via pseudo_long_call,
so it would ought to be a call into the middle of _system_call, followed
by that RESTORE_CONTEXT/rti...
