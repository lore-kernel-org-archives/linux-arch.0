From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] feature-removal: arch code lacking
	CONFIG_HAVE_ARCH_TRACEHOOK
Date: Thu, 14 May 2009 14:02:41 -0600
Message-ID: <20090514200241.GW15360@parisc-linux.org>
References: <20090514191356.30F14FC35D@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:50219 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596AbZENUCl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 May 2009 16:02:41 -0400
Content-Disposition: inline
In-Reply-To: <20090514191356.30F14FC35D@magilla.sf.frob.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@elte.hu>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org

On Thu, May 14, 2009 at 12:13:56PM -0700, Roland McGrath wrote:
> This documents the intent for generic code to stop catering to old
> arch code that has not been updated to the various new interfaces
> that are indicated by 'select HAVE_ARCH_TRACEHOOK' in Kconfig.  The
> most-used arch's have already converted and some others are starting
> to do so.  Help for arch maintainers is available from me and Oleg
> if they ask.  (I already submitted 95% of the work for arch/arm,
> though it has not gotten any feedback from those arch maintainers.)
> 
> The ptrace maintainers and people working on other new features for
> user task debugging and tracing need the freedom to reorganize the
> generic code and make it depend on the modern set of arch interfaces.
> With HAVE_ARCH_TRACEHOOK, such work won't need arch-specific changes.

This really isn't how feature-removal-schedule has been used in the past.

Let's just take a look at this:

Converted
~~~~~~~~~

ia64
powerpc
s390
sh
sparc
x86

Not Converted (in mainline)
~~~~~~~~~~~~~~~~~~~~~~~~~~~

alpha
arm (you mention above you're waiting for the maintainer)
avr32
blackfin
cris
frv
h8300
m32r
m68k
m68knommu
microblaze
mips
mn10300
parisc
um
xtensa

so 6 converted, 16 not.  I don't think you're at the stage where you
can bully people into converting yet.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
