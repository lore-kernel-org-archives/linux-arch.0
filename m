Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:1396 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757555AbYDNQ1Q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Apr 2008 12:27:16 -0400
Received: by wa-out-1112.google.com with SMTP id m16so2490875waf.23
        for <linux-arch@vger.kernel.org>; Mon, 14 Apr 2008 09:27:16 -0700 (PDT)
Subject: Re: [PATCHv3 2/2] kernel: Move arches to use common unaligned
	access
From: Harvey Harrison <harvey.harrison@gmail.com>
In-Reply-To: <20080414111119.GA6228@flint.arm.linux.org.uk>
References: <1207950449.22001.106.camel@brick> <4392.1208169129@redhat.com>
	 <20080414111119.GA6228@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Mon, 14 Apr 2008 09:27:12 -0700
Message-ID: <1208190432.5721.1.camel@brick>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20080414162712.QAZ4uvuC02cjEynlA-Pp6T6Xe4puuhXeUh0kogko9M8@z>

On Mon, 2008-04-14 at 12:11 +0100, Russell King wrote:
> On Mon, Apr 14, 2008 at 11:32:09AM +0100, David Howells wrote:
> > Harvey Harrison <harvey.harrison@gmail.com> wrote:
> > 
> > > -#ifndef _ASM_UNALIGNED_H
> > > -#define _ASM_UNALIGNED_H
> > > +#ifndef _ASM_FRV_UNALIGNED_H_
> > > +#define _ASM_FRV_UNALIGNED_H_
> > 
> > Please don't.  Why do you need to change these to make your patch work?
> 
> Indeed - ditto for the ARM changes.  The patch is changing them to a
> different style to the others in the respective asm/ directories -
> which is also different from the linux/ directory.
> 
> IMHO, if Harvey wishes to clean those up, then that should be a separate
> patch and should be part of a set converting all includes to use the
> same style.
> 

OK, I'll revise without these changes.  I am curious what the preferred
'linux' style is (if there is one).

Linus, Andrew?

Harvey

