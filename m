Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60689 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933AbXKPIYZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Nov 2007 03:24:25 -0500
Date: Fri, 16 Nov 2007 08:24:04 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: + create-arch-kconfig.patch added to -mm tree
Message-ID: <20071116082404.GB21084@flint.arm.linux.org.uk>
References: <200711152227.lAFMR5Ck019098@imap1.linux-foundation.org> <20071116015730.GA16953@Krystal> <20071115180722.8ae4b285.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071115180722.8ae4b285.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, linux-arch@vger.kernel.org, sam@ravnborg.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Nov 15, 2007 at 06:07:22PM -0800, Andrew Morton wrote:
> On Thu, 15 Nov 2007 20:57:30 -0500 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:
> > I have an updated patchset for these 4 instrumentation menu patches,
> > following Sam Ravnborg's comments (using ARCH_HAS_* instead of
> > ARCH_SUPPORTS_*). I was planning to send them with my next patch round.
> > 
> > create-arch-kconfig.patch
> > add-arch_supports_oprofile.patch
> > add-arch_supports_kprobes.patch
> > move-kconfiginstrumentation-to-arch-kconfig-and-init-kconfig.patch
> 
> So I've fixed all the rejects, fixed it all up for the arch/x86/Kconfig
> churn, merged another patchset which depends on this one and now I'm told
> that they need to be updated?

Well, the discussion on linux-arch about what to use started some 11
hours before your original merge mail.  Maybe you missed it?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
