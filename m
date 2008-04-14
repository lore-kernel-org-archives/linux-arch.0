Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36551 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745AbYDNQfg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Apr 2008 12:35:36 -0400
Date: Mon, 14 Apr 2008 17:34:48 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCHv3 2/2] kernel: Move arches to use common unaligned access
Message-ID: <20080414163448.GA8473@flint.arm.linux.org.uk>
References: <1207950449.22001.106.camel@brick> <4392.1208169129@redhat.com> <20080414111119.GA6228@flint.arm.linux.org.uk> <1208190432.5721.1.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1208190432.5721.1.camel@brick>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20080414163448.Cgr3jKURV2m-08sGdN6_KXb0607MH7sfQRlD0oMc32o@z>

On Mon, Apr 14, 2008 at 09:27:12AM -0700, Harvey Harrison wrote:
> On Mon, 2008-04-14 at 12:11 +0100, Russell King wrote:
> > On Mon, Apr 14, 2008 at 11:32:09AM +0100, David Howells wrote:
> > > Harvey Harrison <harvey.harrison@gmail.com> wrote:
> > > 
> > > > -#ifndef _ASM_UNALIGNED_H
> > > > -#define _ASM_UNALIGNED_H
> > > > +#ifndef _ASM_FRV_UNALIGNED_H_
> > > > +#define _ASM_FRV_UNALIGNED_H_
> > > 
> > > Please don't.  Why do you need to change these to make your patch work?
> > 
> > Indeed - ditto for the ARM changes.  The patch is changing them to a
> > different style to the others in the respective asm/ directories -
> > which is also different from the linux/ directory.
> > 
> > IMHO, if Harvey wishes to clean those up, then that should be a separate
> > patch and should be part of a set converting all includes to use the
> > same style.
> > 
> 
> OK, I'll revise without these changes.  I am curious what the preferred
> 'linux' style is (if there is one).

The one that's already established by the majority is one answer. 8)

$ grep '^#ifndef LINUX_.*_H$' include/linux/*.h | wc -l
33
$ grep '^#ifndef _LINUX_.*_H$' include/linux/*.h | wc -l
388
$ grep '^#ifndef __LINUX_.*_H$' include/linux/*.h | wc -l
110
$ grep '^#ifndef LINUX_.*_H_$' include/linux/*.h | wc -l
1
$ grep '^#ifndef LINUX_.*_H__$' include/linux/*.h | wc -l
0
$ grep '^#ifndef _LINUX_.*_H_$' include/linux/*.h | wc -l
20
$ grep '^#ifndef __LINUX_.*_H__$' include/linux/*.h | wc -l
20

So it seems _LINUX_FOO_H for linux/foo.h wins.

But... honestly, I wouldn't bother with such a cleanup - at the end of
the day, it's personal choice and people are always going to do something
slightly different.  So it's probably best all round to just accept what's
already in the files you're modifying.

Let's not add to the expanding beaurocracy by demanding a format for these
macro names.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
