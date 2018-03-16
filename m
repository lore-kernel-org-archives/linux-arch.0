Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:51360 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751372AbeCPW21 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Mar 2018 18:28:27 -0400
Subject: Re: [PATCH v12 16/22] selftests/vm: fix an assertion in
 test_pkey_alloc_exhaust()
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-17-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <98204562-7c91-23f0-101b-508954020353@intel.com>
Date: Fri, 16 Mar 2018 15:28:19 -0700
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-17-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
Message-ID: <20180316222819.qf3qQ_ETB7RRKydh2zm-O3u2DXPYtrpBiez6EQWk1yw@z>

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
