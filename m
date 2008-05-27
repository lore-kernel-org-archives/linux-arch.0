From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 27 May 2008 15:42:41 -0600
Message-ID: <20080527214241.GA22636@parisc-linux.org>
References: <1211852026.3286.36.camel@pasglop> <20080526.184047.88207142.davem@davemloft.net> <1211854540.3286.42.camel@pasglop> <20080526.192812.184590464.davem@davemloft.net> <1211859542.3286.46.camel@pasglop> <alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org> <1211922621.3286.80.camel@pasglop> <alpine.LFD.1.10.0805271421570.2958@woody.linux-foundation.org> <1211924335.3286.89.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:45700 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760246AbYE0Vm6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 27 May 2008 17:42:58 -0400
Content-Disposition: inline
In-Reply-To: <1211924335.3286.89.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, tpiepho@freescale.com

On Wed, May 28, 2008 at 07:38:55AM +1000, Benjamin Herrenschmidt wrote:
> A problem with __raw_ though is that they -also- don't do byteswap,
> which is a pain in the neck as people use them for either one reason
> (relaxed ordering) or the other (no byteswap) without always knowing the
> consequences of doing so...

That's why there's __readl() which does byteswap, but doesn't do
ordering ...

> I'm happy to say that __raw is purely about ordering and make them
> byteswap on powerpc tho (ie, make them little endian like the non-raw
> counterpart).

That would break a lot of drivers.

> Some archs started providing writel_be etc... I added those to powerpc a
> little while ago, and I tend to prefer that approach for the byteswap
> issue.

Those are for people who use big endian chips on little endian
architectures.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
