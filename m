Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43215 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756289AbdDGNfn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Apr 2017 09:35:43 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v37DSrwa014181
        for <linux-arch@vger.kernel.org>; Fri, 7 Apr 2017 09:35:43 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
        by mx0a-001b2d01.pphosted.com with ESMTP id 29pbcrhnp2-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 07 Apr 2017 09:35:42 -0400
Received: from localhost
        by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <khandual@linux.vnet.ibm.com>;
        Fri, 7 Apr 2017 19:05:39 +0530
Subject: Re: [PATCH 8/8] x86/mm: Allow to have userspace mappings above
 47-bits
References: <20170406140106.78087-1-kirill.shutemov@linux.intel.com>
 <20170406140106.78087-9-kirill.shutemov@linux.intel.com>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 7 Apr 2017 19:05:26 +0530
MIME-Version: 1.0
In-Reply-To: <20170406140106.78087-9-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-ID: <8d68093b-670a-7d7e-2216-bf64b19c7a48@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Dmitry Safonov <dsafonov@virtuozzo.com>
Message-ID: <20170407133526.YmcpSOikRHG6-CHYI2O-cy8O2uWtFLZYpUjvwaYfpBQ@z>

On 04/06/2017 07:31 PM, Kirill A. Shutemov wrote:
> On x86, 5-level paging enables 56-bit userspace virtual address space.
> Not all user space is ready to handle wide addresses. It's known that
> at least some JIT compilers use higher bits in pointers to encode their
> information. It collides with valid pointers with 5-level paging and
> leads to crashes.
> 
> To mitigate this, we are not going to allocate virtual address space
> above 47-bit by default.

I am wondering if the commitment of virtual space range to the
user space is kind of an API which needs to be maintained there
after. If that is the case then we need to have some plans when
increasing it from the current level.

Will those JIT compilers keep using the higher bit positions of
the pointer for ever ? Then it will limit the ability of the
kernel to expand the virtual address range later as well. I am
not saying we should not increase till the extent it does not
affect any *known* user but then we should not increase twice
for now, create the hint mechanism to be passed from the user
to avail beyond that (which will settle in as a expectation
from the kernel later on). Do the same thing again while
expanding the address range next time around. I think we need
to have a plan for this and particularly around 'hint' mechanism
and whether it should be decided per mmap() request or at the
task level.
