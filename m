Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262794AbUKXS34@vger.kernel.org>
Received: from pD9562327.dip.t-dialin.net ([217.86.35.39]:48938 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S262793AbUKXS3y
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 24 Nov 2004 13:29:54 -0500
Date: Wed, 24 Nov 2004 19:29:49 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Unknown traps.
Message-ID: <20041124182949.GF21039@linux-mips.org>
References: <20041122142921.GB3230@linux-mips.org> <OF7180588E.55ED6DF4-ON41256F56.00528D36-41256F56.005316AF@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF7180588E.55ED6DF4-ON41256F56.00528D36-41256F56.005316AF@de.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Nov 24, 2004 at 04:07:32PM +0100, Martin Schwidefsky wrote:

> Makes sense, although to panic if the fault happened in user space
> is a bit too harsh, isn't it? A do_exit(SIGSEGV) if the fault took place
> in user space and a panic if it happened in the kernel is my favorite
> at the moment.

There are asynchrous exceptions that can be delivered with significant
delay.  So could have been caused by kernel, peripherals or even a
previous processor.  Since for an unknown exception we by definition
don't know the cause or or state of the system after the exception or
how to clear the condition that is causing the exception I still think
panic is the right thing to do.

> blue skies,

Grey skies ...

  Ralf
