Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out6.electric.net ([192.162.217.191]:64378 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbeGIN3M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2018 09:29:12 -0400
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH] atomic{64}_t: Explicitly specify data storage length and
 alignment
Date: Mon, 9 Jul 2018 13:30:43 +0000
Message-ID: <3d3ec70d99524a6fa7a38e7d2e0fdf98@AcuMS.aculab.com>
References: <20180709124741.21037-1-abrodkin@synopsys.com>
In-Reply-To: <20180709124741.21037-1-abrodkin@synopsys.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Alexey Brodkin' <Alexey.Brodkin@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, Shuah Khan <shuah@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <20180709133043.icURMT9j6TidbT8eN78AagmN3BM9o1xalPui2ZC8ugI@z>

From: Alexey Brodkin
> Sent: 09 July 2018 13:48
> Atomic instructions require data they operate on to be aligned
> according to data size. I.e. 32-bit atomic values must be 32-bit
> aligned while 64-bit values must be 64-bit aligned.
> 
> Otherwise even if CPU may handle not-aligend normal data access,
> still atomic instructions fail and typically raise an exception
> leaving us dead in the water.
...
> diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
> index 8d28eb010d0d..b94b749b5952 100644
> --- a/include/asm-generic/atomic64.h
> +++ b/include/asm-generic/atomic64.h
> @@ -13,7 +13,7 @@
>  #define _ASM_GENERIC_ATOMIC64_H
> 
>  typedef struct {
> -	long long counter;
> +	u64 __aligned(8) counter;
>  } atomic64_t;

Apart from the fact that this changes the value from signed to unsigned
should most of the architectures be using this generic definition?

The only exceptions would be 32bit architectures that lack 64bit
instructions (eg m68k).

	David
