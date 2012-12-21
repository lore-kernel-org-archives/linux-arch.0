From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: new architectures, time_t __kernel_long_t
Date: Fri, 21 Dec 2012 04:57:31 +0000
Message-ID: <20121221045731.GO4939@ZenIV.linux.org.uk>
References: <201211141218.02105.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:49696 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908Ab2LUE5e (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 20 Dec 2012 23:57:34 -0500
Content-Disposition: inline
In-Reply-To: <201211141218.02105.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, Vineet.Gupta1@synopsys.com, linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>, "H. Peter Anvin" <hpa@zytor.com>

On Wed, Nov 14, 2012 at 12:18:01PM +0000, Arnd Bergmann wrote:

> The other types that are used as 64 bit on x32 are ino_t, nlink_t,
> size_t, ssize_t, ptrdiff_t, and off_t.

*Kernel-side* we should not give a damn about the userland nlink_t, period.
Making it architecture-dependent had been a bad mistake that essentially
made nlink_t useless for the kernel.  That mistake had been fixed; please,
do not bring it back.  If some userland structure needs to include a field
encoding nlink_t values, please use an explicitly-sized type when refering
to it kernel-side.

The same should've been true for mode_t, but for historical reasons we
are using umode_t for just about everything and IMO we should kill the
last references to mode_t anywhere kernel-side (again, explicitly-sized
types for userland st_mode and friends on the last few architectures
still refering to mode_t there) and just rename umode_t to mode_t; I'm
sick and tired of playing whack-a-mole with code using (arch-dependent)
mode_t for kernel data.  And no, it's not always harmless - we had rather
ugly bugs based on that.
