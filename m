From: Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Date: Fri, 31 Jul 2020 13:55:07 -0400
Message-ID: <f4ce3f4a-bdee-ec43-986c-8e4d8b1d2ddc@oracle.com>
References: <20200730171251.GI23808@casper.infradead.org>
 <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
 <20200730174956.GK23808@casper.infradead.org>
 <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com>
 <87y2n03brx.fsf@x220.int.ebiederm.org>
 <689d6348-6029-5396-8de7-a26bc3c017e5@oracle.com>
 <20200731152736.GP23808@casper.infradead.org>
 <9ba26063-0098-e796-9431-8c1d0c076ffc@oracle.com>
 <20200731165649.GG24045@ziepe.ca>
 <71ddd3c1-bb59-3e63-e137-99b88ace454d@oracle.com>
 <20200731174837.GH24045@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:33436 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729753AbgGaR4A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 13:56:00 -0400
In-Reply-To: <20200731174837.GH24045@ziepe.ca>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Matthew Wilcox <willy@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org, ktkhai@virtuozzo.com, christian.brauner@ubuntu.com, peterz@infradead.org, esyr@redhat.com, christian@kellner.me, areber@redhat.com, cyphar@cyphar.com

On 7/31/2020 1:48 PM, Jason Gunthorpe wrote:
> On Fri, Jul 31, 2020 at 01:15:34PM -0400, Steven Sistare wrote:
>> On 7/31/2020 12:56 PM, Jason Gunthorpe wrote:
>>> On Fri, Jul 31, 2020 at 12:11:52PM -0400, Steven Sistare wrote:
>>>>> Your preservation-across-exec use-case might or might not need the
>>>>> VMA to be mapped at the same address.  
>>>>
>>>> It does.  qemu registers memory with vfio which remembers the va's in kernel
>>>> metadata for the device.
>>>
>>> Once the memory is registered with vfio the VA doesn't matter, vfio
>>> will keep the iommu pointing at the same physical pages no matter
>>> where they are mapped.
>>
>> Yes, but there are other code paths that compute and use offsets between va and the
>> base va.  Mapping at a different va in the new process breaks vfio; I have tried it.
> 
> Maybe you could fix vfio instead of having this adventure, if vfio is
> the only motivation.

Maybe.  We still need to preserve an anonymous segment, though.  MADV_DOEXEC, or mshare,
or something else.  And I think the ability to preserve memory containing pointers to itself
is an interesting use case, though not ours.

- Steve
