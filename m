Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEAC19E97B;
	Wed,  6 May 2026 06:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778049124; cv=none; b=GuNxvfM2ncWma9U/VjesfGbPdMybPwporLS6GbGSyK4B84eMbl/wmvE07YdqxrON/jHZumgkOFWESDcPVh9GHDKcfCoD4XsbxdnrkYSSPn4If+A7b/sextUpi5uOeQ0vuiI4AA+wRKZR/2pzNVX61BBu/aj+j6SGfSl/WUpf4VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778049124; c=relaxed/simple;
	bh=SB5tDwl8GpNdeE6O/6YQk+V4Mr/UoFQkPrb3axoem68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0W2TS22r5uBhOpsNXqhTddNTvC61Hcvn++iLnpGFZF9uow2+obmMWlu8j7CpuWUJAqYbA3FI0546+xFkI9O+UxA5RdxL4Jynx1ck2FReh1u8znKvbom4JLn/YyQrXh8eLy6oJPJbpMHO/mKsyJ14ACTKVljgSB/0Bjn3h/ImRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fF3bycpX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fF3bycpX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C28CC2BCB8;
	Wed,  6 May 2026 06:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778049123;
	bh=SB5tDwl8GpNdeE6O/6YQk+V4Mr/UoFQkPrb3axoem68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fF3bycpXWafr2E6qk4jaQsRplkyTXsst0PRy82bGKoHCkbGw5g55yRzCrynQZrzSc
	 lYaMvU0ovlHM96IMGqQ8UiJlXcxZQgufTf8zhcbBL5SI9TdNCaBL2+KgSAAb+fSrMY
	 BZIJCpMEMPwVlNs/BBLTqSaB7boxgxCYH3lLSyyy3+r/SybHOg11xhMNc4t52yxmjZ
	 yDIfF8tEAWfK2HS5pjFirlhbQXRy2txnNcm4TTRiQUsbThXjrpkvmu4NeMjVm1tIxh
	 RD3VVd4bWsnrwfkRUCOvP8hJS5VwyVAsHHRjNLyAbTLGCAnrQZuBqOyTTRKv2IbwxY
	 2iwODr94mwEbg==
Date: Tue, 5 May 2026 23:30:43 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Yury Norov <ynorov@nvidia.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ruan Jinjie <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Linux-Arch <linux-arch@vger.kernel.org>,
	Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 1/6] lib: include crc32.h conditionally on CONFIG_CRC32
Message-ID: <20260506063043.GB16204@sol>
References: <20260430211351.658193-1-ynorov@nvidia.com>
 <20260430211351.658193-2-ynorov@nvidia.com>
 <ec4ed7f5-b1c8-49e4-b83d-e29c5414b9de@app.fastmail.com>
 <afjNaToyptiMogV4@yury>
 <9d45acd1-667b-4acf-9e2e-bcd79630d726@app.fastmail.com>
 <afjmIK4mlCWeywuS@yury>
 <abf4a586-b675-4e29-9570-fd3ed4158f58@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abf4a586-b675-4e29-9570-fd3ed4158f58@app.fastmail.com>

