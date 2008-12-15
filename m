From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] Add preadv and pwritev system calls.
Date: Sun, 14 Dec 2008 22:20:43 -0800 (PST)
Message-ID: <20081214.222043.249008274.davem@davemloft.net>
References: <1229090440-32120-1-git-send-email-kraxel@redhat.com>
	<20081212152929.GM26095@parisc-linux.org>
	<18757.55706.609537.196994@drongo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:39437
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750904AbYLOGUm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 15 Dec 2008 01:20:42 -0500
In-Reply-To: <18757.55706.609537.196994@drongo.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulus@samba.org
Cc: matthew@wil.cx, kraxel@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Paul Mackerras <paulus@samba.org>
Date: Mon, 15 Dec 2008 15:14:18 +1100

> Matthew Wilcox writes:
> 
> > On Fri, Dec 12, 2008 at 03:00:40PM +0100, Gerd Hoffmann wrote:
> > > The patch sports the actual system call implementation and the windup in
> > > the x86 system call tables.  Other archs are TBD.
> > 
> > > +asmlinkage ssize_t sys_preadv(unsigned long fd, const struct iovec __user *vec,
> > > +                              unsigned long vlen, loff_t pos)
> > > +asmlinkage ssize_t sys_pwritev(unsigned long fd, const struct iovec __user *vec,
> > > +                               unsigned long vlen, loff_t pos)
> > 
> > Are these prototypes required?  MIPS and PARISC will need wrappers to
> > fix them if they are.  These two architectures have an ABI which
> > requires 64-bit arguments to be passed in aligned pairs of registers,
> 
> As does 32-bit PowerPC, so I also would prefer the alternate argument
> order for the syscall (pos as the 3rd argument).

FWIW 32-bit sparc does not have the aligned register requirement
for 64-bit arguments.
