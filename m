Return-Path: <ak@suse.de>
Received: from cantor.suse.de ([195.135.220.2]:49878 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264258AbUESTB6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 19 May 2004 15:01:58 -0400
Date: Wed, 19 May 2004 21:01:56 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] fixing sendfile on 64bit architectures
Message-Id: <20040519210156.2a983a7c.ak@suse.de>
In-Reply-To: <16555.42184.694738.917744@napali.hpl.hp.com>
References: <20040519114940.6b92cf1a.ak@suse.de>
	<16555.42184.694738.917744@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, linux-arch@vger.kernel.org, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 19 May 2004 11:17:44 -0700
David Mosberger <davidm@napali.hpl.hp.com> wrote:


> 
> The patch looks fine to me.  My only minor quibble is that it would be
> nice if sys_sendfile() wasn't defined at all when it isn't needed and,
> in that case, do_sendfile() should be inlined (unit-at-a-time
> compilation will take care of the inlining if sys_sendfile() isn't
> defined when not needed, so that part doesn't require extra code).

And I thought IA64 didn't care about code size... ;-)

> 
> I don't like adding yet another "#ifdef __ia64 && ..." though.  It
> would be nice if there was a cleaner way to get rid of unwanted
> syscall-stubs in generic code.  How would people feel about replacing
> the current #ifdef mess with "#ifdef SYS_NEED_foo" instead?  By my
> count, that would get rid of about a dozen of those ugly #ifdefs.  For
> example, in fs/stat.c we could have:
> 
> #ifdef SYS_NEED_OLD_STAT
> 
> instead of:
> 
> #if !defined(__alpha__) && !defined(__sparc__) && !defined(__ia64__) \
>   && !defined(CONFIG_ARCH_S390) && !defined(__hppa__) \
>   && !defined(__arm__) && !defined(CONFIG_V850) && !defined(__powerpc64__) \
>   && !defined(__mips__)

How about just putting it into an a extra file and using lib-y in the Makefile?

Then it will be only linked when someone references it.

-Andi
