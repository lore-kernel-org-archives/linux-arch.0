Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:4570 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751499AbeBZVOh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Feb 2018 16:14:37 -0500
Subject: Re: [PATCH v12 2/3] mm, powerpc, x86: introduce an additional vma bit
 for powerpc pkey
References: <1519257138-23797-1-git-send-email-linuxram@us.ibm.com>
 <1519257138-23797-3-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <d3f6b6a1-8319-449a-804e-bf9d1dedbb5f@intel.com>
Date: Mon, 26 Feb 2018 13:14:34 -0800
MIME-Version: 1.0
In-Reply-To: <1519257138-23797-3-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net, arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com
Message-ID: <20180226211434.7DMFyAgRwUWvUij2aesacywl_g6x9VQuOh0R8d9-MBA@z>

On 02/21/2018 03:52 PM, Ram Pai wrote:
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ad207ad..d534f46 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -231,9 +231,10 @@ extern int overcommit_kbytes_handler(struct ctl_table *, int, void __user *,
>  #ifdef CONFIG_ARCH_HAS_PKEYS
>  # define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
>  # define VM_PKEY_BIT0	VM_HIGH_ARCH_0	/* A protection key is a 4-bit value */
> -# define VM_PKEY_BIT1	VM_HIGH_ARCH_1
> +# define VM_PKEY_BIT1	VM_HIGH_ARCH_1	/* on x86 and 5-bit value on ppc64   */
>  # define VM_PKEY_BIT2	VM_HIGH_ARCH_2
>  # define VM_PKEY_BIT3	VM_HIGH_ARCH_3
> +# define VM_PKEY_BIT4	VM_HIGH_ARCH_4
>  #endif /* CONFIG_ARCH_HAS_PKEYS */

I think I would prefer if VM_PKEY_BIT4 was unusable on x86, or #defined
to 0.  We don't want folks using a bit that can not be programmed into
the hardware.
