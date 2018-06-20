Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:44554 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752932AbeFTPHo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Jun 2018 11:07:44 -0400
Subject: Re: [PATCH v13 16/24] selftests/vm: clear the bits in shadow reg when
 a pkey is freed.
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <1528937115-10132-17-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <0b534ee8-5747-2811-745c-d87b3e720955@intel.com>
Date: Wed, 20 Jun 2018 08:07:31 -0700
MIME-Version: 1.0
In-Reply-To: <1528937115-10132-17-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com, msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Message-ID: <20180620150731.bD3Lpb-OfSascoa4G-VBYiNTpL4nZT8O6C_0Un3cL9k@z>

On 06/13/2018 05:45 PM, Ram Pai wrote:
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -577,7 +577,8 @@ int sys_pkey_free(unsigned long pkey)
>  	int ret = syscall(SYS_pkey_free, pkey);
>  
>  	if (!ret)
> -		shadow_pkey_reg &= clear_pkey_flags(pkey, PKEY_DISABLE_ACCESS);
> +		shadow_pkey_reg &= clear_pkey_flags(pkey,
> +				PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE);
>  	dprintf1("%s(pkey=%ld) syscall ret: %d\n", __func__, pkey, ret);
>  	return ret;
>  }

Why did you introduce this code earlier and then modify it now?

BTW, my original aversion to this code still stands.
