Return-Path: <ak@suse.de>
Received: from ns.suse.de ([195.135.220.2]:19928 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262941AbUDDXgM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 Apr 2004 19:36:12 -0400
Date: Mon, 5 Apr 2004 01:35:44 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 3/4] Consolidate sys32_select
Message-ID: <20040404233544.GA10937@wotan.suse.de>
References: <200404040204.03594.arnd@arndb.de> <20040404122404.54329a2e.ak@suse.de> <20040404110756.GB791@holomorphy.com> <200404050051.29932.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404050051.29932.arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> ===== fs/compat.c 1.25 vs edited =====
> --- 1.25/fs/compat.c	Sat Apr  3 23:51:59 2004
> +++ edited/fs/compat.c	Mon Apr  5 00:48:52 2004
> @@ -1377,8 +1377,9 @@
>  			usec = timeout % HZ;
>  			usec *= (1000000/HZ);
>  		}
> -		ret = __put_user(sec, &tvp->tv_sec);
> -		ret |= __put_user(usec, &tvp->tv_usec);
> +		if (put_user(sec, &tvp->tv_sec) ||
> +		    put_user(usec, &tvp->tv_usec))
> +			ret = -EFAULT;

Are you sure? They should be equivalent. __put_user returns -EFAULT
on error.

-Andi
