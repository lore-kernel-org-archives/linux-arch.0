From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v5, part4 20/41] mm/h8300: prepare for removing num_physpages
 and simplify mem_init()
Date: Wed, 08 May 2013 23:29:36 +0400
Message-ID: <518AA7A0.1020702@cogentembedded.com>
References: <1368028298-7401-1-git-send-email-jiang.liu@huawei.com> <1368028298-7401-21-git-send-email-jiang.liu@huawei.com> <518A7CC0.1010606@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <518A7CC0.1010606@cogentembedded.com>
Sender: owner-linux-mm@kvack.org
To: Jiang Liu <liuj97@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiang Liu <jiang.liu@huawei.com>, David Rientjes <rientjes@google.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, James Bottomley <James.Bottomley@HansenPartnership.com>, David Howells <dhowells@redhat.com>, Mark Salter <msalter@redhat.com>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-arch.vger.kernel.org

Hello.

On 05/08/2013 08:26 PM, Sergei Shtylyov wrote:

>
>> Prepare for removing num_physpages and simplify mem_init().
>
>> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   arch/h8300/mm/init.c |   34 ++++++++--------------------------
>>   1 file changed, 8 insertions(+), 26 deletions(-)
>
>> diff --git a/arch/h8300/mm/init.c b/arch/h8300/mm/init.c
>> index 22fd869..0088f3a 100644
>> --- a/arch/h8300/mm/init.c
>> +++ b/arch/h8300/mm/init.c
>> @@ -121,40 +121,22 @@ void __init paging_init(void)
>>
>>   void __init mem_init(void)
>>   {
>> -    int codek = 0, datak = 0, initk = 0;
>> -    /* DAVIDM look at setup memory map generically with reserved 
>> area */
>> -    unsigned long tmp;
>> -    extern unsigned long  _ramend, _ramstart;
>> -    unsigned long len = &_ramend - &_ramstart;
>> -    unsigned long start_mem = memory_start; /* DAVIDM - these must 
>> start at end of kernel */
>> -    unsigned long end_mem   = memory_end; /* DAVIDM - this must not 
>> include kernel stack at top */
>> +    unsigned long codesize = _etext - _stext;
>>
>>   #ifdef DEBUG
>> -    printk(KERN_DEBUG "Mem_init: start=%lx, end=%lx\n", start_mem, 
>> end_mem);
>> +    pr_debug("Mem_init: start=%lx, end=%lx\n", memory_start, 
>> memory_end);
>>   #endif
>
>     pr_debug() only prints something if DEBUG is #define'd, so you can 
> drop the #ifdef here.

     Although, not necessarily: it also supports CONFIG_DYNAMIC_DEBUG -- 
look at how pr_debug() is defined.
So this doesn't seem to be an equivalent change, and I suggest not doing 
it at all.

WBR, Sergei

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
