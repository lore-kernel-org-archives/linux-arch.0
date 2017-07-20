From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC v6 27/62] powerpc: helper to validate key-access permissions of a pte
Date: Thu, 20 Jul 2017 12:12:47 +0530
Message-ID: <87mv7zpq1k.fsf@skywalker.in.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com> <1500177424-13695-28-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1500177424-13695-28-git-send-email-linuxram@us.ibm.com>
Sender: owner-linux-mm@kvack.org
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com, mhocko@kernel.org
List-Id: linux-arch.vger.kernel.org

Ram Pai <linuxram@us.ibm.com> writes:

> helper function that checks if the read/write/execute is allowed
> on the pte.
>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h |    4 +++
>  arch/powerpc/include/asm/pkeys.h             |   12 +++++++++
>  arch/powerpc/mm/pkeys.c                      |   33 ++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 30d7f55..0056e58 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -472,6 +472,10 @@ static inline void write_uamor(u64 value)
>  	mtspr(SPRN_UAMOR, value);
>  }
>
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +extern bool arch_pte_access_permitted(u64 pte, bool write, bool execute);
> +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> +
>  #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>  				       unsigned long addr, pte_t *ptep)
> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> index bbb5d85..7a9aade 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -53,6 +53,18 @@ static inline u64 pte_to_hpte_pkey_bits(u64 pteflags)
>  		((pteflags & H_PAGE_PKEY_BIT4) ? HPTE_R_KEY_BIT4 : 0x0UL));
>  }
>
> +static inline u16 pte_to_pkey_bits(u64 pteflags)
> +{
> +	if (!pkey_inited)
> +		return 0x0UL;

Do we really need that above check ? We should always find it
peky_inited to be set. 

> +
> +	return (((pteflags & H_PAGE_PKEY_BIT0) ? 0x10 : 0x0UL) |
> +		((pteflags & H_PAGE_PKEY_BIT1) ? 0x8 : 0x0UL) |
> +		((pteflags & H_PAGE_PKEY_BIT2) ? 0x4 : 0x0UL) |
> +		((pteflags & H_PAGE_PKEY_BIT3) ? 0x2 : 0x0UL) |
> +		((pteflags & H_PAGE_PKEY_BIT4) ? 0x1 : 0x0UL));
> +}
> +


-aneesh

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
