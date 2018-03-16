Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32464 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbeCPV6Z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Mar 2018 17:58:25 -0400
Subject: Re: [PATCH v12 04/22] selftests/vm: typecast the pkey register
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-5-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <00081300-e891-3381-3acd-e3312e54fb58@intel.com>
Date: Fri, 16 Mar 2018 14:58:16 -0700
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-5-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
Message-ID: <20180316215816.8UipG5EM8YWKLkDNMZq9nXEyztf4Ir1RQCwJSlyFmhY@z>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> -static inline unsigned int _rdpkey_reg(int line)
> +static inline pkey_reg_t _rdpkey_reg(int line)
>  {
> -	unsigned int pkey_reg = __rdpkey_reg();
> +	pkey_reg_t pkey_reg = __rdpkey_reg();
>  
> -	dprintf4("rdpkey_reg(line=%d) pkey_reg: %x shadow: %x\n",
> +	dprintf4("rdpkey_reg(line=%d) pkey_reg: %016lx shadow: %016lx\n",
>  			line, pkey_reg, shadow_pkey_reg);
>  	assert(pkey_reg == shadow_pkey_reg);

Hmm.  So we're using %lx for an int?  Doesn't the compiler complain
about this?
