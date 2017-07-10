From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC v5 34/38] procfs: display the protection-key number
 associated with a vma
Date: Mon, 10 Jul 2017 08:37:28 +0530
Message-ID: <1162ac6c-5e34-8a6c-fed2-6683d261352c@linux.vnet.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-35-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1499289735-14220-35-git-send-email-linuxram@us.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
List-Id: linux-arch.vger.kernel.org

On 07/06/2017 02:52 AM, Ram Pai wrote:
> Display the pkey number associated with the vma in smaps of a task.
> The key will be seen as below:
> 
> ProtectionKey: 0
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/kernel/setup_64.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index f35ff9d..ebc82b3 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -37,6 +37,7 @@
>  #include <linux/memblock.h>
>  #include <linux/memory.h>
>  #include <linux/nmi.h>
> +#include <linux/pkeys.h>
>  
>  #include <asm/io.h>
>  #include <asm/kdump.h>
> @@ -745,3 +746,10 @@ static int __init disable_hardlockup_detector(void)
>  }
>  early_initcall(disable_hardlockup_detector);
>  #endif
> +
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS

Why not for X86 protection keys ?

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
