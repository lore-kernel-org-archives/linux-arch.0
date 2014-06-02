From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 11/32] xfs: convert to struct inode_time
Date: Mon, 02 Jun 2014 13:02:07 +0200
Message-ID: <142924495.p3tVTERnnG@wuerfel>
References: <1401480116-1973111-1-git-send-email-arnd@arndb.de> <8618458.1EVJCoVbkH@wuerfel> <0ab4392c-d89d-4277-914d-1696f455daab@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:61665 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843AbaFBLCY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Jun 2014 07:02:24 -0400
In-Reply-To: <0ab4392c-d89d-4277-914d-1696f455daab@email.android.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, joseph@codesourcery.com, john.stultz@linaro.org, hch@infradead.org, tglx@linutronix.de, geert@linux-m68k.org, lftan@altera.com, linux-fsdevel@vger.kernel.org, xfs@oss.sgi.com

On Sunday 01 June 2014 13:26:03 H. Peter Anvin wrote:
> Perhaps we should make this a kernel command line option instead, with the
> settings: error out on outside the standard window, or a date indicating the
> earliest date that should be recognized and do windowing (0 for no windowing,
> 1970 for retconning the Unix epoch as unsigned...)

What's wrong with compile-time errors? We have a pretty good understanding
of how time values are passed in the kernel, and we know they will all break
in 2038 for 32-bit kernels unless we do something about it.
 
> But again, the kernel is probably the least problem here...
 
I agree the glibc side is harder than this, but we have to get the kernel
into shape first (at the minimum we have to do the APIs), and there is enough
work to do here.

	Arnd
