From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] remove ibcs2/PER_SVR4 from SET_PERSONALITY
Date: Wed, 15 Oct 2008 13:14:45 +0100
Message-ID: <20081015121445.GB21756@flint.arm.linux.org.uk>
References: <1224072352.16990.18.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37461 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbYJOMT5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Oct 2008 08:19:57 -0400
Content-Disposition: inline
In-Reply-To: <1224072352.16990.18.camel@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org

On Wed, Oct 15, 2008 at 02:05:52PM +0200, Martin Schwidefsky wrote:
> Greetings,
> this is the ibcs2/PER_SVR4 removal patch against today git tree. Nobody
> complained so I guess it is ready for prime time.

Not yet.

> The question I have is
> by which path should it go upstream? I can certainly create a branch on
> git390 for it but that would be rather unusual since normally only s390
> related patches go over that repository. Andrew, can you take care of
> it ?

You're not fixing up all users of SET_PERSONALITY, so this patch is
build-breaking.  For example, you're missing the SET_PERSONALITY macro
in arch/arm/include/asm/elf.h.

Please use 'grep -r' or 'git grep' to find all definitions of this
macro so you can verify if you've hit all of them.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
