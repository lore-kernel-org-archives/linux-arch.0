From: "H. Peter Anvin" <hpa@kernel.org>
Subject: Re: [PATCH 08/10] Use __kernel_ulong_t in struct msqid64_ds
Date: Thu, 17 May 2012 20:21:52 -0700
Message-ID: <4FB5C050.9070805@kernel.org>
References: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com> <1337292816-10839-9-git-send-email-hjl.tools@gmail.com> <4FB58EFD.7010302@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:39837 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751562Ab2ERDWO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 May 2012 23:22:14 -0400
In-Reply-To: <4FB58EFD.7010302@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>

On 05/17/2012 04:51 PM, H. Peter Anvin wrote:
> 
> This patch and the one before it seems to have another problem: we
> currently define __BITS_PER_LONG as:
> 
> #ifdef __x86_64__
> # define __BITS_PER_LONG 64
> #else
> # define __BITS_PER_LONG 32
> #endif
> 

H.J., do you see any problem *other* than this wretched struct
msqid64_ds with changing the above from __x86_64__ to

#if defined(__x86_64__) && !defined(__ILP32__)

... in the above?

As far as struct msqid64_ds,  I think we can fix it simply because x86
is the only compat-aware architecture which has to deal with it.

(Incidentally, if sh is ever expanded to 64 bits, it will have a problem
in the bigendian configuration...)

	-hpa
