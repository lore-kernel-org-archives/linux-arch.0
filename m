From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH 07/11] powerpc: Move arch-specific prctls out of core code
Date: Tue, 15 May 2018 13:06:31 +1000
Message-ID: <87fu2tpqh4.fsf@concordia.ellerman.id.au>
References: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com> <1526318067-4964-8-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526318067-4964-8-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
List-Id: linux-arch.vger.kernel.org

Dave Martin <Dave.Martin@arm.com> writes:

> This patch moves the powerpc-specific prctl call implementations
> out of core code and removes redundant boilerplate associated with
> them.
>
> No functional change.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/Kconfig                 |  1 +
>  arch/powerpc/include/asm/processor.h |  6 ------
>  arch/powerpc/kernel/syscalls.c       | 17 +++++++++++++++++
>  kernel/sys.c                         | 24 ------------------------
>  4 files changed, 18 insertions(+), 30 deletions(-)

This also looks OK to me.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
