Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:38331 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262451AbUC1U3q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 28 Mar 2004 15:29:46 -0500
Date: Sun, 28 Mar 2004 12:29:20 -0800
From: "David S. Miller" <davem@redhat.com>
Subject: Re: Future of linux-arch
Message-Id: <20040328122920.404e5b37.davem@redhat.com>
In-Reply-To: <20040328120133.D2825@flint.arm.linux.org.uk>
References: <20040328120133.D2825@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 28 Mar 2004 12:01:33 +0100
Russell King <rmk@arm.linux.org.uk> wrote:

> It seems that me posting these two patches just to linux-arch has caused
> some upset in the kernel community.  In particular, Christoph Hellwig
> is talking about publicising the address for this list.

If he can't respect people's privacy, that shouldn't become our problem.

If a group of people interested in 'foo' wish to discuss 'foo' on a mailing
list amongst themselves, I don't see what can be wrong with that.

Maybe I should feel compelled to CC: lkml every time I come up with an
idea I wish to discuss with Linux or Andrew or one of the networking
co-maintainers?  See how rediculious such thinking is?

Now, on the other hand, it may have in fact been more appropriate to discuss
this particular change on lkml, flesh out the API issues publicly, _then_
move what you end up with to linux-arch so that arch people can code up
implementations for their platforms for you.

See, because this patch goes beyond arch issues, driver folks have to use
these interfaces, so logically it appears that folks outside of the arch
community should contribute to the design and review of said interfaces.

Right?
