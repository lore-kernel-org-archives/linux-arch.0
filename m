From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: new architectures, time_t __kernel_long_t
Date: Fri, 21 Dec 2012 05:02:02 +0000
Message-ID: <20121221050202.GP4939@ZenIV.linux.org.uk>
References: <201211141218.02105.arnd@arndb.de>
 <20121221045731.GO4939@ZenIV.linux.org.uk>
 <50D3ECEB.1070401@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:49725 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab2LUFCE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 21 Dec 2012 00:02:04 -0500
Content-Disposition: inline
In-Reply-To: <50D3ECEB.1070401@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Vineet.Gupta1@synopsys.com, linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>

On Thu, Dec 20, 2012 at 09:00:27PM -0800, H. Peter Anvin wrote:
> On 12/20/2012 08:57 PM, Al Viro wrote:
> > On Wed, Nov 14, 2012 at 12:18:01PM +0000, Arnd Bergmann wrote:
> > 
> >> The other types that are used as 64 bit on x32 are ino_t, nlink_t,
> >> size_t, ssize_t, ptrdiff_t, and off_t.
> > 
> > *Kernel-side* we should not give a damn about the userland nlink_t, period.
> > Making it architecture-dependent had been a bad mistake that essentially
> > made nlink_t useless for the kernel.  That mistake had been fixed; please,
> > do not bring it back.  If some userland structure needs to include a field
> > encoding nlink_t values, please use an explicitly-sized type when refering
> > to it kernel-side.
> > 
> 
> We should never use userland types per se.  We can use __kernel_*_t
> typedefs to make the kernel headers neater if it makes sense, but that
> is often not even necessary.

... as long as we do not have typedef __kernel_foo_t foo_t in linux/types.h.
