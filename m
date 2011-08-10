From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 15/24] C6X: cache control
Date: Wed, 10 Aug 2011 11:38:03 +0200
Message-ID: <201108101138.04043.arnd@arndb.de>
References: <201108091853.54655.arnd@arndb.de> <1312839879-13592-16-git-send-email-msalter@redhat.com> <12886.1312909396@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:62754 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236Ab1HJJiJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Aug 2011 05:38:09 -0400
In-Reply-To: <12886.1312909396@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Mark Salter <msalter@redhat.com>, linux-arch@vger.kernel.org

On Tuesday 09 August 2011, David Howells wrote:
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > > +#define IMCR_BASE    0x01840000
> > 
> > Please don't hardcode MMIO regions like this. You should have the base
> > address in the device tree and use of_iomap() like you do in some other
> > cases.  If you need this really early, you might need to
> 
> What about for memory-mapped CPU registers that you might need to access in
> head.S?
> 
> MN10300, for example, has a bunch of these - such the atomic operation
> parameter and control registers.  Getting some of these through the device
> tree adds potentially quite a lot of overhead.
> 

It really depends on the specific problem. The registers in this file
(cache.c) do not seem to fall into that category, since they are
ioremapped much later.

For any addresses that you don't get from a device tree but assume to
be constant, I would recommend:

* documenting them well, with the specific reasons why you know they
are safe to hardcode and why it would be a pain not to.

* putting them in one architecture-wide header file that contains
all of these constants, rather than putting them into a local C file.

On ARM, we have a case where we want to access MMIO registers extremely
early, for printing debugging output on the serial port. Since the
specific addresses are different from one board to another, there is
no generic solution, but it's possible to have a compile-time option
to enable that code conditionally.

In some other cases, where you have to do some very early setup of
registers, a new architecture port can require the boot loader to
set the registers up to a sensible value before entering the kernel.

	Arnd
