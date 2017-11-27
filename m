Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38192 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752475AbdK0N5b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Nov 2017 08:57:31 -0500
Date: Mon, 27 Nov 2017 13:57:25 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 10/35] nds32: Atomic operations
Message-ID: <20171127135724.yy2jjjuby3xu74mm@lakrids.cambridge.arm.com>
References: <cover.1511785528.git.green.hu@gmail.com>
 <56a24fae3cec68f80c41eebd98fcceb9b137ac64.1511785528.git.green.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56a24fae3cec68f80c41eebd98fcceb9b137ac64.1511785528.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, Vincent Chen <vincentc@andestech.com>
Message-ID: <20171127135725.LobVtP0lK0idlq8LsGDKg2k_bDOiQktH_g1E3f9bnoQ@z>

Hi,

On Mon, Nov 27, 2017 at 08:27:57PM +0800, Greentime Hu wrote:
> +static inline void arch_spin_unlock(arch_spinlock_t * lock)
> +{
> +	asm volatile(
> +		"xor	$r15,  $r15, $r15\n"
> +		"swi	$r15, [%0]\n"
> +		:
> +		:"r"(&lock->lock)
> +		:"memory");
> +}

This looks suspicious. There's no clobber for $r15, so isn't this
corrupting a GPR behind the back of the compiler?

Shouldn't there be a tmp variable for the register allocation rather
than hard-coding $r15?

> +static inline void arch_write_unlock(arch_rwlock_t * rw)
> +{
> +	asm volatile(
> +		"xor	$r15, $r15, $r15\n"
> +		"swi	$r15, [%0]\n"
> +		:
> +		:"r"(&rw->lock)
> +		:"memory","$r15");
> +}

This time you have a clobber, but it's still not clear to me why you
don't use a tmp variable and leave the register allocation to the
compiler.

Thanks,
Mark.
