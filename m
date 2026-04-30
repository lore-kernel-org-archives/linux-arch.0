Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3EB34A773;
	Thu, 30 Apr 2026 03:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777521591; cv=none; b=U8sDJtbBcgVqGcXOoaZpClNyL0zPAe7aqCVD1HwSPfTqFsctzushDLUFjHGPwBkstKXWLbTdzg8faAMbp8V6m77TNS3RmTGyEcC6opCc3TWNgPqeAmSNH71/mfWJxa76LvIc+8GuHzwLXBZynIrzUR0csOteAYKJuQhDtlq96pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777521591; c=relaxed/simple;
	bh=kg0mJxcdJMLR7EVPDQcGXETyksPPs3sOsdETaEE1pDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPxUil2tMm+CKlHqPrw16nHEyEgwmzVuCuzz4HkH5wI5CbIOYeaFvx3/0ZUx8FO+G1jEE7Nunqj8Gz/d4uEBox+NORC+A7DyVXd9YFipQVLZU7pLdrA/G5ZUVqzcyJK5CnpizO/CVSIC3m2vGpCi29GfADAl9YX6RZLwEbm+wy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkiBM3j9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkiBM3j9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD48BC2BCB8;
	Thu, 30 Apr 2026 03:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777521590;
	bh=kg0mJxcdJMLR7EVPDQcGXETyksPPs3sOsdETaEE1pDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TkiBM3j9gtrFPYylxQq45Rosd8mdQUVkFM+PYsnZsd2ZNYCc7EZYt2fzp5MpVpC09
	 EaGNmFF9HvExtQPsN+iIwKKhSqC8nlKGQQ/BVjYFYJH6koTa2wK7zxPOiTWq3PD6H1
	 gOwY+KiTTZKnCBhv2SKKZ+qG1lQmLYIwghx791WnFqLmVcRtCg2RRBt0yONCfCMukC
	 kQb1F3GIScJgst5LQGeTnFWP1Q3FrYb/BprWynUxZlGFGMo+XvXhpVPM50nwRaX0Ey
	 oVHWkmsmitRy4ngDPVMJ+75Lgp0rzHGWY2U+YZ+DtS8sFiRFz3GmkZXsqIAbTqiptP
	 dOJbSn5fVUztw==
Date: Wed, 29 Apr 2026 20:59:43 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, arnd@arndb.de, akpm@linux-foundation.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, david.laight.linux@gmail.com,
	cp0613@linux.alibaba.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v5 2/3] bitops: Define generic __bitrev8/16/32 for reuse
Message-ID: <20260430035943.GA2164248@ax162>
References: <20260421130752.607500-1-ruanjinjie@huawei.com>
 <20260421130752.607500-3-ruanjinjie@huawei.com>
 <20260429202922.GA3575295@ax162>
 <afK0oL5FS8eLobpV@yury>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afK0oL5FS8eLobpV@yury>

