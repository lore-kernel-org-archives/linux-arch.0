From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: Re: [PATCH v4 09/24] bitops: introduce little-endian bitops for
 most architectures
Date: Mon, 17 Jan 2011 11:01:52 +0100
Message-ID: <1295258512.15492.13.camel@hcegtvedt>
References: <1295183333-13802-1-git-send-email-akinobu.mita@gmail.com>
	 <1295183333-13802-10-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1295183333-13802-10-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Bryan Wu <bryan.wu@analog.com>, Mikael Starvik <starvik@axis.com>, David Howells <dhowells@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "Luck, Tony" <tony.luck@intel.com>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@mcmartin.ca>, Matthew Wilcox <willy@debian.org>, Grant Grundler <grundler@parisc-linux.org>, Paul Mundt <lethal@linux-sh.org>, Kazumoto Kojima <kkojima@rr.iij4u.or.jp>, "David S. Miller" <davem@davemloft.net>, Chris Zankel <chris@zankel.net>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-arch.vger.kernel.org

On Sun, 2011-01-16 at 22:08 +0900, Akinobu Mita wrote: 
> Introduce little-endian bit operations to the architectures which do not
> have native little-endian bit operations.  (alpha, avr32, blackfin, cris,
> frv, h8300, ia64, m32r, mips, mn10300, parisc, sh, sparc, tile, x86,
> xtensa)
> 
> These architectures can just include generic implementation
> (asm-generic/bitops/le.h).
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
> Cc: Bryan Wu <bryan.wu@analog.com>
> Cc: Mikael Starvik <starvik@axis.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: "Luck, Tony" <tony.luck@intel.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Kyle McMartin <kyle@mcmartin.ca>
> Cc: Matthew Wilcox <willy@debian.org>
> Cc: Grant Grundler <grundler@parisc-linux.org>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: Kazumoto Kojima <kkojima@rr.iij4u.or.jp>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
> Change from v3:
>  - No change
> 
> The whole series is available in the git repository at:
>  git://git.kernel.org/pub/scm/linux/kernel/git/mita/linux-2.6.git le-bitops-v4
> 
>  arch/alpha/include/asm/bitops.h              |    1 +
>  arch/avr32/include/asm/bitops.h              |    1 +

For the AVR32 related change,

Acked-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>

<snipp>

-- 
Hans-Christian Egtvedt
