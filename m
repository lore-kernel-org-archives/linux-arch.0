Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from tomts16.bellnexxia.net ([209.226.175.4]:59191 "EHLO
	tomts16-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760266AbXKPNxx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 16 Nov 2007 08:53:53 -0500
Date: Fri, 16 Nov 2007 08:53:49 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: Re: + create-arch-kconfig.patch added to -mm tree
Message-ID: <20071116135349.GA14532@Krystal>
References: <200711152227.lAFMR5Ck019098@imap1.linux-foundation.org> <20071116082053.GA21084@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20071116082053.GA21084@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org, mm-commits@vger.kernel.org, linux-arch@vger.kernel.org, sam@ravnborg.org, torvalds@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

* Russell King (rmk@arm.linux.org.uk) wrote:
> On Thu, Nov 15, 2007 at 02:27:05PM -0800, akpm@linux-foundation.org wrote:
> > It would be much better to do
> > 
> >         depends on ARCH_SUPPORTS_KPROBES
> > 
> > in that generic file, and then architectures that do support it would just
> > have a
> > 
> >         bool ARCH_SUPPORTS_KPROBES
> >                 default y
> 
> I thought we were discussing the prefix to use, and settling on HAVE_xxx
> rather than ARCH_SUPPORTS_xxx.
> 

The latest version I sent uses HAVE_xxx

see :

http://www.gossamer-threads.com/lists/linux/kernel/844040?do=post_view_threaded
(and other messages in that thread)

Mathieu


> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
