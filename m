From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [RFC v6 13/62] powerpc: track allocation status of all pkeys
Date: Thu, 27 Jul 2017 11:01:44 -0300
Message-ID: <87eft23rnb.fsf@linux.vnet.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com> <1500177424-13695-14-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <1500177424-13695-14-git-send-email-linuxram@us.ibm.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, arnd@arndb.de, corbet@lwn.net, mhocko@kernel.org, dave.hansen@intel.com, mingo@redhat.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, khandual@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org


Hello Ram,

I'm still going through the patches and haven't formed a full picture of
the feature in my mind yet, so my comments today won't be particularly
insightful...

But hopefully the comments that I currently have will be helpful anyway.

Ram Pai <linuxram@us.ibm.com> writes:
> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> index 203d7de..09b268e 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -2,21 +2,87 @@
>  #define _ASM_PPC64_PKEYS_H
>
>  extern bool pkey_inited;
> -#define ARCH_VM_PKEY_FLAGS 0
> +#define arch_max_pkey()  32
> +#define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
> +				VM_PKEY_BIT3 | VM_PKEY_BIT4)
> +/*
> + * Bits are in BE format.
> + * NOTE: key 31, 1, 0 are not used.
> + * key 0 is used by default. It give read/write/execute permission.
> + * key 31 is reserved by the hypervisor.
> + * key 1 is recommended to be not used.
> + * PowerISA(3.0) page 1015, programming note.
> + */
> +#define PKEY_INITIAL_ALLOCAION  0xc0000001

There's a typo in the macro name, should be "ALLOCATION".

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

