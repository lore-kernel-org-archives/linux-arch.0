From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 15/25] mm: Allow arm64 mmap(PROT_MTE) on RAM-based
 files
Date: Wed, 24 Jun 2020 11:42:22 -0700
Message-ID: <20200624114222.64b0a50cb0497c5bc524b7d5@linux-foundation.org>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
        <20200624175244.25837-16-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405581AbgFXSmX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 14:42:23 -0400
In-Reply-To: <20200624175244.25837-16-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>

On Wed, 24 Jun 2020 18:52:34 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> Since arm64 memory (allocation) tags can only be stored in RAM, mapping
> files with PROT_MTE is not allowed by default. RAM-based files like
> those in a tmpfs mount or memfd_create() can support memory tagging, so
> update the vm_flags accordingly in shmem_mmap().
> 
> ...
>
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2206,6 +2206,9 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
>  			vma->vm_flags &= ~(VM_MAYWRITE);
>  	}
>  
> +	/* arm64 - allow memory tagging on RAM-based files */
> +	vma->vm_flags |= VM_MTE_ALLOWED;
> +
>  	file_accessed(file);
>  	vma->vm_ops = &shmem_vm_ops;
>  	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&

Acked-by: Andrew Morton <akpm@linux-foundation.org>
