Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267328AbUHPB7b@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:16333 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267324AbUHPB7b (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 15 Aug 2004 21:59:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16672.5343.312936.93356@cargo.ozlabs.ibm.com>
Date: Mon, 16 Aug 2004 11:58:55 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: clear_user_highpage()
In-Reply-To: <20040811172324.33f351bf.davem@redhat.com>
References: <20040811161537.5e24c2b6.davem@redhat.com>
	<Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org>
	<20040811165307.46ff1eb6.davem@redhat.com>
	<Pine.LNX.4.58.0408111654440.1839@ppc970.osdl.org>
	<20040811172324.33f351bf.davem@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David S. Miller writes:

> If I use the cache bypassing stores on sparc64 for clear page (which I
> do and always have), it takes roughly 4400 cycles to clear a page out
> on a 750Mhz cpu regardless of whether the page is in the L2 cache or
> not.

Just for fun (and to make Dave jealous :) I instrumented clear_page()
on the G5 to measure the number of calls and total time taken.  (Note
that clear_user_highpage calls clear_page, which gets inlined.)

The result was that clear_page takes an average of 96ns (192 cycles)
per page on my 2-way 2GHz G5.  Our pages are 4k so you would have to
double that to get a fair comparison with the sparc, but even then we
are still only taking 9% of the cycles. :)  This is using the dcbz
(data cache block zero) instruction, which makes a cache line
exclusive in the cache and zeroes it without memory traffic (there is
some bus traffic on SMP because it has to issue a kill to all the
other processors).

There will of course be memory traffic later as those cache lines get
written back, but that occurs in cacheline-sized bursts, and to the
extent that the program writes to the page before the lines get
written back, we win.

Regards,
Paul.
