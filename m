Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:42733 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752310AbdGCKUI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jul 2017 06:20:08 -0400
Date: Mon, 3 Jul 2017 12:18:28 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/1] futex: remove duplicated code and fix UB
In-Reply-To: <80af8d81-4522-de2d-8289-1ab46565505a@suse.cz>
Message-ID: <alpine.DEB.2.20.1707031211120.2188@nanos>
References: <20170621115318.2781-1-jslaby@suse.cz> <alpine.DEB.2.20.1706230017520.2221@nanos> <80af8d81-4522-de2d-8289-1ab46565505a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: Will Deacon <will.deacon@arm.com>, mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org, linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
Message-ID: <20170703101828.pegwgGTIapE6Kcr6ZRhIgUDLmYTS8X5CJrdDxMaz2j0@z>

On Mon, 26 Jun 2017, Jiri Slaby wrote:
> On 06/23/2017, 09:51 AM, Thomas Gleixner wrote:
> > On Wed, 21 Jun 2017, Jiri Slaby wrote:
> >> diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
> >> index f32b42e8725d..5bb2fd4674e7 100644
> >> --- a/arch/arm64/include/asm/futex.h
> >> +++ b/arch/arm64/include/asm/futex.h
> >> @@ -48,20 +48,10 @@ do {									\
> >>  } while (0)
> >>  
> >>  static inline int
> >> -futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
> > 
> > That unsigned int seems to be a change from the arm64 tree in next. It's
> > not upstream and it'll cause a (easy to resolve) conflict.
> 
> Ugh, I thought the arm64 is in upstream already. Note that this patch
> just takes what is in this arm64 fix and makes it effective for all
> architectures. So I will wait with v2 until it merges upstream.

Ok.

> > Yes, we probably can't change that anymore, but at least we should make it
> > very explicit and add a comment to that effect.
> 
> Something like this or do you want a comment yet?
>         unsigned int op =         (encoded_op & 0x70000000) >> 28;
>         unsigned int cmp =        (encoded_op & 0x0f000000) >> 24;
>         int oparg = sign_extend32((encoded_op & 0x00fff000) >> 12, 12);
>         int cmparg = sign_extend32(encoded_op & 0x00000fff, 12);

Yes, that makes sense.

There is also the issue with the shift. See this thread for further
reference:

  http://lkml.kernel.org/r/alpine.DEB.2.20.1706282353190.1890@nanos

The gist is:

  "Anything using a shift value < 0 or > 31 will get crap as a
   result. Rightfully so because it's just undefined.

   Yes I know that the insanity of user space is unlimited, but anything
   attempting this is so broken that we cannot break it further by making
   that shift arg unsigned and actually limit it to 0-31"

So we should make that case explicit as well.

        if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28)) {
		if (oparg < 0 || oparg > 31)
			return -EINVAL;
                oparg = 1 << oparg;
	}

Thanks,

	tglx
