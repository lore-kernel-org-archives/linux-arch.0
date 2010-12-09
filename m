From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCHv1 000/211] unicore32 architecture support
Date: Thu, 9 Dec 2010 14:49:30 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1012091443580.2653@localhost6.localdomain6>
References: <01ca01cb9783$7818c3f0$684a4bd0$@mprc.pku.edu.cn> <4D00A672.9050906@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:34867 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753527Ab0LINwT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 9 Dec 2010 08:52:19 -0500
In-Reply-To: <4D00A672.9050906@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

B1;2401;0cOn Thu, 9 Dec 2010, Tejun Heo wrote:

> Hello,
> 
> On 12/09/2010 10:28 AM, Guan Xuetao wrote:
> > From: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
> > 
> > These patches add support for UniCore-32 ISA in linux kernel.
> > UniCore ISA is defined and developed by Micro-Processor R&D Center of
> > Peking University, and over the years, the CPUs and SoCs using UniCore ISA
> > have been successfully applied in a variety of products in China.
> 
> * Patches should be split according to logical steps of changes, not
>   per-file.
> 
> * Patches should be bisectable.  IOW, after applying upto any patch in
>   the series, the tree should be buildable and working.

That does not work for a new architecture. There is nothing to bisect.
  
> * When posting a patch series, especially one as large as 211, please
>   make the mails for the actual patches replies to the head message.
>   Don't post it as 212 separate messages or replies to the immediate
>   previous patch.
> 
> So, in short, if you're adding a whole new arch, just post it as a
> single patch or a series of several patches if it requires changes
> outside of the specific arch subtree.

Crap. a single patch is a major PITA for review. It's even worse than
211 per file patches.

It's ok to have several patches ordered by topics

  - generic header stuff
  - processor and system headers
  - low level entry and setup code
  - process/thread related code
  - mm related code
  - timers
  - interrupts
  - ptrace
  - signals
  - fault handling
  - misc
  - build system, main makefile, Kconfig

That makes it actually feasible to review.

Thanks,

	tglx
