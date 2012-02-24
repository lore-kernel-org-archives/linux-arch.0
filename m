From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 02/30] x86-64: Use explicit sizes in sigcontext.h, prepare
 for x32
Date: Thu, 23 Feb 2012 18:33:56 -0800
Message-ID: <4F46F714.6010007@zytor.com>
References: <1329696488-16970-1-git-send-email-hpa@zytor.com> <201202221222.58399.arnd@arndb.de> <4F453086.8030602@zytor.com> <201202222123.38816.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:58641 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752943Ab2BXCeT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Feb 2012 21:34:19 -0500
In-Reply-To: <201202222123.38816.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, akpm@linux-foundation.org, hjl.tools@gmail.com

On 02/22/2012 01:23 PM, Arnd Bergmann wrote:
> 
> I'd say we should fix at least the ones that are easy to spot because
> they already use compat_u64 or have an #ifdef CONFIG_X86_64 in compat
> code. I've looked at everything I could find that fits into that category
> and found only two locations. My expectation is that all other data
> structures that would fall into this category are already broken
> for 32 bit emulation on x86.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 

Would you mind sending these as patches to the respective maintainers?
Since they don't depend on the x32 patchset per se it's probably the
best way to handle this.

Feel free to include my Acked-by: H. Peter Anvin <hpa@zytor.com>.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
