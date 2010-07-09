From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: LMB bits
Date: Fri, 09 Jul 2010 17:11:20 +1000
Message-ID: <1278659480.28659.149.camel@pasglop>
References: <1278031351-23223-1-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:40023 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337Ab0GIHMG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 9 Jul 2010 03:12:06 -0400
In-Reply-To: <1278031351-23223-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org

So I've pushed the memblocks rename and the modified version of my
patches that Yinghai produced in the "memblock" branch of the
powerpc.git tree, based on top of current Linus tree.

I've left out all the other patches for x86.

I did some compile tests and all my test configs on powerpc pass. I
won't have time to do in depth runtime tests but I will eventually get
to it.

Now we really need the other archs affected by my LMB rework to test
that I haven't broken things for them :-)

I'm especially worried with things like sparc NUMA bits. I think I got
it right but I couldn't test.

So those patches aren't yet candidate for next, though they will be with
a tad more testing.

Cheers,
Ben.
