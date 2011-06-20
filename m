From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC] get_write_access()/deny_write_access() without
 inode->i_lock
Date: Mon, 20 Jun 2011 18:03:05 +0100
Message-ID: <20110620170305.GW11521@ZenIV.linux.org.uk>
References: <20110619235147.GQ11521@ZenIV.linux.org.uk>
 <BANLkTimdPT2dbTToTHGVzJr=f3xPKT9tZw@mail.gmail.com>
 <20110620161352.GT11521@ZenIV.linux.org.uk>
 <BANLkTikUi9M1Mx4L54vJOP0SK0P3yAz=uQ@mail.gmail.com>
 <20110620164211.GV11521@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:46437 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab1FTRDH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2011 13:03:07 -0400
Content-Disposition: inline
In-Reply-To: <20110620164211.GV11521@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jun 20, 2011 at 05:42:11PM +0100, Al Viro wrote:

> BTW, atomic_add_unless/atomic_inc_not_zero is done as read/cmpxchg on
> everything I've checked, including alpha and sparc.  I suspect that
> it's seriously suboptimal there...

Actually, on sparc it's probably fine.  alpha, OTOH, probably ought to switch
to something similar to what ppc is doing...
