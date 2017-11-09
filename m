From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 18/31] nds32: Library functions
Date: Thu, 9 Nov 2017 00:40:20 +0000
Message-ID: <20171109004020.GX21978@ZenIV.linux.org.uk>
References: <cover.1510118606.git.green.hu@gmail.com>
 <ea57a25c0aceab45d36951fed44cfbecfe1540b8.1510118606.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:36306 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752182AbdKIAk2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2017 19:40:28 -0500
Content-Disposition: inline
In-Reply-To: <ea57a25c0aceab45d36951fed44cfbecfe1540b8.1510118606.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, Vincent Chen <vincentc@andestech.com>

On Wed, Nov 08, 2017 at 01:55:06PM +0800, Greentime Hu wrote:

> +#define __range_ok(addr, size) (size <= get_fs() && addr <= (get_fs() -size))
> +
> +#define access_ok(type, addr, size)                 \
> +	__range_ok((unsigned long)addr, (unsigned long)size)

> +#define __get_user_x(__r2,__p,__e,__s,__i...)				\
> +	   __asm__ __volatile__ (					\
> +		__asmeq("%0", "$r0") __asmeq("%1", "$r2")		\
> +		"bal	__get_user_" #__s				\

... which does not check access_ok() or do any visible equivalents; OK...

> +#define get_user(x,p)							\
> +	({								\
> +		const register typeof(*(p)) __user *__p asm("$r0") = (p);\
> +		register unsigned long __r2 asm("$r2");			\
> +		register int __e asm("$r0");				\
> +		switch (sizeof(*(__p))) {				\
> +		case 1:							\
> +			__get_user_x(__r2, __p, __e, 1, "$lp");		\

... and neither does this, which is almost certainly *not* OK.

> +#define put_user(x,p)							\

Same here, AFAICS.

> +extern unsigned long __arch_copy_from_user(void *to, const void __user * from,
> +					   unsigned long n);

> +static inline unsigned long raw_copy_from_user(void *to,
> +					       const void __user * from,
> +					       unsigned long n)
> +{
> +	return __arch_copy_from_user(to, from, n);
> +}

Er...  Why not call your __arch_... raw_... and be done with that?

> +#define INLINE_COPY_FROM_USER
> +#define INLINE_COPY_TO_USER

Are those actually worth bothering?  IOW, have you compared behaviour
with and without them?

> +ENTRY(__arch_copy_to_user)
> +	push	$r0
> +	push	$r2
> +	beqz	$r2, ctu_exit
> +	srli	$p0, $r2, #2		! $p0 = number of word to clear
> +	andi	$r2, $r2, #3		! Bytes less than a word to copy
> +	beqz	$p0, byte_ctu		! Only less than a word to copy
> +word_ctu:
> +	lmw.bim	$p1, [$r1], $p1		! Load the next word
> +USER(	smw.bim,$p1, [$r0], $p1)	! Store the next word

Umm...  It's that happy with unaligned loads and stores?  Your memcpy seems
to be trying to avoid those...

> +9001:
> +	pop	$p1			! Original $r2, n
> +	pop	$p0			! Original $r0, void *to
> +	sub	$r1, $r0, $p0		! Bytes copied
> +	sub	$r2, $p1, $r1		! Bytes left to copy
> +	push	$lp
> +	move	$r0, $p0
> +	bal	memzero			! Clean up the memory

Just what memory are you zeroing here?  The one you had been
unable to store into in the first place?

> +ENTRY(__arch_copy_from_user)

> +9001:
> +	pop	$p1			! Original $r2, n
> +	pop	$p0			! Original $r0, void *to
> +	sub	$r1, $r1, $p0		! Bytes copied
> +	sub	$r2, $p1, $r1		! Bytes left to copy
> +	push	$lp
> +	bal	memzero			! Clean up the memory

Ditto, only this one is even worse - instead of just oopsing on
you, it will quietly destroy data past the area you've copied
into.  raw_copy_..._user() MUST NOT ZERO ANYTHING.  Ever.
