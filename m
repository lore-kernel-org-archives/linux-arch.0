From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: memory barrier question
Date: Thu, 16 Sep 2010 18:06:53 +0200
Message-ID: <E1OwGz7-0007Cu-CC@pomaz-ex.szeredi.hu>
References: <E1OwEjQ-0006wS-MU@pomaz-ex.szeredi.hu>
 <E1Ovt6F-0005CS-RU@pomaz-ex.szeredi.hu>
 <3777.1284638136@redhat.com>
 <6383.1284647456@redhat.com> <20100916150356.GD2462@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20100916150356.GD2462@linux.vnet.ibm.com>
	(paulmck@linux.vnet.ibm.com)
Sender: linux-kernel-owner@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: dhowells@redhat.com, miklos@szeredi.hu, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, 16 Sep 2010, Paul E. McKenney wrote:
> On Thu, Sep 16, 2010 at 03:30:56PM +0100, David Howells wrote:
> > Miklos Szeredi <miklos@szeredi.hu> wrote:
> > 
> > > Is the rmb() really needed?
> > > 
> > > Take this code from fs/namei.c for example:
> > > 
> > > 		inode = next.dentry->d_inode;
> > > 		if (!inode)
> > > 			goto out_dput;
> > > 
> > > 		if (inode->i_op->follow_link) {
> > > 
> > > It happily dereferences dentry->d_inode without a barrier after
> > > checking it for non-null, while that d_inode might have just been
> > > initialized on another CPU with a freshly created inode.  There's
> > > absolutely no synchornization with that on this side.
> > 
> > Perhaps it's not necessary; once set, how likely is i_op to be changed once
> > I_NEW is cleared?
> 
> Are the path_get()s protecting this?

No, when creating a file the dentry will go from negative to positive
independently from lookup.  The dentry can get instantiated with an
inode between the path_get() and dereferencing ->d_inode.

> 
> If there is no protection, then something like rcu_dereference() is
> needed for the assignment from next.dentry->d_inode.

Do I understand correctly that the problem is that a CPU may have a
stale cache associated with *inode, one that was loaded before the
write barrier took effect?

Funny that such a bug could stay unnoticed in so often excercised
code.  Yeah I know it's alpha only.  I wonder how much of this pattern
exists in the kernel elswhere without the necessary barriers.

Thanks,
Miklos
