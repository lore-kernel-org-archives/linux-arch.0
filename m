From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v12 05/22] selftests/vm: generic function to handle shadow
 key register
Date: Fri, 16 Mar 2018 15:05:19 -0700
Message-ID: <92951c0a-0468-6d3c-efef-2d9da53fd10f@intel.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-6-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519264541-7621-6-git-send-email-linuxram@us.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
List-Id: linux-arch.vger.kernel.org

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
