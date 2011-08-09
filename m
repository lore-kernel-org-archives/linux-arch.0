From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 11/24] C6X: interrupt handling
Date: Tue, 9 Aug 2011 18:39:45 +0200
Message-ID: <201108091839.45777.arnd@arndb.de>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com> <1312839879-13592-12-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64497 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284Ab1HIQjs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2011 12:39:48 -0400
In-Reply-To: <1312839879-13592-12-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Monday 08 August 2011, Mark Salter wrote:

> diff --git a/arch/c6x/kernel/irq.c b/arch/c6x/kernel/irq.c
> new file mode 100644
> index 0000000..252b076
> --- /dev/null
> +++ b/arch/c6x/kernel/irq.c
> @@ -0,0 +1,736 @@
> +/*
> + *  Copyright (C) 2011 Texas Instruments Incorporated
> + *
> + *  This borrows heavily from powerpc version, which is:
> + *
> + *  Derived from arch/i386/kernel/irq.c
> + *    Copyright (C) 1992 Linus Torvalds
> + *  Adapted from arch/i386 by Gary Thomas
> + *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
> + *  Updated and modified by Cort Dougan <cort@fsmlabs.com>
> + *    Copyright (C) 1996-2001 Cort Dougan
> + *  Adapted for Power Macintosh by Paul Mackerras
> + *    Copyright (C) 1996 Paul Mackerras (paulus@cs.anu.edu.au)

There is a lot of work currently going into reworking the way that
interrupt controllers work. You have evidently copied the code that
was in powerpc, which seems like a reasonably base, but it still
duplicates a lot of code.

Maybe Thomas can comment on this one and say whether it's still the
best solution.

If the code is good in the way you implemented it, I think it would
be good to move it into some common library in kernel/irq so that
both powerpc and c6x as well as future architectures can use the
same implementation.

	Arnd
