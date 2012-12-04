From: David Miller <davem@davemloft.net>
Subject: Re: sigaltstack fun
Date: Mon, 03 Dec 2012 21:58:46 -0500 (EST)
Message-ID: <20121203.215846.206188196607010695.davem@davemloft.net>
References: <20121119023507.GK16916@ZenIV.linux.org.uk>
	<20121118.222724.1495808364736017374.davem@davemloft.net>
	<20121126051002.GB4939@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:43219 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab2LDC6v (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 Dec 2012 21:58:51 -0500
In-Reply-To: <20121126051002.GB4939@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: viro@ZenIV.linux.org.uk
Cc: torvalds@linux-foundation.org, monstr@monstr.eu, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Mon, 26 Nov 2012 05:10:02 +0000

> On Sun, Nov 18, 2012 at 10:27:24PM -0500, David Miller wrote:
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>> 
>> Applied, thanks.
> 
> Hmm...  There's something odd going on with {rt_,}sigaction on sparc -
> we *do* have sa_restorer in struct sigaction and struct old_sigaction,
> but it's not used for anything whatsoever.  There's also a separately
> passed restorer pointer for rt_sigaction() and *that* is used instead,
> but not reported via *oact.
> 
> What's the reason for that weirdness?  I understand why we do that on
> alpha (we have no sa_restorer in struct sigaction we'd inherited from
> OSF/1), but sparc always had perfectly normal sigaction->sa_restorer
> field all along - even for old sigaction(2)...

I have no idea how things got this way.

In the old sigaction() we do use the sa_restorer, and for both RT and
non-RT sigaction, we do fill in the sa_restorer member for the old
sigaction returned.

This special 'restorer' argument overrides the sigaction one.

GLIBC wraps calls to this system call, see:

sysdeps/unix/sysv/linux/sparc/sparc32/sigaction.c
sysdeps/unix/sysv/linux/sparc/sparc64/sigaction.c

I wish I had more context and info, but I don't :-(