On Wed, Apr 29, 2026 at 09:47:12PM -0400, Yury Norov wrote:
> + networking maintainers
> 
> On Wed, Apr 29, 2026 at 01:29:22PM -0700, Nathan Chancellor wrote:
> > Hi Jinjie,
> > 
> > On Tue, Apr 21, 2026 at 09:07:51PM +0800, Jinjie Ruan wrote:
> > > Define generic __bitrev8/16/32 using the implementation
> > > in <linux/bitrev.h>, so they can be reused in <asm/bitrev.h>,
> > > such as RISCV.
> > > 
> > > Reviewed-by: Yury Norov <ynorov@nvidia.com>
> > > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> > > ---
> > >  include/asm-generic/bitops/__bitrev.h | 25 +++++++++++++++++++++++++
> > >  include/linux/bitrev.h                | 20 ++++----------------
> > >  2 files changed, 29 insertions(+), 16 deletions(-)
> > >  create mode 100644 include/asm-generic/bitops/__bitrev.h
> > > 
> > > diff --git a/include/asm-generic/bitops/__bitrev.h b/include/asm-generic/bitops/__bitrev.h
> > > new file mode 100644
> > > index 000000000000..f06af929678d
> > > --- /dev/null
> > > +++ b/include/asm-generic/bitops/__bitrev.h
> > > @@ -0,0 +1,25 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef _ASM_GENERIC_BITOPS___BITREV_H_
> > > +#define _ASM_GENERIC_BITOPS___BITREV_H_
> > > +
> > > +#ifdef CONFIG_GENERIC_BITREVERSE
> > 
> > The dependencies of this symbol seem insufficient, as I can trigger a
> > build failure on next-20260429 like so:
> > 
> >   $ make -skj"$(nproc)" ARCH=s390 CROSS_COMPILE=s390-linux- mrproper tinyconfig fs/select.o
> >   In file included from include/linux/crc32.h:6,
> >                    from include/linux/etherdevice.h:23,
> >                    from include/linux/if_vlan.h:11,
> >                    from include/linux/filter.h:21,
> >                    from include/net/xdp.h:10,
> >                    from include/net/busy_poll.h:19,
> >                    from fs/select.c:33:
> >   include/linux/etherdevice.h: In function 'eth_hw_addr_crc':
> >   include/linux/bitrev.h:16:20: error: implicit declaration of function 'generic___bitrev32' [-Wimplicit-function-declaration]
> >      16 | #define __bitrev32 generic___bitrev32
> >         |                    ^~~~~~~~~~~~~~~~~~
> >   include/linux/bitrev.h:67:9: note: in expansion of macro '__bitrev32'
> >      67 |         __bitrev32(__x);                                \
> >         |         ^~~~~~~~~~
> >   include/linux/crc32.h:107:36: note: in expansion of macro 'bitrev32'
> >     107 | #define ether_crc(length, data)    bitrev32(crc32_le(~0, data, length))
> >         |                                    ^~~~~~~~
> >   include/linux/etherdevice.h:292:16: note: in expansion of macro 'ether_crc'
> >     292 |         return ether_crc(ETH_ALEN, ha->addr);
> >         |                ^~~~~~~~~
> >   make[5]: *** [scripts/Makefile.build:289: fs/select.o] Error 1
> >   ...
> > 
> >   $ scripts/config -s BITREVERSE
> >   undef
> > 
> >   $ rg BITREVERSE .config
> 
> Confirm the same for x86 tinyconfig.
> 
> The problem is that the patch makes generic bitrevXX() conditional
> on CONFIG_GENERIC_BITREVERSE, while before they were conditional on
> !CONFIG_HAVE_ARCH_BITREVERSE. So if you don't have arch bitreverse(),
> and dont' enable BITREVERSE, the generic implementation is not defined
> now.
> 
> Luckily, the only user of bitrev() in unconditionally compiled objects
> is CRC32, and it's not needed if CRC32 is disabled.
> 
> This is the minimal working fix for me. Please let me know what do you
> think. I can prepend Jinjie's pathes in my tree with it if it's OK for
> you.

I will run it through my full build matrix overnight and report back
with any problems noticed.

> diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
> index df8f88f63a70..245b206dd38b 100644
> --- a/include/linux/etherdevice.h
> +++ b/include/linux/etherdevice.h
> @@ -20,7 +20,9 @@
>  #include <linux/if_ether.h>
>  #include <linux/netdevice.h>
>  #include <linux/random.h>
> +#ifdef CONFIG_CRCC32

Initial testing shows that this should be

  #ifdef CONFIG_CRC32

here and below though.

>  #include <linux/crc32.h>
> +#endif
>  #include <linux/unaligned.h>
>  #include <asm/bitsperlong.h>
>  
> @@ -281,6 +283,7 @@ static inline void eth_hw_addr_random(struct net_device *dev)
>  	dev->addr_assign_type = NET_ADDR_RANDOM;
>  }
>  
> +#ifdef CONFIG_CRCC32
>  /**
>   * eth_hw_addr_crc - Calculate CRC from netdev_hw_addr
>   * @ha: pointer to hardware address
> @@ -291,6 +294,7 @@ static inline u32 eth_hw_addr_crc(struct netdev_hw_addr *ha)
>  {
>  	return ether_crc(ETH_ALEN, ha->addr);
>  }
> +#endif
>  
>  /**
>   * ether_addr_copy - Copy an Ethernet address

-- 
Cheers,
Nathan
