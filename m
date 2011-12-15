From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/3] X86_64: Optimise fls(), ffs() and fls64()
Date: Thu, 15 Dec 2011 13:29:07 -0800
Message-ID: <4EEA66A3.4010205@zytor.com>
References: <20111213145654.14362.39868.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:43008 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751855Ab1LOV3T (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Dec 2011 16:29:19 -0500
In-Reply-To: <20111213145654.14362.39868.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, linux-arch@vger.kernel.org

On 12/13/2011 06:56 AM, David Howells wrote:
>  
> +#if BITS_PER_LONG == 32
>  #include <asm-generic/bitops/fls64.h>
> +#endif
>  

This is outside __KERNEL__, and thus ends up changing what is exported
to userspace (specifically, fls64.h won't be included for 64-bit
non-__KERNEL__ anymore.)  Is this a bug?

	-hpa
