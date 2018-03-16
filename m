From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v12 09/22] selftests/vm: fix alloc_random_pkey() to make
 it really random
Date: Fri, 16 Mar 2018 15:13:06 -0700
Message-ID: <9e410d84-3cd3-edf5-4699-26fcc2bbb393@intel.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-10-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519264541-7621-10-git-send-email-linuxram@us.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
List-Id: linux-arch.vger.kernel.org

On 02/21/2018 05:55 PM, Ram Pai wrote:
> alloc_random_pkey() was allocating the same pkey every time.
> Not all pkeys were geting tested. fixed it.
...
> @@ -602,13 +603,15 @@ int alloc_random_pkey(void)
>  	int alloced_pkeys[NR_PKEYS];
>  	int nr_alloced = 0;
>  	int random_index;
> +
>  	memset(alloced_pkeys, 0, sizeof(alloced_pkeys));
> +	srand((unsigned int)time(NULL));
>  
>  	/* allocate every possible key and make a note of which ones we got */
>  	max_nr_pkey_allocs = NR_PKEYS;
> -	max_nr_pkey_allocs = 1;
>  	for (i = 0; i < max_nr_pkey_allocs; i++) {
>  		int new_pkey = alloc_pkey();

The srand() is probably useful, but won't this always just do a single
alloc_pkey() now?  That seems like it will mean we always use the first
one the kernel gives us, which isn't random.

> -	dprintf1("%s()::%d, ret: %d pkey_reg: 0x%x shadow: 0x%x\n", __func__,
> -			__LINE__, ret, __rdpkey_reg(), shadow_pkey_reg);
> +	dprintf1("%s()::%d, ret: %d pkey_reg: 0x%x shadow: 0x%016lx\n",
> +		__func__, __LINE__, ret, __rdpkey_reg(), shadow_pkey_reg);
>  	return ret;
>  }

This belonged in the pkey_reg_t patch, I think.
