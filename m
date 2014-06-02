Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:59125 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbaFBMkL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Jun 2014 08:40:11 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 11/32] xfs: convert to struct inode_time
Date: Mon, 02 Jun 2014 14:38:09 +0200
Message-ID: <4910284.a72lauVLNV@wuerfel>
In-Reply-To: <20140602115737.GB14276@thunk.org>
References: <1401480116-1973111-1-git-send-email-arnd@arndb.de> <4178301.j9kWdGCRLC@wuerfel> <20140602115737.GB14276@thunk.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, joseph@codesourcery.com, john.stultz@linaro.org, hch@infradead.org, tglx@linutronix.de, geert@linux-m68k.org, lftan@altera.com, linux-fsdevel@vger.kernel.org, xfs@oss.sgi.com
Message-ID: <20140602123809.SL1Sm_lmTsUEm2-U0OZLTUaAb6kCaz5nuw0sPIZ5wwc@z>

On Monday 02 June 2014 07:57:37 Theodore Ts'o wrote:
> On Mon, Jun 02, 2014 at 12:56:42PM +0200, Arnd Bergmann wrote:
> > 
> > I think you misunderstood what I suggested: the intent is to avoid
> > seeing things break in 2038 by making them break much earlier. We have
> > a solution for ext2 file systems, it's called ext4, and we just need
> > to ensure that everybody knows they have to migrate eventually.
> > 
> > At some point before the mid 2030ies, you should no longer be able to
> > build a kernel that has support for ext2 or any other module that will
> > run into bugs later....
> 
> Even for ext4, it's not quite so simple as that.  You only have
> support for times post 2038 if you are using an inode size > 128
> bytes.  There are a very, very large number of machines which even
> today, are using 128 byte inodes with ext4 for performance reasons.
> 
> The vast majority of those machines which I know of can probably move
> to 256 byte inodes relatively easily, since hard drive replacement
> cycles are order 5-6 years tops, so I'm not that concerned, but it
> just goes to show this is a very complicated problem.

Ok, I see.

I also now noticed this comment above EXT4_FITS_IN_INODE():

"For new inodes we always reserve enough space for the kernel's known
extended fields, but for inodes created with an old kernel this might
not have been the case. None of the extended inode fields is critical
for correct filesystem operation."

Do we have to worry about this for inodes that contain extended
attributes and that get updated after 2038?

	Arnd
