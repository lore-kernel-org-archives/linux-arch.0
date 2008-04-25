From: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Subject: Re: [PATCH 01/24] types: create <asm-generic/int-*.h>
Date: Fri, 25 Apr 2008 13:30:30 -0700 (PDT)
Message-ID: <20080425.133030.229754755.davem@davemloft.net>
References: <1209078352-7593-2-git-send-email-hpa@zytor.com>
	<1209078352-7593-3-git-send-email-hpa@zytor.com>
	<alpine.LNX.1.10.0804252026040.20150@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.1.10.0804252026040.20150-vVwEwcwQeYFPkBl3ERsXe1l1cybopEuJUBSOeVevoDU@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: jengelh-bdq14YP6qtRlEiWPh9xO2Q@public.gmane.org
Cc: hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Jan Engelhardt <jengelh-bdq14YP6qtRlEiWPh9xO2Q@public.gmane.org>
Date: Fri, 25 Apr 2008 20:27:53 +0200 (CEST)

> On Friday 2008-04-25 01:05, H. Peter Anvin wrote:
> 
> >This creates two generic files with common integer definitions; one
> >where 64 bits is "long" (most 64-bit architectures) and one where 64
> >bits is "long long" (all 32-bit architectures and x86-64.)
> 
> long long is 64 bits on both 32 and 64, is not it?
> If so, the split between 32 and 64 should not be necessary.

Because of the large precendence, if you change this stuff, you're
going to get tons of warnings on the platforms that use "unsigned
long" currently if you change them to use "unsigned long long".

Think about all of the implicit type conversions, argument passing,
et al.

I know because I tried to convert sparc64 over to "unsigned long long"
to make it more like powerpc, and I found quickly that fixing up all
the fallout simply was not worth it.
