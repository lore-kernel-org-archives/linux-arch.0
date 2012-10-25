From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH] tile: support GENERIC_KERNEL_THREAD and GENERIC_KERNEL_EXECVE
Date: Thu, 25 Oct 2012 09:31:31 -0400
Message-ID: <50893F33.10700@tilera.com>
References: <20121016223508.GR2616@ZenIV.linux.org.uk> <201210192041.q9JKf7jD003998@farm-0010.internal.tilera.com> <20121019213548.GR2616@ZenIV.linux.org.uk> <5082A1F1.3080303@tilera.com> <20121020153401.GT2616@ZenIV.linux.org.uk> <20121020171643.GU2616@ZenIV.linux.org.uk> <5086D432.4070008@tilera.com> <20121023184122.GZ2616@ZenIV.linux.org.uk> <5086EE7C.2080608@tilera.com> <20121023203620.GA2616@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:29346 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759057Ab2JYNbd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 25 Oct 2012 09:31:33 -0400
In-Reply-To: <20121023203620.GA2616@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>

On 10/23/2012 4:36 PM, Al Viro wrote:
> Could you test the following on top of your patch?  It gets rid of
> regs use in sys_clone() *and* of the regs argument in copy_thread().
> If that work (including SMP - note that it changes the path taken
> by copy_thread() when called by fork_idle()), that should be all
> we'll need in arch/tile for killing idle_regs() and killing the pt_regs
> passing to do_fork()/copy_process()/copy_thread().

It seems to work fine.  Thanks!

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
