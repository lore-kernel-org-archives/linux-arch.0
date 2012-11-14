From: Arnd Bergmann <arnd@arndb.de>
Subject: new architectures, time_t __kernel_long_t
Date: Wed, 14 Nov 2012 12:18:01 +0000
Message-ID: <201211141218.02105.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:60677 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161189Ab2KNMSO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 Nov 2012 07:18:14 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Vineet.Gupta1@synopsys.com, linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>, "H. Peter Anvin" <hpa@zytor.com>

Since we are in the review phase for two new architectures that we
should be merging into the mainline kernel, I think we need to
come up with a solution for making them use a proper 64-bit time_t.

Right now, the only 32-bit user space interface we have to use 64-bit
time_t is the x32 side of x86-64, and that works by overriding all
"long" sized types to be 64 bit at the ABI level, which we don't
want for pure 32 bit architectures.
 
I would suggest we make 64-bit time_t, clock_t and suseconds_t the
default in include/asm-generic/posix_types.h and change all existing
32 bit users of that file to provide an override to define these
as "long".

The other types that are used as 64 bit on x32 are ino_t, nlink_t,
size_t, ssize_t, ptrdiff_t, and off_t.

Obviously, we want to use 64-bit off_t, but this is achieved already
through loff_t, which is used in all places in the asm-generic
ABI anyway (the syscalls using off_t are stripped out). I don't
think we want to have the other ones set to 64 bit on ARC or Meta,
although I'm not 100% sure about ino_t and nlink_t.

	Arnd
