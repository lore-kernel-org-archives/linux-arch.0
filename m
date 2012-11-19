From: David Miller <davem@davemloft.net>
Subject: Re: sigaltstack fun
Date: Sun, 18 Nov 2012 22:27:24 -0500 (EST)
Message-ID: <20121118.222724.1495808364736017374.davem@davemloft.net>
References: <20121119011013.GJ16916@ZenIV.linux.org.uk>
	<20121118.203005.151867624663051294.davem@davemloft.net>
	<20121119023507.GK16916@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:54341 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab2KSD10 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 18 Nov 2012 22:27:26 -0500
In-Reply-To: <20121119023507.GK16916@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: viro@ZenIV.linux.org.uk
Cc: torvalds@linux-foundation.org, monstr@monstr.eu, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Mon, 19 Nov 2012 02:35:07 +0000

> sparc64: not any error from do_sigaltstack() should fail rt_sigreturn()
> 
> If a signal handler is executed on altstack and another signal comes,
> we will end up with rt_sigreturn() on return from the second handler
> getting -EPERM from do_sigaltstack().  It's perfectly OK, since we
> are not asking to change the settings; in fact, they couldn't have been
> changed during the second handler execution exactly because we'd been
> on altstack all along.  64bit sigreturn on sparc treats any error from
> do_sigaltstack() as "SIGSEGV now"; we need to switch to the same semantics
> we are using on other architectures.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Applied, thanks.
