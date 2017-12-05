From: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v2] mmap.2: MAP_FIXED updated documentation
Date: Mon, 4 Dec 2017 18:52:27 -0800
Message-ID: <6777116d-ad9e-48c9-0009-01d10274135e@nvidia.com>
References: <20171204021411.4786-1-jhubbard@nvidia.com>
 <20171204113113.GA13465@rapoport-lnx>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9020 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751380AbdLECw2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Dec 2017 21:52:28 -0500
In-Reply-To: <20171204113113.GA13465@rapoport-lnx>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>, linux-man <linux-man@vger.kernel.org>, linux-api@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Jann Horn <jannh@google.com>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>

On 12/04/2017 03:31 AM, Mike Rapoport wrote:
> On Sun, Dec 03, 2017 at 06:14:11PM -0800, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
>>
[...]
>> +.IP
>> +Given the above limitations, one of the very few ways to use this option
>> +safely is: mmap() a region, without specifying MAP_FIXED. Then, within that
>> +region, call mmap(MAP_FIXED) to suballocate regions. This avoids both the
>> +portability problem (because the first mmap call lets the kernel pick the
>> +address), and the address space corruption problem (because the region being
>> +overwritten is already owned by the calling thread).
> 
> Maybe "address space corruption problem caused by implicit calls to mmap"?
> The region allocated with the first mmap is not exactly owned by the
> thread and a multi-thread application can still corrupt its memory if
> different threads use mmap(MAP_FIXED) for overlapping regions.
> 
> My 2 cents.
> 

Hi Mike,

Yes, thanks for picking through this, and I agree that the above is misleading.
It should definitely not use the word "owned" at all. Re-doing the whole 
paragraph in order to make it all fit together nicely, I get this:

"Given the above limitations, one of the very few ways to use this option
safely is: mmap() an enclosing region, without specifying MAP_FIXED.
Then, within that region, call mmap(MAP_FIXED) to suballocate regions
within the enclosing region. This avoids both the portability problem 
(because the first mmap call lets the kernel pick the address), and the 
address space corruption problem (because implicit calls to mmap will 
not affect the already-mapped enclosing region)."

...how's that sound to you? I'll post a v3 soon with this.


thanks,
John Hubbard
NVIDIA
