Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:61617 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731443AbeGRRfi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Jul 2018 13:35:38 -0400
Subject: Re: [PATCH v14 20/22] selftests/vm: testcases must restore
 pkey-permissions
References: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
 <1531835365-32387-21-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <ea9c3220-c4dd-124a-2031-eaca6859b389@intel.com>
Date: Wed, 18 Jul 2018 09:56:49 -0700
MIME-Version: 1.0
In-Reply-To: <1531835365-32387-21-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com, msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Message-ID: <20180718165649.O4eNJYU2d8xf-02DNNMqJl0exQvLlRQkybK3Jj17IV0@z>

On 07/17/2018 06:49 AM, Ram Pai wrote:
> Generally the signal handler restores the state of the pkey register
> before returning. However there are times when the read/write operation
> can legitamely fail without invoking the signal handler.  Eg: A
> sys_read() operaton to a write-protected page should be disallowed.  In
> such a case the state of the pkey register is not restored to its
> original state.  Test cases may not remember to restoring the key
> register state. During cleanup generically restore the key permissions.

This would, indeed be a good thing to do for a well-behaved application.

But, for selftests, why does it matter what state we leave the key in?
Doesn't the test itself need to establish permissions?  Don't we *do*
that at pkey_alloc() anyway?

What problem does this solve?

> diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> index 8a6afdd..ea3cf04 100644
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -1476,8 +1476,13 @@ void run_tests_once(void)
>  		pkey_tests[test_nr](ptr, pkey);
>  		dprintf1("freeing test memory: %p\n", ptr);
>  		free_pkey_malloc(ptr);
> +
> +		/* restore the permission on the key after use */
> +		pkey_access_allow(pkey);
> +		pkey_write_allow(pkey);
>  		sys_pkey_free(pkey);
>  
> +
>  		dprintf1("pkey_faults: %d\n", pkey_faults);
>  		dprintf1("orig_pkey_faults: %d\n", orig_pkey_faults);
