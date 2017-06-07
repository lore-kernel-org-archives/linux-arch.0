From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 13/17] RISC-V: Add include subdirectory
Date: Wed, 7 Jun 2017 13:54:23 +0200
Message-ID: <20170607115423.qdhpl5dhtmmq4q4u@hirez.programming.kicks-ass.net>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-14-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:46960 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751403AbdFGLyf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Jun 2017 07:54:35 -0400
Content-Disposition: inline
In-Reply-To: <20170606230007.19101-14-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net, albert@sifive.com, patches@groups.riscv.org

On Tue, Jun 06, 2017 at 04:00:03PM -0700, Palmer Dabbelt wrote:
> +/* Assume that atomic operations are already serializing */
> +#define smp_mb__before_atomic_dec()	barrier()
> +#define smp_mb__after_atomic_dec()	barrier()
> +#define smp_mb__before_atomic_inc()	barrier()
> +#define smp_mb__after_atomic_inc()	barrier()

> +#define smp_mb__before_clear_bit()  smp_mb()
> +#define smp_mb__after_clear_bit()   smp_mb()

These no longer exist.. Also how can they be different? bitops would use
the same atomic primitives as regular atomic ops would and would thus
have the very same implicit ordering.
