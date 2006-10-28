Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:47531 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S932110AbWJ1Wrk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Oct 2006 18:47:40 -0400
Date: Sat, 28 Oct 2006 16:47:38 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: Generic compat_sys_rt_sigqueueinfo
Message-ID: <20061028224738.GT5591@parisc-linux.org>
References: <20061028223730.GC3243@athena.road.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061028223730.GC3243@athena.road.mcmartin.ca>
Sender: linux-arch-owner@vger.kernel.org
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, Oct 28, 2006 at 06:37:30PM -0400, Kyle McMartin wrote:
> Every 32-on-64 arch (except parisc) was implementing effectively the
> same sys32_rt_sigqueueinfo. Add a generic implementation taken from
> x86_64 and add it to kernel/compat.c, which required the addition of
> copy_siginfo_from_user32 on mips and powerpc. sparc64 had a sufficient
> implementation for this purpose, so crib it for both those platforms.

Why can't we have a compat_copy_siginfo_from_user() (and
compat_copy_siginfo_to_user() for that matter) defined in
kernel/compat.c for all architectures?  The user32 convention really
grates for some reason ;-)

