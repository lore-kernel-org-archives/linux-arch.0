Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:26225 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751233AbeCPWGx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Mar 2018 18:06:53 -0400
Subject: Re: [PATCH v12 06/22] selftests/vm: fix the wrong assert in
 pkey_disable_set()
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-7-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <efe141d5-b609-c21e-8860-c0184e167770@intel.com>
Date: Fri, 16 Mar 2018 15:06:44 -0700
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-7-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
Message-ID: <20180316220644.xeF4dcvSQKAH-YBG42ReWPPqGysX2lpsyovtq-HoqEs@z>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> If the flag is 0, no bits will be set. Hence we cant expect
> the resulting bitmap to have a higher value than what it
> was earlier.
> 
> cc: Dave Hansen <dave.hansen@intel.com>
> cc: Florian Weimer <fweimer@redhat.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  tools/testing/selftests/vm/protection_keys.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> index 83216c5..0109388 100644
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -443,7 +443,7 @@ void pkey_disable_set(int pkey, int flags)
>  	dprintf1("%s(%d) pkey_reg: 0x%lx\n",
>  		__func__, pkey, rdpkey_reg());
>  	if (flags)
> -		pkey_assert(rdpkey_reg() > orig_pkey_reg);
> +		pkey_assert(rdpkey_reg() >= orig_pkey_reg);
>  	dprintf1("END<---%s(%d, 0x%x)\n", __func__,
>  		pkey, flags);
>  }

I'm not sure about this one.  Did this cause a problem for you?

Why would you call this and ask no bits to be set?
