From: David Miller <davem@davemloft.net>
Subject: Re: [RFC] TIF_NOTIFY_RESUME, arch/*/*/*signal*.c and all such
Date: Thu, 26 Apr 2012 03:25:28 -0400 (EDT)
Message-ID: <20120426.032528.2066041048224573812.davem@davemloft.net>
References: <20120425170230.GA24977@redhat.com>
	<20120425175113.GI6871@ZenIV.linux.org.uk>
	<20120426091519.49eef9aa@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:57387 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087Ab2DZH0z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Apr 2012 03:26:55 -0400
In-Reply-To: <20120426091519.49eef9aa@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: viro@ZenIV.linux.org.uk, oleg@redhat.com, torvalds@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, tj@kernel.org, arnd@arndb.de, roland@hack.frob.com

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 26 Apr 2012 09:15:19 +0200

> You need to be careful with inferior calls there. gdb likes to play games
> with the registers inside the get_signal_to_deliver call, it wants to be
> able to jump out of an interrupted system call, do its inferior call in
> the debugee and then return to the interrupted system call.
> You would have to to read, modify & restore the NEED_RESTART flag in gdb
> over an inferior call.

Right and this is what orig_ax and friends are used for on x86.
