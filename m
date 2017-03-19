Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38342 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752132AbdCSP2v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sun, 19 Mar 2017 11:28:51 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v2J8reba000448
        for <linux-arch@vger.kernel.org>; Sun, 19 Mar 2017 04:56:12 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
        by mx0b-001b2d01.pphosted.com with ESMTP id 29911p0th0-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sun, 19 Mar 2017 04:56:12 -0400
Received: from localhost
        by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
        Sun, 19 Mar 2017 18:56:09 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 26/26] x86/mm: allow to have userspace mappings above 47-bits
In-Reply-To: <877f3lfzdo.fsf@skywalker.in.ibm.com>
References: <20170313055020.69655-1-kirill.shutemov@linux.intel.com> <20170313055020.69655-27-kirill.shutemov@linux.intel.com> <87a88jg571.fsf@skywalker.in.ibm.com> <20170317175714.3bvpdylaaudf4ig2@node.shutemov.name> <877f3lfzdo.fsf@skywalker.in.ibm.com>
Date: Sun, 19 Mar 2017 14:25:08 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <878to1sl1v.fsf@skywalker.in.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170319085508.iPfaNWB6WLV8-QyMPHANZGsZlYCT-BP98kbZT32BWJc@z>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> "Kirill A. Shutemov" <kirill@shutemov.name> writes:
>
>> On Fri, Mar 17, 2017 at 11:23:54PM +0530, Aneesh Kumar K.V wrote:
>>> "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> writes:
>>> 
>>> > On x86, 5-level paging enables 56-bit userspace virtual address space.
>>> > Not all user space is ready to handle wide addresses. It's known that
>>> > at least some JIT compilers use higher bits in pointers to encode their
>>> > information. It collides with valid pointers with 5-level paging and
>>> > leads to crashes.
>>> >
>>> > To mitigate this, we are not going to allocate virtual address space
>>> > above 47-bit by default.
>>> >
>>> > But userspace can ask for allocation from full address space by
>>> > specifying hint address (with or without MAP_FIXED) above 47-bits.
>>> >
>>> > If hint address set above 47-bit, but MAP_FIXED is not specified, we try
>>> > to look for unmapped area by specified address. If it's already
>>> > occupied, we look for unmapped area in *full* address space, rather than
>>> > from 47-bit window.
>>> >
>>> > This approach helps to easily make application's memory allocator aware
>>> > about large address space without manually tracking allocated virtual
>>> > address space.
>>> >
>>> 
>>> So if I have done a successful mmap which returned > 128TB what should a
>>> following mmap(0,...) return ? Should that now search the *full* address
>>> space or below 128TB ?
>>
>> No, I don't think so. And this implementation doesn't do this.
>>
>> It's safer this way: if an library can't handle high addresses, it's
>> better not to switch it automagically to full address space if other part
>> of the process requested high address.
>>
>
> What is the epectation when the hint addr is below 128TB but addr + len >
> 128TB ? Should such mmap request fail ?

Considering that we have stack at the top (around 128TB) we may not be
able to get a free area for such a request. But I guess the idea here is
that if hint address is below 128TB, we behave as though our TASK_SIZE
is 128TB ? Is that correct ?
 
-aneesh
