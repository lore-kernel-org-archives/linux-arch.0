Return-Path: <owner-linux-mm@kvack.org>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v4 6/9] asm-generic/tlb: Rename HAVE_RCU_TABLE_FREE
In-Reply-To: <20200116064531.483522-7-aneesh.kumar@linux.ibm.com>
References: <20200116064531.483522-1-aneesh.kumar@linux.ibm.com>
 <20200116064531.483522-7-aneesh.kumar@linux.ibm.com>
Date: Sat, 18 Jan 2020 11:26:40 +0530
Message-ID: <87v9p9mhnr.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linux-mm@kvack.org
To: akpm@linux-foundation.org, peterz@infradead.org, will@kernel.org, mpe@ellerman.id.au, davem@davemloft.net
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200118055640.wqQAjGHmrRyZQxfHGoqFUyLdvK4klK5kXjoiIN0jagU@z>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> From: Peter Zijlstra <peterz@infradead.org>
>
> Towards a more consistent naming scheme.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

...

> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 18e9fb6fcf1b..c703eb6b7461 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -64,7 +64,7 @@ config SPARC64
>  	select HAVE_FUNCTION_GRAPH_TRACER
>  	select HAVE_KRETPROBES
>  	select HAVE_KPROBES
> -	select HAVE_RCU_TABLE_FREE if SMP
> +	select MMU_GATHER_RCU_TABLE_FREE
>  	select HAVE_MEMBLOCK_NODE_MAP
>  	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
>  	select HAVE_DYNAMIC_FTRACE

This resulted in build failure reported by kbuild test robot. Can we
fold the below change

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index c703eb6b7461..02907584be2d 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -64,7 +64,7 @@ config SPARC64
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_KRETPROBES
 	select HAVE_KPROBES
-	select MMU_GATHER_RCU_TABLE_FREE
+	select MMU_GATHER_RCU_TABLE_FREE if SMP
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_DYNAMIC_FTRACE

We should handle that drop of SMP in a separate patch if needed.

-aneesh
