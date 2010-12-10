From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv1 000/211] unicore32 architecture support
Date: Fri, 10 Dec 2010 13:16:48 +0100
Message-ID: <201012101316.49153.arnd@arndb.de>
References: <01ca01cb9783$7818c3f0$684a4bd0$@mprc.pku.edu.cn> <4D00A672.9050906@kernel.org> <alpine.LFD.2.00.1012091443580.2653@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:61121 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755690Ab0LJMRA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Dec 2010 07:17:00 -0500
In-Reply-To: <alpine.LFD.2.00.1012091443580.2653@localhost6.localdomain6>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>, Guan Xuetao <guanxuetao@mprc.pku.edu.cn>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 09 December 2010, Thomas Gleixner wrote:
> Crap. a single patch is a major PITA for review. It's even worse than
> 211 per file patches.

It doesn't matter which way is worse than the other. Both are
impractical for people to look at and not helpful.

> It's ok to have several patches ordered by topics
> 
>   - generic header stuff
>   - processor and system headers
>   - low level entry and setup code
>   - process/thread related code
>   - mm related code
>   - timers
>   - interrupts
>   - ptrace
>   - signals
>   - fault handling
>   - misc
>   - build system, main makefile, Kconfig
> 
> That makes it actually feasible to review.

Agreed.

One important step is to send patches that touch existing
architecture independent code separately from new files
that depend on the changes.

In some cases, it's also useful to send out less than the
complete set of patches at a time, but only if it is possible
to understand the patches that did get sent by themselves.
For instance, don't send a device driver implementation but
not the header files that defines the user interface and the
hardware registers.

My personal upper bound would be on the order of ten large
patches or (alternatively) twenty small patches. The size of
the individual mails often varies a lot and that's fine.
A patch containing 100kb of register definitions may be
easier to review than a one-line change in an important
place.

	Arnd
