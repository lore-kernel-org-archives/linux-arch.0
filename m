Return-Path: <rmk+linux-arch=vger.kernel.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45840 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263611AbUDWJA1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 23 Apr 2004 05:00:27 -0400
Date: Fri, 23 Apr 2004 10:00:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [Patch] SMP call function cleanup
Message-ID: <20040423100019.A12650@flint.arm.linux.org.uk>
References: <OFD7014FC9.01C49161-ONC1256E7F.002590F4-C1256E7F.0025D0FE@de.ibm.com> <20040423070521.GM22027@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040423070521.GM22027@krispykreme>; from anton@samba.org on Fri, Apr 23, 2004 at 05:05:21PM +1000
Sender: Russell King <rmk@arm.linux.org.uk>
To: Anton Blanchard <anton@samba.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jan Glauber <glauber@gmx.de>, Linux Arch list <linux-arch@vger.kernel.org>, William Lee Irwin III <wli@holomorphy.com>
List-ID: <linux-arch.vger.kernel.org>

On Fri, Apr 23, 2004 at 05:05:21PM +1000, Anton Blanchard wrote:
> The worry is we then start changing algorithms to suit, I could see 
> someone replacing a timer based algorithm with an IPI send to cpumask
> one. Im theorising here and the IPI method may end up being more
> efficient on all architectures but we suffer from not having a decent
> example case yet.

Indeed and completely agreed.

Also, consider that the sending CPU may not be able to receive the IPI
itself, and should be excluded if that is the case.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
