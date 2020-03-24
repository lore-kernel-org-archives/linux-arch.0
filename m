From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH v4 4/6] mm: Add page table level flags to vm_flags
Date: Tue, 24 Mar 2020 14:44:36 -0400
Message-ID: <20200324144436.043659c2@gandalf.local.home>
References: <20200324134534.1570-1-yezhenyu2@huawei.com>
        <20200324134534.1570-5-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbgCXSok (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Mar 2020 14:44:40 -0400
In-Reply-To: <20200324134534.1570-5-yezhenyu2@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Cc: will@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, peterz@infradead.org, arnd@arndb.de, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com

On Tue, 24 Mar 2020 21:45:32 +0800
Zhenyu Ye <yezhenyu2@huawei.com> wrote:

> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -130,6 +130,16 @@ IF_HAVE_PG_IDLE(PG_idle,		"idle"		)
>  #define IF_HAVE_VM_SOFTDIRTY(flag,name)
>  #endif
>  
> +#ifdef CONFIG_64BIT
> +#define IF_HAVE_VM_LEVEL_PUD(flag,name)	{flag, name}
> +#define IF_HAVE_VM_LEVEL_PMD(flag,name)	{flag, name}
> +#define IF_HAVE_VM_LEVEL_PTE(flag,name)	{flag, name}
> +#else
> +#define IF_HAVE_VM_LEVEL_PUD(flag,name)
> +#define IF_HAVE_VM_LEVEL_PMD(flag,name)
> +#define IF_HAVE_VM_LEVEL_PTE(flag,name)
> +#endif
> +
>  #define __def_vmaflag_names						\
>  	{VM_READ,			"read"		},		\
>  	{VM_WRITE,			"write"		},		\
> @@ -161,7 +171,10 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
>  	{VM_MIXEDMAP,			"mixedmap"	},		\
>  	{VM_HUGEPAGE,			"hugepage"	},		\
>  	{VM_NOHUGEPAGE,			"nohugepage"	},		\
> -	{VM_MERGEABLE,			"mergeable"	}		\
> +	{VM_MERGEABLE,			"mergeable"	},		\
> +IF_HAVE_VM_LEVEL_PUD(VM_LEVEL_PUD,	"pud-level"	),		\
> +IF_HAVE_VM_LEVEL_PMD(VM_LEVEL_PMD,	"pmd-level"	),		\
> +IF_HAVE_VM_LEVEL_PTE(VM_LEVEL_PTE,	"pte-level"	)		\
>  

Have you tested this on 32bit? It looks like you'll get empty commas there.
Perhaps the defines need to be:

#ifdef CONFIG_64BIT
#define IF_HAVE_VM_LEVEL_PUD(flag,name)	{flag, name},
#define IF_HAVE_VM_LEVEL_PMD(flag,name)	{flag, name},
#define IF_HAVE_VM_LEVEL_PTE(flag,name)	{flag, name}
#else
#define IF_HAVE_VM_LEVEL_PUD(flag,name)
#define IF_HAVE_VM_LEVEL_PMD(flag,name)
#define IF_HAVE_VM_LEVEL_PTE(flag,name)
#endif

And leave out the commas in the list.

-- Steve
