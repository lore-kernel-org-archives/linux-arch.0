From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC v5 12/38] mm: ability to disable execute permission on a key
 at creation
Date: Tue, 11 Jul 2017 14:57:30 -0700
Message-ID: <3bdd9083-ef2a-d1da-802c-c6822cf818b3@intel.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-13-git-send-email-linuxram@us.ibm.com>
 <3bd2ffd4-33ad-ce23-3db1-d1292e69ca9b@intel.com>
 <1499808577.2865.30.camel@kernel.crashing.org>
 <20170711215105.GA5542@ram.oc3035372033.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20170711215105.GA5542@ram.oc3035372033.ibm.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Ram Pai <linuxram@us.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, arnd@arndb.de, corbet@lwn.net, mingo@redhat.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, khandual@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

On 07/11/2017 02:51 PM, Ram Pai wrote:
> On Wed, Jul 12, 2017 at 07:29:37AM +1000, Benjamin Herrenschmidt wrote:
>> On Tue, 2017-07-11 at 11:11 -0700, Dave Hansen wrote:
>>> On 07/05/2017 02:21 PM, Ram Pai wrote:
>>>> Currently sys_pkey_create() provides the ability to disable read
>>>> and write permission on the key, at  creation. powerpc  has  the
>>>> hardware support to disable execute on a pkey as well.This patch
>>>> enhances the interface to let disable execute  at  key  creation
>>>> time. x86 does  not  allow  this.  Hence the next patch will add
>>>> ability  in  x86  to  return  error  if  PKEY_DISABLE_EXECUTE is
>>>> specified.
>>
>> That leads to the question... How do you tell userspace.
>>
>> (apologies if I missed that in an existing patch in the series)
>>
>> How do we inform userspace of the key capabilities ? There are at least
>> two things userspace may want to know already:
>>
>>  - What protection bits are supported for a key
> 
> the userspace is the one which allocates the keys and enables/disables the
> protection bits on the key. the kernel is just a facilitator. Now if the
> use space wants to know the current permissions on a given key, it can
> just read the AMR/PKRU register on powerpc/intel respectively.

Let's say I want to execute-disable a region.  Can I use protection
keys?  Do I do

	pkey_mprotect(... PKEY_DISABLE_EXECUTE);

and assume that the -EINVAL is because PKEY_DISABLE_EXECUTE is
unsupported, or do I do:

#ifdef __ppc__
	pkey = pkey_aloc();
	pkey_mprotect(... PKEY_DISABLE_EXECUTE);
#else
	mprotect();
#endif

>>  - How many keys exist
> 
> There is no standard way of finding this other than trying to allocate
> as many till you fail.  A procfs or sysfs file can be added to expose
> this information.

It's also dynamic.  On x86, you lose a key if you've used the
execute-only support.  We also reserve the right to steal more in the
future if we want.

>>  - Which keys are available for use by userspace. On PowerPC, the
>> kernel can reserve some keys for itself, so can the hypervisor. In
>> fact, they do.
> 
> this information can be exposed through /proc or /sysfs
> 
> I am sure there will be more demands and requirements as applications
> start leveraging these feature.

For 5 bits, I think just having someone run pkey_alloc() in a loop is
fine.  I don't think we really need to enumerate it in some other way.
