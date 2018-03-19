Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from la.guarana.org ([173.254.219.205]:52158 "EHLO la.guarana.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755169AbeCSGiz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Mar 2018 02:38:55 -0400
Date: Mon, 19 Mar 2018 02:29:29 -0400
From: Kevin Easton <kevin@guarana.org>
Subject: Re: [RFC PATCH 2/6] fs: provide a generic compat_sys_truncate64()
 implementation
Message-ID: <20180319062928.GA11309@la.guarana.org>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-3-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180318161056.5377-3-linux@dominikbrodowski.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, arnd@arndb.de, viro@ZenIV.linux.org.uk, linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>, x86@kernel.org
Message-ID: <20180319062929.Tb2a2bpyONH48UK0400RvhCnCFieXCj10gnlOhPVVW4@z>

On Sun, Mar 18, 2018 at 05:10:52PM +0100, Dominik Brodowski wrote:
> The compat_sys_truncate64() implementations in mips, powerpc, s390, sparc
> and x86 only differed based on whether the u64 parameter needed padding
> and on its endianness.
> 

...
  
> +#ifdef __ARCH_WANT_COMPAT_SYS_TRUNCATE64
> +#if defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +	defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE4(truncate64, const char __user *, filename, u32 padding,
> +		       unsigned int, offset_low, unsigned int, offset_high)
> +#elif defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +	!defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE4(truncate64, const char __user *, filename, u32 padding,
> +		       unsigned int, offset_high, unsigned int, offset_low)

Notwithstanding the other comments, shouldn't there be a comma between
'u32' and 'padding' in those?

    - Kevin
