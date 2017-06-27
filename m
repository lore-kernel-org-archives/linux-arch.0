From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC v4 09/17] powerpc: call the hash functions with the correct
 pkey value
Date: Tue, 27 Jun 2017 20:54:07 +0530
Message-ID: <5e4fa932-4313-5376-2147-a6431bbec16b@linux.vnet.ibm.com>
References: <1498558319-32466-1-git-send-email-linuxram@us.ibm.com>
 <1498558319-32466-10-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1498558319-32466-10-git-send-email-linuxram@us.ibm.com>
Content-Language: en-US
Sender: owner-linux-mm@kvack.org
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
List-Id: linux-arch.vger.kernel.org



On Tuesday 27 June 2017 03:41 PM, Ram Pai wrote:
> Pass the correct protection key value to the hash functions on
> page fault.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>   arch/powerpc/include/asm/pkeys.h | 11 +++++++++++
>   arch/powerpc/mm/hash_utils_64.c  |  4 ++++
>   arch/powerpc/mm/mem.c            |  6 ++++++
>   3 files changed, 21 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> index ef1c601..1370b3f 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -74,6 +74,17 @@ static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
>   }
> 
>   /*
> + * return the protection key of the vma corresponding to the
> + * given effective address @ea.
> + */
> +static inline int mm_pkey(struct mm_struct *mm, unsigned long ea)
> +{
> +	struct vm_area_struct *vma = find_vma(mm, ea);
> +	int pkey = vma ? vma_pkey(vma) : 0;
> +	return pkey;
> +}
> +
> +/*
>

That is not going to work in hash fault path right ? We can't do a 
find_vma there without holding the mmap_sem

-aneesh

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
