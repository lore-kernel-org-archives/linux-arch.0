Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32891 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752271AbdF0KzD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2017 06:55:03 -0400
Message-ID: <1498560849.7935.9.camel@gmail.com>
Subject: Re: [RFC v4 01/17] mm: introduce an additional vma bit for powerpc
 pkey
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 27 Jun 2017 20:54:09 +1000
In-Reply-To: <1498558319-32466-2-git-send-email-linuxram@us.ibm.com>
References: <1498558319-32466-1-git-send-email-linuxram@us.ibm.com>
         <1498558319-32466-2-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
Message-ID: <20170627105409.2hNbwiqJ-brrgivaY4grsxnE2k3Kh9kEIjpYVsn4VW0@z>

On Tue, 2017-06-27 at 03:11 -0700, Ram Pai wrote:
> Currently there are only 4bits in the vma flags to support 16 keys
> on x86.  powerpc supports 32 keys, which needs 5bits. This patch
> introduces an addition bit in the vma flags.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  fs/proc/task_mmu.c |  6 +++++-
>  include/linux/mm.h | 18 +++++++++++++-----
>  2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index f0c8b33..2ddc298 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -666,12 +666,16 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>  		[ilog2(VM_MERGEABLE)]	= "mg",
>  		[ilog2(VM_UFFD_MISSING)]= "um",
>  		[ilog2(VM_UFFD_WP)]	= "uw",
> -#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
> +#ifdef CONFIG_ARCH_HAS_PKEYS
>  		/* These come out via ProtectionKey: */
>  		[ilog2(VM_PKEY_BIT0)]	= "",
>  		[ilog2(VM_PKEY_BIT1)]	= "",
>  		[ilog2(VM_PKEY_BIT2)]	= "",
>  		[ilog2(VM_PKEY_BIT3)]	= "",
> +#endif /* CONFIG_ARCH_HAS_PKEYS */
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +		/* Additional bit in ProtectionKey: */
> +		[ilog2(VM_PKEY_BIT4)]	= "",
>  #endif

Not sure why these are linked with smap bits, but I guess the keys live
in the Supervisor Mode Access Prevention area?

Balbir Singh.
