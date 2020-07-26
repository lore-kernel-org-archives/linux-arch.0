From: Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>
Subject: Re: [PATCH 4/4] quota: simplify the quotactl compat handling
Date: Sun, 26 Jul 2020 17:37:11 +0100
Message-ID: <20200726163711.GU2786714@ZenIV.linux.org.uk>
References: <20200726160401.311569-1-hch@lst.de>
 <20200726160401.311569-5-hch@lst.de>
 <20200726163214.GS2786714@ZenIV.linux.org.uk>
 <20200726163422.GA24657@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200726163422.GA24657-jcswGhMUV9g@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Jan Kara <jack-IBi9RG/b67k@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Sun, Jul 26, 2020 at 06:34:22PM +0200, Christoph Hellwig wrote:
> On Sun, Jul 26, 2020 at 05:32:14PM +0100, Al Viro wrote:
> > > +static int compat_copy_fs_qfilestat(struct compat_fs_qfilestat __user *to,
> > > +		struct fs_qfilestat *from)
> > > +{
> > > +	if (copy_to_user(to, from, sizeof(*to)) ||
> > > +	    put_user(from->qfs_nextents, &to->qfs_nextents))
> > > +		return -EFAULT;
> > > +	return 0;
> > > +}
> > 
> > do we have any need of that put_user()?  Note that you don't even call
> > that thing unless compat_need_64bit_alignment_fixup() is true.  And AFAICS
> > all such cases are little-endian...
> 
> The main reason it is there is to preserve the previous semantics.
> And no, I don't think we actually need it on x86.  But what if some
> poor souls adds a BE version that needs this?  E.g. arm oabi has similar
> weird alignment, and now imagine someone adding arm64 compat code for
> that..

I'd probably add /* just in case some poor sod fucks up the same way for big-endian biarch */
next to that put_user(), then ;-)
