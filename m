Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:28363 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731090AbeGRQNG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Jul 2018 12:13:06 -0400
Subject: Re: [PATCH v14 07/22] selftests/vm: generic function to handle shadow
 key register
References: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
 <1531835365-32387-8-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <ed8baf0c-7ccf-aa99-a88b-9b7697af89f4@intel.com>
Date: Wed, 18 Jul 2018 08:34:37 -0700
MIME-Version: 1.0
In-Reply-To: <1531835365-32387-8-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com, msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Message-ID: <20180718153437.FmhWC0ut5T-N3FCdpBOfc3sSF5xZ4_-7nJkbhIsPIN8@z>

On 07/17/2018 06:49 AM, Ram Pai wrote:
> -	shifted_pkey_reg = (pkey_reg >> (pkey * PKEY_BITS_PER_PKEY));
> +	shifted_pkey_reg = right_shift_bits(pkey, pkey_reg);
>  	dprintf2("%s() shifted_pkey_reg: "PKEY_REG_FMT"\n", __func__,
>  			shifted_pkey_reg);
>  	masked_pkey_reg = shifted_pkey_reg & mask;

I'm not a fan of how this looks.  This is almost certainly going to get
the argument order mixed up at some point.

Why do we need this?  The description doesn't say.
