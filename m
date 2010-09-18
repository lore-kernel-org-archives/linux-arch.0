From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: memory barrier question
Date: Sat, 18 Sep 2010 02:12:19 +0100
Message-ID: <20100918021219.1ff6f98f@lxorguk.ukuu.org.uk>
References: <E1OwEjQ-0006wS-MU@pomaz-ex.szeredi.hu>
	<E1Ovt6F-0005CS-RU@pomaz-ex.szeredi.hu>
	<3777.1284638136@redhat.com>
	<6383.1284647456@redhat.com>
	<20100916150356.GD2462@linux.vnet.ibm.com>
	<E1OwGz7-0007Cu-CC@pomaz-ex.szeredi.hu>
	<20100916163708.GG2462@linux.vnet.ibm.com>
	<E1OwHkg-0007IX-DH@pomaz-ex.szeredi.hu>
	<1284656978.26423.11.camel@mulgrave.site>
	<E1OwI5H-0007LR-DC@pomaz-ex.szeredi.hu>
	<1284760148.30449.107.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36742 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753785Ab0IRAu6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 17 Sep 2010 20:50:58 -0400
In-Reply-To: <1284760148.30449.107.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, James Bottomley <James.Bottomley@HansenPartnership.com>, paulmck@linux.vnet.ibm.com, dhowells@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

> >    LOAD inode = next.dentry->inode
> >    if (inode != NULL)
> >    	LOAD inode->f_op
> > 
> > What is there the compiler can optimize?
> 
> Those two loads depend on each other, I don't think any implementation
> can re-order them. In fact, such data dependency is typically what is
> used to avoid having barriers in some cases. The second load cannot be
> issued until the value from the first one is returned.

Actually I've met several compilers which will optimise them but not gcc
and not in a Linux environment. Some compilers know how to optimise the
== NULL case for pointer dereferences providing their programming
environment has a couple of low pages mapped read only and reading 0.

Alan
