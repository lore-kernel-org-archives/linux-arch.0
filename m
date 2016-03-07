Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:39710 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbcCGVHa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Mar 2016 16:07:30 -0500
Subject: Re: [PATCH v2] sparc64: Add support for Application Data Integrity
 (ADI)
References: <1456951177-23579-1-git-send-email-khalid.aziz@oracle.com>
 <20160305.230702.1325379875282120281.davem@davemloft.net>
 <56DD9949.1000106@oracle.com> <56DD9E94.70201@oracle.com>
 <CALCETrXey2_xEXhzjgHtZmf-dLp-9pec===d-8chLxrp8wgRXg@mail.gmail.com>
 <56DDA6FD.4040404@oracle.com> <56DDBE68.6080709@linux.intel.com>
From: Khalid Aziz <khalid.aziz@oracle.com>
Message-ID: <56DDED63.8010302@oracle.com>
Date: Mon, 7 Mar 2016 14:06:43 -0700
MIME-Version: 1.0
In-Reply-To: <56DDBE68.6080709@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, Rob Gardner <rob.gardner@oracle.com>
Cc: David Miller <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, dingel@linux.vnet.ibm.com, zhenzhang.zhang@huawei.com, bob.picco@oracle.com, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, Arnd Bergmann <arnd@arndb.de>, sparclinux@vger.kernel.org, Michal Hocko <mhocko@suse.cz>, chris.hyser@oracle.com, Richard Weinberger <richard@nod.at>, Vlastimil Babka <vbabka@suse.cz>, Konstantin Khlebnikov <koct9i@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Greg Thelen <gthelen@google.com>, Jan Kara <jack@suse.cz>, xiexiuqi@huawei.com, Vineet.Gupta1@synopsys.com, Andrew Lutomirski <luto@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, bsegall@google.com, Geert Uytterhoeven <geert@linux-m68k.org>, Davidlohr Bueso <dave@stgolabs.net>, Alexey Dobriyan <adobriyan@gmail.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>
Message-ID: <20160307210643.m7FUgMvll_5ljXDSYagrQ5I5gquq429C8pECjIYQl5s@z>

On 03/07/2016 10:46 AM, Dave Hansen wrote:
> On 03/07/2016 08:06 AM, Khalid Aziz wrote:
>> Top 4-bits of sparc64 virtual address are used for version tag only when
>> a process has its PSTATE.mcde bit set and it is accessing a memory
>> region that has ADI enabled on it (TTE.mcd set) and a version tag was
>> set on the virtual address being accessed. These 4-bits retain their
>> original semantics in all other cases.
>
> OK, so this effectively reduces the address space of a process using the
> feature.  Do we need to do anything explicit to keep an app from using
> that address space?  Do we make sure the kernel doesn't place VMAs
> there?  Do we respect mmap() hints that try to place memory there?
>

Good questions. Isn't set of valid VAs already constrained by VA_BITS 
(set to 44 in arch/sparc/include/asm/processor_64.h)? As I see it we are 
already not using the top 4 bits. Please correct me if I am wrong.

Thanks,
Khalid
