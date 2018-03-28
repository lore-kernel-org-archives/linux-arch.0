From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v12 07/22] selftests/vm: fixed bugs in pkey_disable_clear()
Date: Wed, 28 Mar 2018 17:47:04 -0300
Message-ID: <87muys3p2v.fsf@morokweng.localdomain>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com> <1519264541-7621-8-git-send-email-linuxram@us.ibm.com> <dc5ee0c8-afe3-78aa-001d-7b49b398337b@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <dc5ee0c8-afe3-78aa-001d-7b49b398337b@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, ebiederm@xmission.com, arnd@arndb.de
List-Id: linux-arch.vger.kernel.org


Dave Hansen <dave.hansen@intel.com> writes:

> On 02/21/2018 05:55 PM, Ram Pai wrote:
>> --- a/tools/testing/selftests/vm/protection_keys.c
>> +++ b/tools/testing/selftests/vm/protection_keys.c
>> @@ -461,7 +461,7 @@ void pkey_disable_clear(int pkey, int flags)
>>  			pkey, pkey, pkey_rights);
>>  	pkey_assert(pkey_rights >= 0);
>>
>> -	pkey_rights |= flags;
>> +	pkey_rights &= ~flags;
>>
>>  	ret = pkey_set(pkey, pkey_rights, 0);
>>  	/* pkey_reg and flags have the same format */
>> @@ -475,7 +475,7 @@ void pkey_disable_clear(int pkey, int flags)
>>  	dprintf1("%s(%d) pkey_reg: 0x%016lx\n", __func__,
>>  			pkey, rdpkey_reg());
>>  	if (flags)
>> -		assert(rdpkey_reg() > orig_pkey_reg);
>> +		assert(rdpkey_reg() < orig_pkey_reg);
>>  }
>>
>>  void pkey_write_allow(int pkey)
>
> This seems so horribly wrong that I wonder how it worked in the first
> place.  Any idea?

The code simply wasn't used. pkey_disable_clear() is called by
pkey_write_allow() and pkey_access_allow(), but before this patch series
nothing called either of these functions.


--
Thiago Jung Bauermann
IBM Linux Technology Center
