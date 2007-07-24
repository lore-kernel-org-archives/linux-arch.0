Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:37588 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758245AbXGXUEH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Jul 2007 16:04:07 -0400
Date: Tue, 24 Jul 2007 21:04:01 +0100
From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH][RFC] getting rid of stupid loop in BUG()
Message-ID: <20070724200401.GU21668@ftp.linux.org.uk>
References: <20070724153916.GS21668@ftp.linux.org.uk> <46A62F35.2000501@goop.org> <20070724171455.GT21668@ftp.linux.org.uk> <46A64F4F.80107@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46A64F4F.80107@goop.org>
Sender: linux-arch-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Jul 24, 2007 at 12:13:19PM -0700, Jeremy Fitzhardinge wrote:
> Al Viro wrote:
> > Works here...
> >   
> 
> Hm, doesn't here:
> 
>   CC      arch/i386/kernel/irq.o
> /home/jeremy/hg/xen/paravirt/linux/arch/i386/kernel/irq.c: In function '__BUG':
> include2/asm/bug.h:29: warning: 'noreturn' function does return
> 
> This is with current FC7 distro gcc: gcc version 4.1.2 20070502 (Red Hat
> 4.1.2-12)

Interesting...  Looks like it's both version- and flags-dependent.
Oh, well...

BTW, alpha, frv, m68k and s390 have BUG() that is not recognized as
noreturn by gcc.
