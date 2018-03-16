From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v12 14/22] selftests/vm: clear the bits in shadow reg when
 a pkey is freed.
Date: Fri, 16 Mar 2018 15:24:28 -0700
Message-ID: <5622aacf-adc6-e547-8f36-9a43f830c29b@intel.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-15-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519264541-7621-15-git-send-email-linuxram@us.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
List-Id: linux-arch.vger.kernel.org

On 02/21/2018 05:55 PM, Ram Pai wrote:
> diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> index c4c73e6..e82bd88 100644
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -586,7 +586,8 @@ int sys_pkey_free(unsigned long pkey)
>  	int ret = syscall(SYS_pkey_free, pkey);
>  
>  	if (!ret)
> -		shadow_pkey_reg &= reset_bits(pkey, PKEY_DISABLE_ACCESS);
> +		shadow_pkey_reg &= reset_bits(pkey,
> +				PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE);
>  	dprintf1("%s(pkey=%ld) syscall ret: %d\n", __func__, pkey, ret);
>  	return ret;
>  }

What about your EXEC bit?
