Return-Path: <ralf@linux-mips.org>
Received: from p508B6E02.dip.t-dialin.net ([80.139.110.2]:21283 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S265650AbUEZQcy
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 26 May 2004 12:32:54 -0400
Date: Wed, 26 May 2004 18:32:30 +0200
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: arch-specific "make" target
Message-ID: <20040526163230.GA30047@linux-mips.org>
References: <40B4C2FB.5040101@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B4C2FB.5040101@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Wed, May 26, 2004 at 12:16:59PM -0400, Jeff Garzik wrote:

> I just wanted to confirm that all architectures generate a bootable 
> kernel image -- not just vmlinux -- then the developer types "make" with 
> no arguments.
> 
> This is the 2.6 kernel standard, but I just got word that some arches 
> don't follow this rule yet...

MIPS does so for those system that can't boot the vanilla vmlinux file.
Most current systems support direct loading of ELF binaries though.

  Ralf
