Return-Path: <arnd@arndb.de>
Received: from natsmtp00.rzone.de ([81.169.145.165]:34038 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S262935AbUDDXum (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 4 Apr 2004 19:50:42 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/4] Consolidate sys32_select
Date: Mon, 5 Apr 2004 01:41:07 +0200
References: <200404040204.03594.arnd@arndb.de> <200404050051.29932.arnd@arndb.de> <20040404233544.GA10937@wotan.suse.de>
In-Reply-To: <20040404233544.GA10937@wotan.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404050141.07872.arnd@arndb.de>
To: Andi Kleen <ak@suse.de>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Monday 05 April 2004 01:35, Andi Kleen wrote:
> > ===== fs/compat.c 1.25 vs edited =====
> > --- 1.25/fs/compat.c	Sat Apr  3 23:51:59 2004
> > +++ edited/fs/compat.c	Mon Apr  5 00:48:52 2004
> > @@ -1377,8 +1377,9 @@
> >  			usec = timeout % HZ;
> >  			usec *= (1000000/HZ);
> >  		}
> > -		ret = __put_user(sec, &tvp->tv_sec);
> > -		ret |= __put_user(usec, &tvp->tv_usec);
> > +		if (put_user(sec, &tvp->tv_sec) ||
> > +		    put_user(usec, &tvp->tv_usec))
> > +			ret = -EFAULT;
> 
> Are you sure? They should be equivalent. __put_user returns -EFAULT
> on error.

Yes, but if put_user succeeds, the value of ret must not be
set to zero here, it already contains the number of descriptors.

	Arnd <><
