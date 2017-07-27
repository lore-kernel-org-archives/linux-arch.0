From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [RFC v6 19/62] powerpc: ability to create execute-disabled pkeys
Date: Thu, 27 Jul 2017 12:34:57 -0300
Message-ID: <87a83p51we.fsf@linux.vnet.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com> <1500177424-13695-20-git-send-email-linuxram@us.ibm.com> <87bmo63p7c.fsf@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <owner-linux-mm@kvack.org>
In-reply-to: <87bmo63p7c.fsf@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, arnd@arndb.de, corbet@lwn.net, mhocko@kernel.org, dave.hansen@intel.com, mingo@redhat.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, khandual@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org


Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> index e31f5ee8e81f..67e6a3a343ae 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -4,17 +4,6 @@
>  #include <asm/firmware.h>
>  
>  extern bool pkey_inited;
> -/* override any generic PKEY Permission defines */
> -#undef  PKEY_DISABLE_ACCESS
> -#define PKEY_DISABLE_ACCESS    0x1
> -#undef  PKEY_DISABLE_WRITE
> -#define PKEY_DISABLE_WRITE     0x2
> -#undef  PKEY_DISABLE_EXECUTE
> -#define PKEY_DISABLE_EXECUTE   0x4
> -#undef  PKEY_ACCESS_MASK
> -#define PKEY_ACCESS_MASK       (PKEY_DISABLE_ACCESS |\
> -				PKEY_DISABLE_WRITE  |\
> -				PKEY_DISABLE_EXECUTE)
>  
>  #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
>  				VM_PKEY_BIT3 | VM_PKEY_BIT4)
> diff --git a/arch/powerpc/include/uapi/asm/mman.h b/arch/powerpc/include/uapi/asm/mman.h
> index ab45cc2f3101..dee43feb7c53 100644
> --- a/arch/powerpc/include/uapi/asm/mman.h
> +++ b/arch/powerpc/include/uapi/asm/mman.h
> @@ -45,4 +45,6 @@
>  #define MAP_HUGE_1GB	(30 << MAP_HUGE_SHIFT)	/* 1GB   HugeTLB Page */
>  #define MAP_HUGE_16GB	(34 << MAP_HUGE_SHIFT)	/* 16GB  HugeTLB Page */
>  
> +#define PKEY_DISABLE_EXECUTE   0x4
> +
>  #endif /* _UAPI_ASM_POWERPC_MMAN_H */
> diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> index 72eb9a1bde79..777f8f8dff47 100644
> --- a/arch/powerpc/mm/pkeys.c
> +++ b/arch/powerpc/mm/pkeys.c
> @@ -12,7 +12,7 @@
>   * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>   * more details.
>   */
> -#include <uapi/asm-generic/mman-common.h>
> +#include <asm/mman.h>
>  #include <linux/pkeys.h>                /* PKEY_*                       */
>  
>  bool pkey_inited;
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index 8c27db0c5c08..93e3841d9ada 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -74,7 +74,15 @@
>  
>  #define PKEY_DISABLE_ACCESS	0x1
>  #define PKEY_DISABLE_WRITE	0x2
> +
> +/* The arch-specific code may define PKEY_DISABLE_EXECUTE */
> +#ifdef PKEY_DISABLE_EXECUTE
> +#define PKEY_ACCESS_MASK       (PKEY_DISABLE_ACCESS |	\
> +				PKEY_DISABLE_WRITE  |	\
> +				PKEY_DISABLE_EXECUTE)
> +#else
>  #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
>  				 PKEY_DISABLE_WRITE)
> +#endif
>  
>  #endif /* __ASM_GENERIC_MMAN_COMMON_H */

Actually, I just noticed that arch/powerpc/include/uapi/asm/mman.h
includes <asm-generic/mman-common.h>, so for the #ifdef above to work
the former has to #define PKEY_DISABLE_EXECUTE before including the
latter.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
