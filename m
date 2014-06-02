From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [RFC 11/32] xfs: convert to struct inode_time
Date: Mon, 2 Jun 2014 07:57:37 -0400
Message-ID: <20140602115737.GB14276@thunk.org>
References: <1401480116-1973111-1-git-send-email-arnd@arndb.de>
 <8618458.1EVJCoVbkH@wuerfel>
 <alpine.LFD.2.11.1406012121430.17310@knanqh.ubzr>
 <4178301.j9kWdGCRLC@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:45234 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754112AbaFBL6U (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 2 Jun 2014 07:58:20 -0400
Content-Disposition: inline
In-Reply-To: <4178301.j9kWdGCRLC@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, joseph@codesourcery.com, john.stultz@linaro.org, hch@infradead.org, tglx@linutronix.de, geert@linux-m68k.org, lftan@altera.com, linux-fsdevel@vger.kernel.org, xfs@oss.sgi.com

On Mon, Jun 02, 2014 at 12:56:42PM +0200, Arnd Bergmann wrote:
> 
> I think you misunderstood what I suggested: the intent is to avoid
> seeing things break in 2038 by making them break much earlier. We have
> a solution for ext2 file systems, it's called ext4, and we just need
> to ensure that everybody knows they have to migrate eventually.
> 
> At some point before the mid 2030ies, you should no longer be able to
> build a kernel that has support for ext2 or any other module that will
> run into bugs later....

Even for ext4, it's not quite so simple as that.  You only have
support for times post 2038 if you are using an inode size > 128
bytes.  There are a very, very large number of machines which even
today, are using 128 byte inodes with ext4 for performance reasons.

The vast majority of those machines which I know of can probably move
to 256 byte inodes relatively easily, since hard drive replacement
cycles are order 5-6 years tops, so I'm not that concerned, but it
just goes to show this is a very complicated problem.

And even if we're talking about flash and embedded devices, the good
news is if you assume that 10 years is enough time for people to
update their embedded OS builds, and that the vast majority of
deployed devices will probably only be in service for 10-15 years, we
do have enough time to make file system format changes, although
admittedly we can't afford to dilly-dally.

Regards,

					- Ted
