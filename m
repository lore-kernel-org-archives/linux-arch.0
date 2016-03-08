Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:44415 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbcCHU1w (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Mar 2016 15:27:52 -0500
Date: Tue, 08 Mar 2016 15:27:46 -0500 (EST)
Message-ID: <20160308.152746.1746115669072714849.davem@davemloft.net>
Subject: Re: [PATCH v2] sparc64: Add support for Application Data Integrity
 (ADI)
From: David Miller <davem@davemloft.net>
In-Reply-To: <56DF330B.2010600@oracle.com>
References: <56DDED63.8010302@oracle.com>
	<20160308.145748.1648298790157991002.davem@davemloft.net>
	<56DF330B.2010600@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: khalid.aziz@oracle.com
Cc: dave.hansen@linux.intel.com, luto@amacapital.net, rob.gardner@oracle.com, corbet@lwn.net, akpm@linux-foundation.org, dingel@linux.vnet.ibm.com, bob.picco@oracle.com, kirill.shutemov@linux.intel.com, aneesh.kumar@linux.vnet.ibm.com, aarcange@redhat.com, arnd@arndb.de, sparclinux@vger.kernel.org, mhocko@suse.cz, chris.hyser@oracle.com, richard@nod.at, vbabka@suse.cz, koct9i@gmail.com, oleg@redhat.com, gthelen@google.com, jack@suse.cz, xiexiuqi@huawei.com, Vineet.Gupta1@synopsys.com, luto@kernel.org, ebiederm@xmission.com, bsegall@google.com, geert@linux-m68k.org, dave@stgolabs.net, adobriyan@gmail.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20160308202746.fU5lVyKnEJv0kR-3HKBXFb--pnW1pfPsj3pE4vyb70g@z>

From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Tue, 8 Mar 2016 13:16:11 -0700

> On 03/08/2016 12:57 PM, David Miller wrote:
>> From: Khalid Aziz <khalid.aziz@oracle.com>
>> Date: Mon, 7 Mar 2016 14:06:43 -0700
>>
>>> Good questions. Isn't set of valid VAs already constrained by VA_BITS
>>> (set to 44 in arch/sparc/include/asm/processor_64.h)? As I see it we
>>> are already not using the top 4 bits. Please correct me if I am wrong.
>>
>> Another limiting constraint is the number of address bits coverable by
>> the 4-level page tables we use.  And this is sign extended so we have
>> a top-half and a bottom-half with a "hole" in the center of the VA
>> space.
>>
>> I want some clarification on the top bits during ADI accesses.
>>
>> If ADI is enabled, then the top bits of the virtual address are
>> intepreted as tag bits.  Once "verified" with the ADI settings, what
>> happense to these tag bits?  Are they dropped from the virtual address
>> before being passed down the TLB et al. for translations?
> 
> Bits 63-60 (tag bits) are dropped from the virtual address before
> being passed down the TLB for translation when PSTATE.mcde = 1.

Ok and you said that values 15 and 0 are special.

I'm just wondering if this means you can't really use ADI mappings in
the top half of the 64-bit address space.  If the bits are dropped, they
will be zero, but they need to be all 1's for the top-half of the VA
space since it's sign extended.
