From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/6] improve sys_personality for compat architectures
Date: Tue, 2 Feb 2010 15:36:51 +0100
Message-ID: <201002021536.51928.arnd@arndb.de>
References: <20100201185607.GD11045@lst.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:55271 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595Ab0BBOhw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2010 09:37:52 -0500
In-Reply-To: <20100201185607.GD11045@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tony.luck@intel.com, ralf@linux-mips.org, kyle@mcmartin.ca, benh@kernel.crashing.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, viro@zeniv.linux.org.uk

On Monday 01 February 2010, Christoph Hellwig wrote:
> +/*
> + * Get/set the personality.
> + *
> + * Note that we simply return PER_LINUX even if we actually have a 32-bit
> + * task (PER_LINUX32) as this is expected by 32-bit userland.
> + */
>  SYSCALL_DEFINE1(personality, u_long, personality)
>  {
>         u_long old = current->personality;
>  
>         if (personality != 0xffffffff) {
> +               if (personality(old) == PER_LINUX32 &&
> +                   personality == PER_LINUX)
> +                       personality = PER_LINUX32;
>                 set_personality(personality);
>                 if (current->personality != personality)
>                         return -EINVAL;
>         }
>  
> -       return (long)old;
> +       return (long)(old == PER_LINUX32 ? PER_LINUX : old);
>  }

What does this do for a native 64 bit process setting PER_LINUX32?
It looks to me like it could never set it back to the original
value, or am I missing something here?

It's what the arch specific code does already, but it seems a bit
strange anyway.

	Arnd
