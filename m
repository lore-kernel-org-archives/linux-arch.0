Return-Path: <SRS0=jayZ=7S=kvack.org=owner-linux-mm@kernel.org>
Subject: Re: [PATCH 1/2] MIPS: set page access bit with pgprot on some MIPS
 platform
References: <1591348266-28392-1-git-send-email-maobibo@loongson.cn>
 <20200605173909.000018ff@flygoat.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <ce625c9d-a4bb-7138-c599-62b30b65c408@loongson.cn>
Date: Fri, 5 Jun 2020 17:51:43 +0800
MIME-Version: 1.0
In-Reply-To: <20200605173909.000018ff@flygoat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mm@kvack.org
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Andrew Morton <akpm@linux-foundation.org>, Paul Burton <paulburton@kernel.org>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200605095143.vipJ1HlK9Zq5h9z8zARnrFtI__K8CbeaFOhksyB4nDM@z>



On 06/05/2020 05:39 PM, Jiaxun Yang wrote:
> On Fri,  5 Jun 2020 17:11:05 +0800
> Bibo Mao <maobibo@loongson.cn> wrote:
> 
>> On MIPS system which has rixi hardware bit, page access bit is not
>> set in pgrot. For memory reading, there will be one page fault to
>> allocate physical page; however valid bit is not set, there will
>> be the second fast tlb-miss fault handling to set valid/access bit.
>>
>> This patch set page access/valid bit with pgrot if there is reading
>> access privilege. It will reduce one tlb-miss handling for memory
>> reading access.
>>
>> The valid/access bit will be cleared in order to track memory
>> accessing activity. If the page is accessed, tlb-miss fast handling
>> will set valid/access bit, pte_sw_mkyoung is not necessary in slow
>> page fault path. This patch removes pte_sw_mkyoung function which
>> is defined as empty function except MIPS system.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
> 
> Thanks for tracking it down.
> 
> Could you please make the patch tittle more clear?
> "Some" looks confuse to me, "systems with RIXI" would be better.

Sure, will add it.

> 
> - Jiaxun
> 
