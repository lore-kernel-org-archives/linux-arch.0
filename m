Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:52588 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751753AbeCPWF2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Mar 2018 18:05:28 -0400
Subject: Re: [PATCH v12 05/22] selftests/vm: generic function to handle shadow
 key register
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-6-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <92951c0a-0468-6d3c-efef-2d9da53fd10f@intel.com>
Date: Fri, 16 Mar 2018 15:05:19 -0700
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-6-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
Message-ID: <20180316220519.ZKNmliWPFGBYYXY9yi8nXpCBJEeetKHREP9R3B6RLLs@z>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> +static inline u32 pkey_to_shift(int pkey)
> +{
> +	return pkey * PKEY_BITS_PER_PKEY;
> +}

pkey_bit_position(), perhaps?

> +static inline pkey_reg_t reset_bits(int pkey, pkey_reg_t bits)
> +{
> +	u32 shift = pkey_to_shift(pkey);
> +
> +	return ~(bits << shift);
> +}

I'd prefer clear_pkey_flags() or maybe clear_pkey_bits().  "reset" can
mean "reset to 0" or "reset to 1".

Also, why the u32 here?  Isn't an int more appropriate?

> +static inline pkey_reg_t left_shift_bits(int pkey, pkey_reg_t bits)
> +{
> +	u32 shift = pkey_to_shift(pkey);
> +
> +	return (bits << shift);
> +}
> +
> +static inline pkey_reg_t right_shift_bits(int pkey, pkey_reg_t bits)
> +{
> +	u32 shift = pkey_to_shift(pkey);
> +
> +	return (bits >> shift);
> +}

Some comments on these would be handy.  Basically that this takes a
per-key flags value and puts it at the right position so it can be
shoved in the register.
