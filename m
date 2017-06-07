From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 04/17] Documentation: atomic_ops.txt is
 core-api/atomic_ops.rst
Date: Wed, 7 Jun 2017 10:20:54 +0100
Message-ID: <20170607092053.GA30263@arm.com>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-5-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57728 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750739AbdFGJUr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Jun 2017 05:20:47 -0400
Content-Disposition: inline
In-Reply-To: <20170606230007.19101-5-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net, albert@sifive.com, patches@groups.riscv.org

On Tue, Jun 06, 2017 at 03:59:54PM -0700, Palmer Dabbelt wrote:
> I was reading the memory barries documentation in order to make sure the
> RISC-V barries were correct, and I found a broken link to the atomic
> operations documentation.
> 
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> ---
>  Documentation/memory-barriers.txt | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will

> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 732f10ea382e..f1c9eaa45a57 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -498,11 +498,11 @@ And a couple of implicit varieties:
>       This means that ACQUIRE acts as a minimal "acquire" operation and
>       RELEASE acts as a minimal "release" operation.
>  
> -A subset of the atomic operations described in atomic_ops.txt have ACQUIRE
> -and RELEASE variants in addition to fully-ordered and relaxed (no barrier
> -semantics) definitions.  For compound atomics performing both a load and a
> -store, ACQUIRE semantics apply only to the load and RELEASE semantics apply
> -only to the store portion of the operation.
> +A subset of the atomic operations described in core-api/atomic_ops.rst have
> +ACQUIRE and RELEASE variants in addition to fully-ordered and relaxed (no
> +barrier semantics) definitions.  For compound atomics performing both a load
> +and a store, ACQUIRE semantics apply only to the load and RELEASE semantics
> +apply only to the store portion of the operation.
>  
>  Memory barriers are only required where there's a possibility of interaction
>  between two CPUs or between a CPU and a device.  If it can be guaranteed that
> -- 
> 2.13.0
> 
