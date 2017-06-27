Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32768 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbdF0LdH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2017 07:33:07 -0400
Message-ID: <1498563132.7935.15.camel@gmail.com>
Subject: Re: [RFC v4 03/17] x86: key creation with PKEY_DISABLE_EXECUTE
 disallowed
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 27 Jun 2017 21:32:12 +1000
In-Reply-To: <1498558319-32466-4-git-send-email-linuxram@us.ibm.com>
References: <1498558319-32466-1-git-send-email-linuxram@us.ibm.com>
         <1498558319-32466-4-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
Message-ID: <20170627113212.zZH35SYGTsyIFUeAt2g-MUpsafCFaFcETTyMfCsX0AE@z>

On Tue, 2017-06-27 at 03:11 -0700, Ram Pai wrote:
> x86 does not support disabling execute permissions on a pkey.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/x86/kernel/fpu/xstate.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index c24ac1e..d582631 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -900,6 +900,9 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
>  	if (!boot_cpu_has(X86_FEATURE_OSPKE))
>  		return -EINVAL;
>  
> +	if (init_val & PKEY_DISABLE_EXECUTE)
> +		return -EINVAL;
> +
>  	/* Set the bits we need in PKRU:  */
>  	if (init_val & PKEY_DISABLE_ACCESS)
>  		new_pkru_bits |= PKRU_AD_BIT;

I am not an x86 expert. IIUC, execute disable is done via allocating an
execute_only_pkey and checking vma_key via AD + vma_flags against VM_EXEC.

Your patch looks good to me

Acked-by: Balbir Singh <bsingharora@gmail.com>

Balbir Singh.
