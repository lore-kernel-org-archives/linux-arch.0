Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42283 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704AbYDNLMb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Apr 2008 07:12:31 -0400
Date: Mon, 14 Apr 2008 12:11:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCHv3 2/2] kernel: Move arches to use common unaligned access
Message-ID: <20080414111119.GA6228@flint.arm.linux.org.uk>
References: <1207950449.22001.106.camel@brick> <4392.1208169129@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4392.1208169129@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Harvey Harrison <harvey.harrison@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20080414111119.U_AS1HREO8aaQBkfLAbRVkFeIIGbbC28SEoifq7xuZo@z>

On Mon, Apr 14, 2008 at 11:32:09AM +0100, David Howells wrote:
> Harvey Harrison <harvey.harrison@gmail.com> wrote:
> 
> > -#ifndef _ASM_UNALIGNED_H
> > -#define _ASM_UNALIGNED_H
> > +#ifndef _ASM_FRV_UNALIGNED_H_
> > +#define _ASM_FRV_UNALIGNED_H_
> 
> Please don't.  Why do you need to change these to make your patch work?

Indeed - ditto for the ARM changes.  The patch is changing them to a
different style to the others in the respective asm/ directories -
which is also different from the linux/ directory.

IMHO, if Harvey wishes to clean those up, then that should be a separate
patch and should be part of a set converting all includes to use the
same style.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
