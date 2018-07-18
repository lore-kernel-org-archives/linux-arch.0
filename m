Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:18770 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730885AbeGRQit (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Jul 2018 12:38:49 -0400
Subject: Re: [PATCH v14 12/22] selftests/vm: pkey register should match shadow
 pkey
References: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
 <1531835365-32387-13-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <13e29efb-6a75-d6c8-e9a8-9e7495b88e00@intel.com>
Date: Wed, 18 Jul 2018 09:00:11 -0700
MIME-Version: 1.0
In-Reply-To: <1531835365-32387-13-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com, msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Message-ID: <20180718160011.NyQpShMU40fnaiKUknPKZslZq9QA_WH0oFUmAZJdwBE@z>

On 07/17/2018 06:49 AM, Ram Pai wrote:
> expected_pkey_fault() is comparing the contents of pkey
> register with 0. This may not be true all the time. There
> could be bits set by default by the architecture
> which can never be changed. Hence compare the value against
> shadow pkey register, which is supposed to track the bits
> accurately all throughout

This is getting dangerously close to full sentences that actually
describe the patch.  You forgot a period, but much this is a substantial
improvement over earlier parts of the series.  Thanks for writing this,
seriously.

> cc: Dave Hansen <dave.hansen@intel.com>
> cc: Florian Weimer <fweimer@redhat.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  tools/testing/selftests/vm/protection_keys.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> index 2e448e0..f50cce8 100644
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -913,10 +913,10 @@ void expected_pkey_fault(int pkey)
>  		pkey_assert(last_si_pkey == pkey);
>  
>  	/*
> -	 * The signal handler shold have cleared out PKEY register to let the
> +	 * The signal handler should have cleared out pkey-register to let the
>  	 * test program continue.  We now have to restore it.
>  	 */

... while I appreciate the spelling corrections, and I would totally ack
a patch that fixed them in one fell swoop, could we please segregate the
random spelling corrections from code fixes unless you touch those lines
otherwise?

> -	if (__read_pkey_reg() != 0)
> +	if (__read_pkey_reg() != shadow_pkey_reg)
>  		pkey_assert(0);
>  
>  	__write_pkey_reg(shadow_pkey_reg);

I know this is a one-line change, but I don't fully understand it.

On x86, if we take a pkey fault, we clear PKRU entirely (via the
on-stack XSAVE state that is restored at sigreturn) which allows the
faulting instruction to resume and execute normally.  That's what this
check is looking for: Did the signal handler clear PKRU?

Now, you're saying that powerpc might not clear it.  That makes sense.

While PKRU's state here is obvious, it isn't patently obvious to me what
shadow_pkey_reg's state is.  In fact, looking at it, I don't see the
signal handler manipulating the shadow.  So, how can this patch work?
