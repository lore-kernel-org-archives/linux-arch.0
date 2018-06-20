Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:21035 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752856AbeFTOtd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Jun 2018 10:49:33 -0400
Subject: Re: [PATCH v13 10/24] selftests/vm: clear the bits in shadow reg when
 a pkey is freed.
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <1528937115-10132-11-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <41034628-c643-7a4b-006d-9606201ded6e@intel.com>
Date: Wed, 20 Jun 2018 07:49:31 -0700
MIME-Version: 1.0
In-Reply-To: <1528937115-10132-11-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com, msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Message-ID: <20180620144931.WN1YDv6HQdetF9iA_2HKi61aIIaCV2KxaaM6l8phMZc@z>

On 06/13/2018 05:45 PM, Ram Pai wrote:
> When a key is freed, the  key  is  no  more  effective.
> Clear the bits corresponding to the pkey in the shadow
> register. Otherwise  it  will carry some spurious bits
> which can trigger false-positive asserts.
...--- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -556,6 +556,9 @@ int alloc_pkey(void)
>  int sys_pkey_free(unsigned long pkey)
>  {
>  	int ret = syscall(SYS_pkey_free, pkey);
> +
> +	if (!ret)
> +		shadow_pkey_reg &= clear_pkey_flags(pkey, PKEY_DISABLE_ACCESS);
>  	dprintf1("%s(pkey=%ld) syscall ret: %d\n", __func__, pkey, ret);
>  	return ret;
>  }

This would be great code for an actual application.  But, I'm not
immediately convinced we want sane, kind behavior in our selftest.  x86
doesn't clear the hardware register at pkey_free, so wouldn't this cause
the shadow and the hardware register to diverge?
