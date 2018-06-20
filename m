Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6320 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753202AbeFTOx7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Jun 2018 10:53:59 -0400
Subject: Re: [PATCH v13 13/24] selftests/vm: pkey register should match shadow
 pkey
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <1528937115-10132-14-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <6246f823-77d9-6727-097e-73f103078a44@intel.com>
Date: Wed, 20 Jun 2018 07:53:57 -0700
MIME-Version: 1.0
In-Reply-To: <1528937115-10132-14-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com, msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Message-ID: <20180620145357.fZpkVdBORlwUaCs4DWECAUAmw0RL8N6kp5fCpirmBms@z>

On 06/13/2018 05:45 PM, Ram Pai wrote:
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -916,10 +916,10 @@ void expected_pkey_fault(int pkey)
>  		pkey_assert(last_si_pkey == pkey);
>  
>  	/*
> -	 * The signal handler shold have cleared out PKEY register to let the
> +	 * The signal handler should have cleared out pkey-register to let the
>  	 * test program continue.  We now have to restore it.
>  	 */
> -	if (__read_pkey_reg() != 0)
> +	if (__read_pkey_reg() != shadow_pkey_reg)
>  		pkey_assert(0);
>  
>  	__write_pkey_reg(shadow_pkey_reg);

I think this is wrong on x86.

When we leave the signal handler, we zero out PKRU so that the faulting
instruction can continue, that's why we have the check against zero.
I'm actually kinda surprised this works.

Logically, this patch does:

	if (hardware != shadow)
		error();
	hardware = shadow;

That does not look right to me.  What we want is:

	if (hardware != signal_return_pkey_reg)
		error();
	hardware = shadow;
