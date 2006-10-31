Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:11753 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422840AbWJaHCP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 31 Oct 2006 02:02:15 -0500
Date: Mon, 30 Oct 2006 23:02:10 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: Generic compat_sys_rt_sigqueueinfo
Message-Id: <20061030230210.041531ea.akpm@osdl.org>
In-Reply-To: <20061030155910.GC13625@athena.road.mcmartin.ca>
References: <20061028223730.GC3243@athena.road.mcmartin.ca>
	<20061030155910.GC13625@athena.road.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 30 Oct 2006 10:59:10 -0500
Kyle McMartin <kyle@parisc-linux.org> wrote:

> Every 32-on-64 arch (except parisc) was implementing effectively the
> same sys32_rt_sigqueueinfo. Add a generic implementation taken from
> x86_64 and add it to kernel/compat.c, which required the addition of
> copy_siginfo_from_user32 on mips and powerpc. sparc64 had a sufficient
> implementation for this purpose, so crib it for both those platforms.
> 
> This yields a nice clean up and is one step towards cleaning up some
> of the compat signals mess parisc has been carrying out of tree for a few
> years.
> 
> Incorporated Arnd's suggestion of not bothering to call sys_rt_sigqueueinfo
> and just doing the full syscall in compat_sys_rt_sigqueueinfo.
> 
> Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>
> --
> [N.B. the modification to powerpc is probably wrong, since it seems
>  to require a wrapper for handling the signed ints like sparc64 and s390
>  have. -- Kyle]

Well that's a bit sad.  Could the ppc guys please take a look?

Thanks.

