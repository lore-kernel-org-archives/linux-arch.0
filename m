From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 2/6] powerpc/pseries: move some PAPR paravirt functions to their own file
Date: Thu, 09 Jul 2020 20:11:29 +1000
Message-ID: <87d055vvzi.fsf@mpe.ellerman.id.au>
References: <20200706043540.1563616-1-npiggin@gmail.com> <20200706043540.1563616-3-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.11.71.1]:43361 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbgGIKJS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Jul 2020 06:09:18 -0400
In-Reply-To: <20200706043540.1563616-3-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Anton Blanchard <anton@ozlabs.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org

Nicholas Piggin <npiggin@gmail.com> writes:
>

Little bit of changelog would be nice :D

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/paravirt.h | 61 +++++++++++++++++++++++++++++
>  arch/powerpc/include/asm/spinlock.h | 24 +-----------
>  arch/powerpc/lib/locks.c            | 12 +++---
>  3 files changed, 68 insertions(+), 29 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/paravirt.h
>
> diff --git a/arch/powerpc/include/asm/paravirt.h b/arch/powerpc/include/asm/paravirt.h
> new file mode 100644
> index 000000000000..7a8546660a63
> --- /dev/null
> +++ b/arch/powerpc/include/asm/paravirt.h
> @@ -0,0 +1,61 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef __ASM_PARAVIRT_H
> +#define __ASM_PARAVIRT_H

Should be _ASM_POWERPC_PARAVIRT_H

> +#ifdef __KERNEL__

We shouldn't need __KERNEL__ in here, it's not a uapi header.

cheers
