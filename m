Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16960.38237.576884.204934@cargo.ozlabs.ibm.com>
Date: Wed, 23 Mar 2005 08:59:57 +1100
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] ?mb() -> smp_?mb() conversion
In-Reply-To: <20050322091331.7b2967a1.davem@davemloft.net>
References: <20050322163428.GD21986@parcelfarce.linux.theplanet.co.uk>
	<20050321150619.2ea75257.davem@davemloft.net>
	<20050321225904.GF23908@krispykreme>
	<20072.1111488229@redhat.com>
	<20050322131316.GC21986@parcelfarce.linux.theplanet.co.uk>
	<20050322160324.GA4980@krispykreme>
	<11333.1111510094@redhat.com>
	<20050322091331.7b2967a1.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: David Howells <dhowells@redhat.com>, matthew@wil.cx, anton@samba.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David S. Miller writes:

> This is the first time I've seen that ?mb() should order I/O
> accesses.  My sparc64 versions certainly don't handle that
> correctly.  :-)  That being said, I think we're all being
> educated to so me extent in this thread.

Certainly driver writers expect that the combination of a wmb()
followed by a writel() will enforce ordering between any previous
writes to memory and the I/O write in the writel (as in the typhoon.c
example that Anton posted).  On ppc64 this means that we have to use a
sync instruction rather than any lighter-weight memory barrier for
wmb.

Paul.
