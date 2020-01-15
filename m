Return-Path: <owner-linux-mm@kvack.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v15 14/23] selftests/vm/pkeys: Fix assertion in
 test_pkey_alloc_exhaust()
In-Reply-To: 
 <d82e1652135569cfc38b289f88e39e94d55308ff.1576645161.git.sandipan@linux.ibm.com>
References: <cover.1576645161.git.sandipan@linux.ibm.com>
 <d82e1652135569cfc38b289f88e39e94d55308ff.1576645161.git.sandipan@linux.ibm.com>
Date: Wed, 15 Jan 2020 17:30:01 +1000
Message-ID: <87a76p9nye.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linux-mm@kvack.org
To: Sandipan Das <sandipan@linux.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, linux-mm@kvack.org, aneesh.kumar@linux.ibm.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, dave.hansen@intel.com, mingo@redhat.com, msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org, bauerman@linux.ibm.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200115073001.g09Myek-_lJjf0krUy9sHnEzsLYFNx2v9F8S1OO4FDE@z>

Sandipan Das <sandipan@linux.ibm.com> writes:
> From: Ram Pai <linuxram@us.ibm.com>
>
> Some pkeys which are valid on the hardware are reserved
> and not available for application use. These keys cannot
> be allocated.
>
> test_pkey_alloc_exhaust() tries to account for these and
> has an assertion which validates if all available pkeys
> have been exahaustively allocated. However, the expression
> that is currently used is only valid for x86. On powerpc,
> a pkey is additionally reserved as compared to x86. Hence,
> the assertion is made to use an arch-specific helper to
> get the correct count of reserved pkeys.

The number of reserved keys is at the whim of the
firmware/hypervisor/kernel.

I'm not sure it makes sense to test this exhaustion behaviour, it's
likely going to break in future.

If you do want to test it you should at least move patch 21 prior to
this one.

cheers

> cc: Dave Hansen <dave.hansen@intel.com>
> cc: Florian Weimer <fweimer@redhat.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
> ---
>  tools/testing/selftests/vm/protection_keys.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> index 1920bca84def..8d90cfe2c9bd 100644
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -1152,6 +1152,7 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
>  	dprintf3("%s()::%d\n", __func__, __LINE__);
>  
>  	/*
> +	 * On x86:
>  	 * There are 16 pkeys supported in hardware.  Three are
>  	 * allocated by the time we get here:
>  	 *   1. The default key (0)
> @@ -1159,8 +1160,16 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
>  	 *   3. One allocated by the test code and passed in via
>  	 *      'pkey' to this function.
>  	 * Ensure that we can allocate at least another 13 (16-3).
> +	 *
> +	 * On powerpc:
> +	 * There are either 5 or 32 pkeys supported in hardware
> +	 * depending on the page size (4K or 64K). Four are
> +	 * allocated by the time we get here. This includes
> +	 * pkey-0, pkey-1, exec-only pkey and the one allocated
> +	 * by the test code.
> +	 * Ensure that we can allocate the remaining.
>  	 */
> -	pkey_assert(i >= NR_PKEYS-3);
> +	pkey_assert(i >= (NR_PKEYS - get_arch_reserved_keys() - 1));
>  
>  	for (i = 0; i < nr_allocated_pkeys; i++) {
>  		err = sys_pkey_free(allocated_pkeys[i]);
> -- 
> 2.17.1
