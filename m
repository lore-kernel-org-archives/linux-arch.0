From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC] get_write_access()/deny_write_access() without
 inode->i_lock
Date: Mon, 20 Jun 2011 15:15:48 +0100
Message-ID: <20110620141548.GS11521@ZenIV.linux.org.uk>
References: <20110619235147.GQ11521@ZenIV.linux.org.uk>
 <20110620132144.GB26576@dhcp-26-164.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:39745 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848Ab1FTOPt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2011 10:15:49 -0400
Content-Disposition: inline
In-Reply-To: <20110620132144.GB26576@dhcp-26-164.brq.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Frantisek Hrbata <fhrbata@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Jun 20, 2011 at 03:21:44PM +0200, Frantisek Hrbata wrote:
> > +static inline int deny_write_access(struct file *file)
> > +{
> > +	struct inode *inode = file->f_path.dentry->d_inode;
> > +	int v, v1;
> > +	for (v = atomic_read(&inode->i_writecount); v <= 0; v = v1) {
> > +		v1 = atomic_cmpxchg(&inode->i_writecount, v, v + 1);
>                                                              ^^^^^
> Shouldn't i_writecount be decreased here. Looks like cut & paste problem to
> me.

Yes, it should and yes, it is.  Thanks for spotting...
