Return-Path: <davidm@napali.hpl.hp.com>
Received: from palrel10.hp.com ([156.153.255.245]:55192 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S264499AbUESSSA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 19 May 2004 14:18:00 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16555.42184.694738.917744@napali.hpl.hp.com>
Date: Wed, 19 May 2004 11:17:44 -0700
Subject: Re: [PATCH] fixing sendfile on 64bit architectures
In-Reply-To: <20040519114940.6b92cf1a.ak@suse.de>
References: <20040519114940.6b92cf1a.ak@suse.de>
Reply-To: davidm@hpl.hp.com
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Wed, 19 May 2004 11:49:40 +0200, Andi Kleen <ak@suse.de> said:

  Andi> sys_sendfile has a hardcoded 2GB limit. 64bit architectures
  Andi> should probably always use sys_sendfile64() in their native
  Andi> system tables, because for them sizeof(off_t) ==
  Andi> sizeof(loff_t).  This patch does this. It seemed easier to
  Andi> just change the 64bit entry tables instead of fixing up all
  Andi> the emulation layers to do 2GB checks on their own.

Argh, I had that fixed at one point (I think it was prior to
sys_sendfile64()) but it appears that got lost somewhere along the
line.  Thanks for (re-)catching this.

  Andi> I changed all 64bit architectures except for parisc64, which
  Andi> seemed to already have a sendfile64.

The patch looks fine to me.  My only minor quibble is that it would be
nice if sys_sendfile() wasn't defined at all when it isn't needed and,
in that case, do_sendfile() should be inlined (unit-at-a-time
compilation will take care of the inlining if sys_sendfile() isn't
defined when not needed, so that part doesn't require extra code).

I don't like adding yet another "#ifdef __ia64 && ..." though.  It
would be nice if there was a cleaner way to get rid of unwanted
syscall-stubs in generic code.  How would people feel about replacing
the current #ifdef mess with "#ifdef SYS_NEED_foo" instead?  By my
count, that would get rid of about a dozen of those ugly #ifdefs.  For
example, in fs/stat.c we could have:

#ifdef SYS_NEED_OLD_STAT

instead of:

#if !defined(__alpha__) && !defined(__sparc__) && !defined(__ia64__) \
  && !defined(CONFIG_ARCH_S390) && !defined(__hppa__) \
  && !defined(__arm__) && !defined(CONFIG_V850) && !defined(__powerpc64__) \
  && !defined(__mips__)

	--david
