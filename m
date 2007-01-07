Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:53933 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965260AbXAHAI7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 7 Jan 2007 19:08:59 -0500
Date: Mon, 8 Jan 2007 10:43:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Common compat_sys_sysinfo (v2)
Message-Id: <20070108104347.83a004aa.sfr@canb.auug.org.au>
In-Reply-To: <20070107154045.GD3207@athena.road.mcmartin.ca>
References: <20070107144850.GB3207@athena.road.mcmartin.ca>
	<20070107151319.GA23478@infradead.org>
	<20070107152213.GC3207@athena.road.mcmartin.ca>
	<20070107154045.GD3207@athena.road.mcmartin.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__8_Jan_2007_10_43_47_+1100_m6PjlmpmWyD=I.wq"
Sender: linux-arch-owner@vger.kernel.org
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, parisc-linux@lists.parisc-linux.org
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Mon__8_Jan_2007_10_43_47_+1100_m6PjlmpmWyD=I.wq
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Kyle,

Looks good.  Just one nit and one comment.

On Sun, 7 Jan 2007 10:40:45 -0500 Kyle McMartin <kyle@parisc-linux.org> wrote:
>
> diff --git a/kernel/compat.c b/kernel/compat.c
> index 6952dd0..cebb4c2 100644
> --- a/kernel/compat.c
> +++ b/kernel/compat.c
 .
 .
 .
> +	    __put_user (s.uptime, &info->uptime) ||
                      ^
We don't put spaces in here ...

> +asmlinkage long sys_sysinfo(struct sysinfo __user *info)
> +{
> +	struct sysinfo val;
> +
> +	do_sysinfo(&val);
>
> - out:
>  	if (copy_to_user(info, &val, sizeof(struct sysinfo)))
>  		return -EFAULT;

People have complined before that this adds a whole stack frame to the
"normal" syscall path.  Personally I don't care, but it has been
mentioned.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__8_Jan_2007_10_43_47_+1100_m6PjlmpmWyD=I.wq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFoYXCFdBgD/zoJvwRAvt5AJ4vBigJICMLJanO+YBo1S+xZzJFEQCfbXi8
TEwHcaCFk6+/ul3Z/RmGpE0=
=fF8z
-----END PGP SIGNATURE-----

--Signature=_Mon__8_Jan_2007_10_43_47_+1100_m6PjlmpmWyD=I.wq--
