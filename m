From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: Re: [RFC PATCH] lib/ioremap: Avoid triggering BUG_ON when end is not
 PAGE_ALIGN
Date: Sat, 31 Mar 2018 09:27:24 +0800
Message-ID: <9c186ae8-6350-e1ab-001a-23ae87ce030d@huawei.com>
References: <1522385385-7074-1-git-send-email-xieyisheng1@huawei.com>
 <1522431689.2693.290.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522431689.2693.290.camel@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Kani, Toshi" <toshi.kani@hpe.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "guohanjun@huawei.com" <guohanjun@huawei.com>, "tanxiaojun@huawei.com" <tanxiaojun@huawei.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "jcm@redhat.com" <jcm@redhat.com>
List-Id: linux-arch.vger.kernel.org

Hi Toshi,

On 2018/3/31 1:41, Kani, Toshi wrote:
> On Fri, 2018-03-30 at 12:49 +0800, Yisheng Xie wrote:
>> Zhou reported a bug on Hisilicon arm64 D06 platform with 64KB page size:
>  :
>> The cause is the size of PCI IO resource is 32KB, which is 4K aligned but
>> not 64KB aligned, so when do ioremap_pte_range(), its incoming end is not
>> PAGE_ALIGN on 64KB page size system, but ioremap_pte_range increase the
>> addr by PAGE_SIZE, which makes addr != end until trigger BUG_ON.
>>
>> This patch introduces pte_addr_end(addr, end) to resolve this problem, just
>> as what pmd_addr_end do. When end is not PAGE_ALIGN, it will return end
>> instead of addr + PAGE_SIZE, therefore ioremap_pte_range() can break out
>> when real end is coming.
> 
> ioremap_pte_range() assumes that addr and end are aligned by PAGE_SIZE. 
> While some improvement can be made in the range check and documentation,
>  I do not think it is safe for letting this library function to map
> outside of a requested range blindly.
> 
> Can you change the caller of ioremap_page_range() to align the request
> by PAGE_SIZE so that the caller is aware of what it's asking for? 

Sure, as the name of ioremap_*page*_range(), the caller should make sure align
the request by PAGE_SIZE.

Thanks
Yisheng
> 
> Thanks,
> -Toshi
> 
