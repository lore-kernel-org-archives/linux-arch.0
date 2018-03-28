From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v12 07/22] selftests/vm: fixed bugs in
 pkey_disable_clear()
Date: Wed, 28 Mar 2018 13:55:33 -0700
Message-ID: <34fd1ae9-9697-ac6c-d6bc-7c25b4515a25@intel.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-8-git-send-email-linuxram@us.ibm.com>
 <dc5ee0c8-afe3-78aa-001d-7b49b398337b@intel.com>
 <87muys3p2v.fsf@morokweng.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87muys3p2v.fsf@morokweng.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, ebiederm@xmission.com, arnd@arndb.de
List-Id: linux-arch.vger.kernel.org

On 03/28/2018 01:47 PM, Thiago Jung Bauermann wrote:
>>>  	if (flags)
>>> -		assert(rdpkey_reg() > orig_pkey_reg);
>>> +		assert(rdpkey_reg() < orig_pkey_reg);
>>>  }
>>>
>>>  void pkey_write_allow(int pkey)
>> This seems so horribly wrong that I wonder how it worked in the first
>> place.  Any idea?
> The code simply wasn't used. pkey_disable_clear() is called by
> pkey_write_allow() and pkey_access_allow(), but before this patch series
> nothing called either of these functions.
> 

Ahh, that explains it.  Can that get stuck in the changelog, please?
