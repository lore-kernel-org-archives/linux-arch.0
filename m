From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [RFC][CFT][CFReview] execve and kernel_thread unification work
Date: Tue, 9 Oct 2012 15:48:16 -0400
Message-ID: <50747F80.4060503@tilera.com>
References: <20121001213809.GA31155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:17145 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927Ab2JITsT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Oct 2012 15:48:19 -0400
In-Reply-To: <20121001213809.GA31155@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 10/1/2012 5:38 PM, Al Viro wrote:
> 	There's an interesting ongoing project around kernel_thread() and
> friends, including execve() variants.  I really need help from architecture
> maintainers on that one; I'd been able to handle (and test) quite a few
> architectures on my own [alpha, arm, m68k, powerpc, s390, sparc, x86, um]
> plus two more untested [frv, mn10300].  c6x patches had been supplied by
> Mark Salter; everything else remains to be done.  Right now it's at
> minus 1.2KLoC, quite a bit of that removed from asm glue and other black
> magic.

I'll take a look at this for arch/tile this week.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
