Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60684 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbXKPIVZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Nov 2007 03:21:25 -0500
Date: Fri, 16 Nov 2007 08:20:54 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: + create-arch-kconfig.patch added to -mm tree
Message-ID: <20071116082053.GA21084@flint.arm.linux.org.uk>
References: <200711152227.lAFMR5Ck019098@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200711152227.lAFMR5Ck019098@imap1.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, mathieu.desnoyers@polymtl.ca, linux-arch@vger.kernel.org, sam@ravnborg.org, torvalds@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Nov 15, 2007 at 02:27:05PM -0800, akpm@linux-foundation.org wrote:
> It would be much better to do
> 
>         depends on ARCH_SUPPORTS_KPROBES
> 
> in that generic file, and then architectures that do support it would just
> have a
> 
>         bool ARCH_SUPPORTS_KPROBES
>                 default y

I thought we were discussing the prefix to use, and settling on HAVE_xxx
rather than ARCH_SUPPORTS_xxx.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
