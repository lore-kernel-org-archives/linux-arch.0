Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org ([203.10.76.45]:62905 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264730AbUDWHJL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 23 Apr 2004 03:09:11 -0400
Date: Fri, 23 Apr 2004 17:05:21 +1000
From: Anton Blanchard <anton@samba.org>
Subject: Re: [Patch] SMP call function cleanup
Message-ID: <20040423070521.GM22027@krispykreme>
References: <OFD7014FC9.01C49161-ONC1256E7F.002590F4-C1256E7F.0025D0FE@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFD7014FC9.01C49161-ONC1256E7F.002590F4-C1256E7F.0025D0FE@de.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jan Glauber <glauber@gmx.de>, Linux Arch list <linux-arch@vger.kernel.org>, William Lee Irwin III <wli@holomorphy.com>
List-ID: <linux-arch.vger.kernel.org>

 
Hi,

> I still have problem to understand this argument. Either there is the
> need to execute a function on a selected set of cpus or there isn't.
> If there is the need and the architecture is slow doing IPI's to single
> cpus then the architecture can choose to do a IPI to all cpus
> and do the mask selection in the IPI interrupt.

The worry is we then start changing algorithms to suit, I could see 
someone replacing a timer based algorithm with an IPI send to cpumask
one. Im theorising here and the IPI method may end up being more
efficient on all architectures but we suffer from not having a decent
example case yet.

Since we tend to avoid creating infrastructure just in case someone
finds a use for it Id prefer to avoid adding it at this stage.

Anton
