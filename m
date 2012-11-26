From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: sigaltstack fun
Date: Mon, 26 Nov 2012 05:10:02 +0000
Message-ID: <20121126051002.GB4939@ZenIV.linux.org.uk>
References: <20121119011013.GJ16916@ZenIV.linux.org.uk>
 <20121118.203005.151867624663051294.davem@davemloft.net>
 <20121119023507.GK16916@ZenIV.linux.org.uk>
 <20121118.222724.1495808364736017374.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:42638 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186Ab2KZFKH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 26 Nov 2012 00:10:07 -0500
Content-Disposition: inline
In-Reply-To: <20121118.222724.1495808364736017374.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: torvalds@linux-foundation.org, monstr@monstr.eu, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sun, Nov 18, 2012 at 10:27:24PM -0500, David Miller wrote:
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> Applied, thanks.

Hmm...  There's something odd going on with {rt_,}sigaction on sparc -
we *do* have sa_restorer in struct sigaction and struct old_sigaction,
but it's not used for anything whatsoever.  There's also a separately
passed restorer pointer for rt_sigaction() and *that* is used instead,
but not reported via *oact.

What's the reason for that weirdness?  I understand why we do that on
alpha (we have no sa_restorer in struct sigaction we'd inherited from
OSF/1), but sparc always had perfectly normal sigaction->sa_restorer
field all along - even for old sigaction(2)...
