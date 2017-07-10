From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC v5 00/38] powerpc: Memory Protection Keys
Date: Mon, 10 Jul 2017 11:13:23 +0530
Message-ID: <d9030b2c-493b-94c4-8c97-8aaec3be34ba@linux.vnet.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
List-Id: linux-arch.vger.kernel.org

On 07/06/2017 02:51 AM, Ram Pai wrote:
> Memory protection keys enable applications to protect its
> address space from inadvertent access or corruption from
> itself.
> 
> The overall idea:
> 
>  A process allocates a   key  and associates it with
>  an  address  range  within    its   address   space.
>  The process  then  can  dynamically  set read/write 
>  permissions on  the   key   without  involving  the 
>  kernel. Any  code that  violates   the  permissions
>  of  the address space; as defined by its associated
>  key, will receive a segmentation fault.
> 
> This patch series enables the feature on PPC64 HPTE
> platform.
> 
> ISA3.0 section 5.7.13 describes the detailed specifications.
> 
> 
> Testing:
> 	This patch series has passed all the protection key
> 	tests available in  the selftests directory.
> 	The tests are updated to work on both x86 and powerpc.
> 
> version v5:
> 	(1) reverted back to the old design -- store the 
> 	    key in the pte, instead of bypassing it.
> 	    The v4 design slowed down the hash page path.
> 	(2) detects key violation when kernel is told to 
> 		access user pages.
> 	(3) further refined the patches into smaller consumable
> 		units
> 	(4) page faults handlers captures the faulting key 
> 	    from the pte instead of the vma. This closes a
> 	    race between where the key update in the vma and
> 	    a key fault caused cause by the key programmed
> 	    in the pte.
> 	(5) a key created with access-denied should
> 	    also set it up to deny write. Fixed it.
> 	(6) protection-key number is displayed in smaps
> 		the x86 way.

Hello Ram,

This patch series has now grown a lot. Do you have this
hosted some where for us to pull and test it out ? BTW
do you have data points to show the difference in
performance between this version and the last one where
we skipped the bits from PTE and directly programmed the
HPTE entries looking into VMA bits.

- Anshuman

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
