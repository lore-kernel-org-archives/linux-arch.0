From: Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH 15/22] arm64: mte: Add PROT_MTE support to mmap() and mprotect()
Date: Tue, 21 Jan 2020 14:06:14 -0800
Message-ID: <CAMn1gO6dNi-97cG-a8-6PcauLy9xpRvG6JYdU0zyn9a_6tnyvA@mail.gmail.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com> <20191211184027.20130-16-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51030 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgAUWG3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2020 17:06:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so4727993wmb.0
        for <linux-arch@vger.kernel.org>; Tue, 21 Jan 2020 14:06:27 -0800 (PST)
In-Reply-To: <20191211184027.20130-16-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arch@vger.kernel.org, Richard Earnshaw <Richard.Earnshaw@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Marc Zyngier <maz@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org, Andrey Konovalov <andreyknvl@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>

On Wed, Dec 11, 2019 at 10:44 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 9442631fd4af..34bc9e0b4896 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -677,6 +677,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>                 [ilog2(VM_MERGEABLE)]   = "mg",
>                 [ilog2(VM_UFFD_MISSING)]= "um",
>                 [ilog2(VM_UFFD_WP)]     = "uw",
> +#ifdef CONFIG_ARM64_MTE
> +               [ilog2(VM_MTE)]         = "mt",

We should probably add an entry for VM_MTE_ALLOWED here as well.

Peter