On Mon, May 04, 2026 at 09:05:30PM +0200, Arnd Bergmann wrote:
> On Mon, May 4, 2026, at 20:32, Yury Norov wrote:
> > On Mon, May 04, 2026 at 07:18:49PM +0200, Arnd Bergmann wrote:
> >> On Mon, May 4, 2026, at 18:46, Yury Norov wrote:
> >> > Never heard about such a thing like "optional interface". And git grep
> >> > tends to second that...
> >> 
> >> I meant any library interface that can be turned on or off
> >
> > So? If I disable CRC32, can I use the either_crc()? In case of that
> > networking header, the answer is yes. In some other piece of code
> > the answer is no. Is that correct?
> 
> Since it's a macro defiend in terms of both bitref32 and
> crc32_le, you can only call it from dead code, such as an
> inline function that is not itself used, or from inside of
> a block that is protected with IS_ENABLED(CONFIG_CRC32) etc.
>   
> >> >> 
> >> >> Don't add #ifdef blocks around headers. If the header cannot
> >> >> be included without side-effects, change the linux/crc32.h
> >> >> file instead of its users.
> >> >
> >> > linux/acpi.h does that like many othes. What exactly is wrong with
> >> > protecting headers inclusion?
> >> 
> >> There is no "protecting" here, you just add complexity to the
> >> build when headers are sometimes included indirectly and but
> >> other times are not, depending on kernel configuration.
> >
> > Sorry, don't understand... I use the 'protecting' term with the meaning:
> > the functionality that is explicitly disabled should be never used.
> > Otherwise, what for we disable it?
> 
> Arguably, both configuration symbols are at the point of not actually
> saving enough object code size to actually be worth the Kconfig
> dependencies.
> 
> As long as we have CONFIG_CRC32 and CONFIG_BITREVERSE, the
> point of having the Kconfig symbols is to let drivers request
> the inclusion of the library helpers.
> 
> >> It's unlikely to cause problems for the crc32.h header, but
> >> the acpi example definitely risks running into circular
> >> inclusions when you end up with some other header that depending
> >> on configuration ends up including linux/acpi.h while also
> >> bring included indirectly from that one.
> >> 
> >> >> It looks like the problem is the check for CONFIG_GENERIC_BITREVERSE
> >> >> in include/asm-generic/bitops/__bitrev.h, which ends up
> >> >> hinding the generic___bitrev32() helper without need.
> >> >> 
> >> >> Simply removing the #ifdef there should avoid the build failure.
> >> >
> >> > OK, it seems like this is what I don't understand.
> >> >
> >> > We've got an optional feature, like CRC32, which is enabled by
> >> > CONFIG_CRC32. The most conservative way is to declare everything
> >> > CRC32-related in the corresponding header, and then protect the header
> >> > with IS_ENABLED(CONFIG_CRC32).
> >> >
> >> > I understand that from practical perspective, we can declare some simple
> >> > macros, like header size, unprotected. But what we've got now is a sort
> >> > of mess: all CRC32-related functions are declared unprotected, and
> >> > generic headers are good to use them. Compiler is happy while those
> >> > functions are actually unused. Next, CRC32 depends on BITREVERSE, which
> >> > is again unprotected, and it may optionally have an arch implementation.
> >> >
> >> > So if arch bitrev() is implemented, you can use part of bitreverse and
> >> > crc32 APIs despite that they are explicitly disabled - just because they
> >> > are implemented as macros in unprotected headers. And you cannot use some
> >> > others - because they are implemented differently, as a real functions.
> >> 
> >> I think you trying to solve a non-problem here.
> >
> > This was reported by Nathan for tinyconfig. At least x86 and s390 are
> > affected.
> >
> > https://lore.kernel.org/all/20260429202922.GA3575295@ax162/
> >
> > Is tinyconfig important?
> 
> Nathan reported a build regression caused by a small mistake
> in 596a9ea9015b ("bitops: Define generic __bitrev8/16/32 for reuse"),
> which is of course needs to be fixed.
> 
> What I meant is that there is no reason to not use the obvious
> fix and do
> 
> --- a/include/asm-generic/bitops/__bitrev.h
> +++ b/include/asm-generic/bitops/__bitrev.h
> @@ -2,7 +2,6 @@
>  #ifndef _ASM_GENERIC_BITOPS___BITREV_H_
>  #define _ASM_GENERIC_BITOPS___BITREV_H_
>  
> -#ifdef CONFIG_GENERIC_BITREVERSE
>  #include <asm/types.h>
>  
>  extern u8 const byte_rev_table[256];
> @@ -20,6 +19,5 @@ static __always_inline __attribute_const__ u32 generic___bitrev32(u32 x)
>  {
>         return (generic___bitrev16(x & 0xffff) << 16) | generic___bitrev16(x >> 16);
>  }
> -#endif /* CONFIG_GENERIC_BITREVERSE */
>  
>  #endif /* _ASM_GENERIC_BITOPS___BITREV_H_ */
> 
> > Right now half CRC32 is available if CONFIG_CRC32 is on, and half is
> > not available. The bitreverse is the same. If HAVE_ARCH_BITREVERSE is
> > enabled, one can use the API, bypassing the BITREVERSE. This doesn't
> > sound right to me long-term.
> >
> > Whatever this ends up, let's figure out a consistent solution please?
> 
> I really don't think we need any sort of solution here, aside from
> the trivial regression fix that returns it to the previous working
> state.

I agree with Arnd.  The standard practice in the kernel is for headers
to be includeable even when the associated kconfig (if any) isn't
enabled.  In such a case usually the inline functions, macros, and the
declarations of out-of-line functions and global variables are still
made available in the header.

The point of the kconfig symbol is just to build the file containing the
definitions of out-of-line functions and global variables.

Yes, when those definitions are needed and calling code forgets to
select that kconfig symbol, a build error results.  But it's "only" a
build error; those get found and fixed relatively easily.  The
alternative of hiding everything would mean a lot more #ifdefs in other
code, which ends up being very messy.

- Eric
