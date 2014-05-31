From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 01/32] fs: introduce new 'struct inode_time'
Date: Sat, 31 May 2014 16:53:01 +0200
Message-ID: <6491264.Vk0CYaEpvf@wuerfel>
References: <1401480116-1973111-1-git-send-email-arnd@arndb.de> <1401480116-1973111-2-git-send-email-arnd@arndb.de> <53899AEA.1010909@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:60922 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbaEaOyv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 31 May 2014 10:54:51 -0400
In-Reply-To: <53899AEA.1010909@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, joseph@codesourcery.com, john.stultz@linaro.org, hch@infradead.org, tglx@linutronix.de, geert@linux-m68k.org, lftan@altera.com, linux-fsdevel@vger.kernel.org

On Saturday 31 May 2014 02:03:38 H. Peter Anvin wrote:
> On 05/30/2014 01:01 PM, Arnd Bergmann wrote:
> > +#ifdef CONFIG_NEW_INODE_TIME
> > +/*
> > + * This is the type we use internally in the kernel to represent
> > + * absolute times in file system metadata.
> > + * This structure must not leak out to user space, and new interfaces
> > + * should be using 64-bit types right away.
> > + */
> > +
> > +/*
> > + * Variant a) using unsigned seconds lets us extend the life span
> > + * for another 69 years beyond 2038.
> > + */
> > +struct inode_time {
> > +     unsigned long   tv_sec;
> > +     long            tv_nsec;
> > +};
> 
> This now differs between 32- and 64-bit systems, and on 32-bit systems
> some timestamps well within the range of representation of current
> systems just became unrepresentable, which is something that I thought
> people were objecting very strongly to.

It really depends on the file system. As you pointed out, I was reading
the ext2/ext3 and xfs code incorrectly, so my assumption when I wrote this
was that they already used the same type, with a 1970-2106 window, rather
than the regular signed Unix epoch.

> > +#elif 0
> > +/*
> > + * This variant can represent the widest range of times, but also
> > + * bloats 'struct inode' a little more.
> > + */
> > +struct inode_time {
> > +     long long       tv_sec __attribute__((packed));
> > +     int             tv_nsec;
> > +};
> 
> Seriously, though, can we really impose constraints stricter than what
> the filesystems themselves do?  It seems we ought to be able to
> represent whatever time the filesystem can represent... (modulo some
> kind of window control as Y2038 or any other break point approaches.)

Just to make sure, do you say we should be using the 'long long/int'
struct, or something else?

	Arnd
