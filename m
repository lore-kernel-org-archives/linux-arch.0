Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:37259 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751319AbeCPWI3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Mar 2018 18:08:29 -0400
Subject: Re: [PATCH v12 07/22] selftests/vm: fixed bugs in
 pkey_disable_clear()
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-8-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <dc5ee0c8-afe3-78aa-001d-7b49b398337b@intel.com>
Date: Fri, 16 Mar 2018 15:08:20 -0700
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-8-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
Message-ID: <20180316220820.3E5NMj7n-OCN93b9-it-HgY7u6112bYbIu6waZjriZM@z>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -461,7 +461,7 @@ void pkey_disable_clear(int pkey, int flags)
>  			pkey, pkey, pkey_rights);
>  	pkey_assert(pkey_rights >= 0);
>  
> -	pkey_rights |= flags;
> +	pkey_rights &= ~flags;
>  
>  	ret = pkey_set(pkey, pkey_rights, 0);
>  	/* pkey_reg and flags have the same format */
> @@ -475,7 +475,7 @@ void pkey_disable_clear(int pkey, int flags)
>  	dprintf1("%s(%d) pkey_reg: 0x%016lx\n", __func__,
>  			pkey, rdpkey_reg());
>  	if (flags)
> -		assert(rdpkey_reg() > orig_pkey_reg);
> +		assert(rdpkey_reg() < orig_pkey_reg);
>  }
>  
>  void pkey_write_allow(int pkey)

This seems so horribly wrong that I wonder how it worked in the first
place.  Any idea?
