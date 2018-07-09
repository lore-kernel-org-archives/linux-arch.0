Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out4.electric.net ([192.162.216.195]:59097 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754142AbeGIJPG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2018 05:15:06 -0400
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Date: Mon, 9 Jul 2018 09:16:38 +0000
Message-ID: <f7499a811ba54c00a11f7525ae216213@AcuMS.aculab.com>
References: <20180709044444.6397-1-abrodkin@synopsys.com>
In-Reply-To: <20180709044444.6397-1-abrodkin@synopsys.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Alexey Brodkin' <Alexey.Brodkin@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Greg KH <greg@kroah.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Message-ID: <20180709091638.PNcoErjwFw3sXKDCXV-SzISL82wiaPDAQmqismJebeg@z>

From: Alexey Brodkin
> Sent: 09 July 2018 05:45
> Depending on ABI "long long" type of a particular 32-bit CPU
> might be aligned by either word (32-bits) or double word (64-bits).
> Make sure "data" is really 64-bit aligned for any 32-bit CPU.
> 
> At least for 32-bit ARC cores ABI requires "long long" types
> to be aligned by normal 32-bit word. This makes "data" field aligned to
> 12 bytes. Which is still OK as long as we use 32-bit data only.
> 
> But once we want to use native atomic64_t type (i.e. when we use special
> instructions LLOCKD/SCONDD for accessing 64-bit data) we easily hit
> misaligned access exception.

Shouldn't there be a typedef for the actual type.
Perhaps it is even atomic64_t ?
And have the __aligned(8) applied to that typedef ??

> That's because even on CPUs capable of non-aligned data access LL/SC
> instructions require strict alignment.
...
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -24,8 +24,12 @@ struct devres_node {
> 
>  struct devres {
>  	struct devres_node		node;
> -	/* -- 3 pointers */
> -	unsigned long long		data[];	/* guarantee ull alignment */
> +	/*
> +	 * Depending on ABI "long long" type of a particular 32-bit CPU
> +	 * might be aligned by either word (32-bits) or double word (64-bits).
> +	 * Make sure "data" is really 64-bit aligned for any 32-bit CPU.

Just:
	/* data[] must be 64 bit aligned even on 32 bit architectures
	 * because it might be accessed by instructions that require
	 * aligned memory arguments.

> +	 */
> +	unsigned long long		data[] __aligned(sizeof(unsigned long long));

One day assuming that 'unsigned long long' is exactly 64 bits will bite.
This probably ought to be u64 (or similar).
(If not atomic64_t)

	David
