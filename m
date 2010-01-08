From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 3/3] generic sys_ipc wrapper
Date: Fri, 8 Jan 2010 16:49:34 +0100
Message-ID: <201001081649.34308.arnd@arndb.de>
References: <20100106172152.GC17163@lst.de> <201001081157.17195.arnd@arndb.de> <20100108153443.GA14494@lst.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:51110 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435Ab0AHPv5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 Jan 2010 10:51:57 -0500
In-Reply-To: <20100108153443.GA14494@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, ysato@users.sourceforge.jp, takata@linux-m32r.org, geert@linux-m68k.org, zippel@linux-m68k.org, gerg@uclinux.org, ralf@linux-mips.org, benh@kernel.crashing.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, lethal@linux-sh.org, davem@davemloft.net, jdike@addtoit.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, viro@zeniv.linux.org.uk

On Friday 08 January 2010, Christoph Hellwig wrote:
> Possiblly.  Not sure if it's worth it, though.  If the s390 maintainers
> want it I'd say do it as a separate patch.

Sounds fair.

> at least on powerpc and s390, possibly on all 64 bit machines:
> 
> > > +                   return -EINVAL;
> > > +           if (get_user(fourth.__pad, (void __user * __user *) ptr))
> > > +                   return -EFAULT;
> > > +           return sys_semctl(first, second, third, fourth);
> > 
> >               return sys_semctl(first, (int)second, third, fourth);
> 
> What does the explicit case buy us in terms of sign-extension over
> the implicit one given that the second argument to sys_semctl already is
> types as int?

You're right, it's not needed any more, in particular since Heiko
added the wrappers around each syscall to do yet another sign extension,
but this one was probably right in your version already.

You convinced me that the patch is good in its current shape.

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
