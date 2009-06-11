From: Yinghai Lu <yhlu.kernel@gmail.com>
Subject: Re: RFC: x86: cap iomem_resource to addressable physical memory
Date: Thu, 11 Jun 2009 13:43:10 -0700
Message-ID: <86802c440906111343g513a2ceau1e2bfdf14c295b2d@mail.gmail.com>
References: <4A2F0D45.2040602@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gx0-f214.google.com ([209.85.217.214]:52775 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbZFKUnI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Jun 2009 16:43:08 -0400
In-Reply-To: <4A2F0D45.2040602@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Jesse Barnes <jbarnes@virtuousgeek.org>, Martin Mares <mj@ucw.cz>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org

On Tue, Jun 9, 2009 at 6:32 PM, H. Peter Anvin<hpa@linux.intel.com> wrote:
> x86 cannot generate full 64-bit addresses; this patch clamps iomem
> addresses to the accessible range.
>
> I wanted to post it for review before committing it, however; comments
> would be appreciated, especially of the kind "this is done too early/too
> late/in the wrong place/incorrectly".
| --- a/arch/x86/kernel/cpu/common.c
| +++ b/arch/x86/kernel/cpu/common.c
| @@ -839,6 +839,9 @@ static void __cpuinit identify_cpu(struct cpuinfo_x86 *c)
| #if defined(CONFIG_NUMA) && defined(CONFIG_X86_64)
| 	numa_add_cpu(smp_processor_id());
| #endif
|+
|+	/* Cap the iomem address space to what is addressable on all CPUs */
|+	iomem_resource.end &= (1ULL << c->x86_phys_bits) - 1;
| }
|


do we need do that on every cpu?

looks like we could do that in identify_boot_cpu.

YH
