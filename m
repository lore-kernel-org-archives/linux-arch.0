Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750969AbdGJFox (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Jul 2017 01:44:53 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6A5hV4f003198
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2017 01:44:52 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2bjv03xvkv-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2017 01:44:52 -0400
Received: from localhost
        by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <khandual@linux.vnet.ibm.com>;
        Mon, 10 Jul 2017 15:44:49 +1000
Subject: Re: [RFC v5 00/38] powerpc: Memory Protection Keys
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Mon, 10 Jul 2017 11:13:23 +0530
MIME-Version: 1.0
In-Reply-To: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-ID: <d9030b2c-493b-94c4-8c97-8aaec3be34ba@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
Message-ID: <20170710054323.KrVC0RxQTmI4EHJtXiesDPGT3J0v5QFkzEL_i3vg8uw@z>

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
