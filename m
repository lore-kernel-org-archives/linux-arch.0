From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: +
 page_align-correctly-handle-64-bit-values-on-32-bit-architectures-x86_64-fix.patch
 added to -mm tree
Date: Tue, 1 Jul 2008 13:23:06 -0700
Message-ID: <20080701132306.514cc359.akpm@linux-foundation.org>
References: <200806302233.m5UMXpAn029071@imap1.linux-foundation.org>
	<486A75EE.1060606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42408 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754350AbYGAUXT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 Jul 2008 16:23:19 -0400
In-Reply-To: <486A75EE.1060606@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: righi.andrea@gmail.com
Cc: linux-arch@vger.kernel.org, paulus@samba.org, balbir@linux.vnet.ibm.com

On Tue, 01 Jul 2008 20:22:38 +0200
Andrea Righi <righi.andrea@gmail.com> wrote:

> akpm@linux-foundation.org wrote:
> > ------------------------------------------------------
> > Subject: page_align-correctly-handle-64-bit-values-on-32-bit-architectures x86_64 fix
> > From: Andrea Righi <righi.andrea@gmail.com>
> > 
> > x86_64 allmodconfig build failed due to a missing #include <linux/mm.h>
> > in arch/x86/kernel/module_64.c.
> 
> There are probably other missing includes like this for other
> architectures, due to the move of PAGE_ALIGN() from asm-*/page.h to
> linux/mm.h. I tested allmodconfig and some randconfig only with x86_64
> and i386.
> 
> I've found other (probably) missing includes doing some simple greps,
> see patch v2:
> 
> http://lkml.org/lkml/2008/6/15/85
> 
> Otherwise, a less intrusive approach could be to just fix the bug and
> don't move PAGE_ALIGN() out of asm-*/page.h, see v3:
> 
> http://lkml.org/lkml/2008/6/19/217
> 
> Let me know if you need a patch (v2 or v3) on-top-of the previous one.
> 

It's dopey to duplicate identical code in tens of header files.  There
is no conceivable reason why an architecture would want to have a
customised version of PAGE_ALIGN().

So let's just struggle on and get it right.  Please send me any needed
fixups against the current

page_align-correctly-handle-64-bit-values-on-32-bit-architectures.patch
page_align-correctly-handle-64-bit-values-on-32-bit-architectures-v850-fix.patch
page_align-correctly-handle-64-bit-values-on-32-bit-architectures-x86_64-fix.patch
page_align-correctly-handle-64-bit-values-on-32-bit-architectures-powerpc-fix.patch
