From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] Kconfig.debug: Add FRAME_POINTER anti-dependency for
 ARC
Date: Fri, 30 Aug 2013 08:20:26 -0700
Message-ID: <5220B83A.6070709@intel.com>
References: <1377592285-21148-1-git-send-email-vgupta@synopsys.com> <521F662F.4050003@intel.com> <52204E4D.3030602@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:9456 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754478Ab3H3PUt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 Aug 2013 11:20:49 -0400
In-Reply-To: <52204E4D.3030602@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <vineetg76@gmail.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paul.mckenney@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Michel Lespinasse <walken@google.com>, "David S. Miller" <davem@davemloft.net>, Paul Mundt <lethal@linux-sh.org>, Arnd Bergmann <arnd@arndb.de>, Chris Metcalf <cmetcalf@tilera.com>

On 08/30/2013 12:48 AM, Vineet Gupta wrote:
> If we had ARCH_FRAME_POINTER_UNAVAILABLE (def_bool n), we could potentially remove
> ARCH_FRAME_POINTER too:
> 
> 1. arches which explicitly select ARCH_FRAME_POINTER (xtensa, parisc, arm64, x86,
> unicore32, tile) could just drop that select.
> 
> 2. Others which add themselves to config FRAME_POINTER depends on (CRIS, M68K,
> FRV, UML, AVR32, SUPERH, BLACKFIN, MN10300, METAG) can simply be removed form that
> list.
> 
> 3. Other who want to inhibit FP obviously select it (MIPS, PPC, S390, MICROBLAZE,
> ARM_UNWIND, ARC)

That all seems sane to me.

> The issue is some (sparc, c6x...) which are neither in #1 or #2, and not present
> in anti-dependency list either. e.g. With sparc64_defconfig FP is not present, but
> if I enable LATENCY_TOP, FP is enabled. For such cases, what do we make default ?

You can list multiple defaults if you want, or have them depend on other
config variables:

config FOO
	default BAR

or

config FOO
	default y if BAR
	default n if BAZ

ARCH_FRAME_POINTER_UNAVAILABLE doesn't make much sense if
FRAME_POINTER=n, right?  You can have it just plain depend on
FRAME_POINTER, I think.
