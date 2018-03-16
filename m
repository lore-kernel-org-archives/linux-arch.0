From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v12 16/22] selftests/vm: fix an assertion in
 test_pkey_alloc_exhaust()
Date: Fri, 16 Mar 2018 15:28:19 -0700
Message-ID: <98204562-7c91-23f0-101b-508954020353@intel.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-17-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519264541-7621-17-git-send-email-linuxram@us.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
List-Id: linux-arch.vger.kernel.org

On 02/21/2018 05:55 PM, Ram Pai wrote:
> +static inline int arch_reserved_keys(void)
> +{
> +#if defined(__i386__) || defined(__x86_64__) /* arch */
> +	return NR_RESERVED_PKEYS;
> +#elif __powerpc64__ /* arch */
> +	if (sysconf(_SC_PAGESIZE) == 4096)
> +		return NR_RESERVED_PKEYS_4K;
> +	else
> +		return NR_RESERVED_PKEYS_64K;
> +#else /* arch */
> +	NOT SUPPORTED
> +#endif /* arch */
> +}

Yeah, this is hideous.

Please either do it in one header:

#ifdef x86..
static inline int arch_reserved_keys(void)
{
}
...
#elif ppc
static inline int arch_reserved_keys(void)
{
}
...
#else
#error
#endif

Or in multiple:

#ifdef x86..
#include <pkey_x86.h>
#elif ppc
#include <pkey_ppc.h>
#else
#error
#endif
