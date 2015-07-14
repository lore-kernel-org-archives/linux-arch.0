From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: "perf record" if BITS_PER_LONG != 64 && !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
Date: Tue, 14 Jul 2015 16:02:45 +0300
Message-ID: <55A50875.8060904@intel.com>
References: <1436875946.2839.22.camel@synopsys.com>	 <55A5023C.7020907@intel.com> <1436878329.2839.26.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60274 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751503AbbGNNGm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Jul 2015 09:06:42 -0400
In-Reply-To: <1436878329.2839.26.camel@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "eranian@google.com" <eranian@google.com>, "jolsa@redhat.com" <jolsa@redhat.com>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "namhyung@gmail.com" <namhyung@gmail.com>, "dsahern@gmail.com" <dsahern@gmail.com>, "fweisbec@gmail.com" <fweisbec@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On 14/07/15 15:52, Alexey Brodkin wrote:
> Hi Adrian,
> 
> On Tue, 2015-07-14 at 15:36 +0300, Adrian Hunter wrote:
>> On 14/07/15 15:12, Alexey Brodkin wrote:
>> How about this:
>>
>> From: Adrian Hunter <adrian.hunter@intel.com>
>> Date: Tue, 14 Jul 2015 15:32:41 +0300
>> Subject: [PATCH] perf tools: Fix misplaced check for
>>  HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT
>>
>> Move the checking for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT
>> for AUX area mmaps until after checking if such mmaps are
>> used anyway.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  tools/perf/util/auxtrace.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
>> index 7e7405c9b936..83d9dd96fe08 100644
>> --- a/tools/perf/util/auxtrace.c
>> +++ b/tools/perf/util/auxtrace.c
>> @@ -53,11 +53,6 @@ int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
>>  {
>>  	struct perf_event_mmap_page *pc = userpg;
>>  
>> -#if BITS_PER_LONG != 64 && !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
>> -	pr_err("Cannot use AUX area tracing mmaps\n");
>> -	return -1;
>> -#endif
>> -
>>  	WARN_ONCE(mm->base, "Uninitialized auxtrace_mmap\n");
>>  
>>  	mm->userpg = userpg;
>> @@ -73,6 +68,11 @@ int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
>>  		return 0;
>>  	}
>>  
>> +#if BITS_PER_LONG != 64 && !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
>> +	pr_err("Cannot use AUX area tracing mmaps\n");
>> +	return -1;
>> +#endif
>> +
>>  	pc->aux_offset = mp->offset;
>>  	pc->aux_size = mp->len;
> 
> That was really fast!
> 
> And indeed fixes reported problem with "record".
>  --------------------------->8-------------------------
> # perf record ls -la
> total 32
> drwx------    2 root     root           140 Jan  1 00:00 .
> drwxrwxr-x   18 root     root           420 Jul 14  2015 ..
> -rw-------    1 root     root            19 Jan  1 00:00 .ash_history
> -rw-rw-r--    1 root     root             0 Jul 14  2015 .bash_history
> -rw-rw-r--    1 root     root           175 Jul 14  2015 .bash_logout
> -rw-rw-r--    1 root     root            78 Jul 14  2015 .bash_profile
> -rw-------    1 root     root           312 Jan  1 00:00 perf.data
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.059 MB perf.data (1528 samples) ]
> 
> # perf report
> # To display the perf.data header info, please use --header/--header-only options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 1K of event 'cycles'
> # Event count (approx.): 2902149
> #
> # Overhead  Command  Shared Object            Symbol                                
> # ........  .......  .......................  ......................................
> #
>      7.37%  ls       libuClibc-0.9.34-git.so  [.] _ppfs_parsespec                   
>      4.40%  ls       [kernel.kallsyms]        [k] memset                            
>      3.96%  ls       [kernel.kallsyms]        [k] aligndestination                  
>      3.74%  ls       ld-uClibc-0.9.34-git.so  [.] _dl_find_hash                     
>      2.34%  ls       [kernel.kallsyms]        [k] perf_event_exec                   
>      2.28%  ls       [kernel.kallsyms]        [k] flush_signal_handlers             
>      2.28%  ls       [kernel.kallsyms]        [k] _raw_spin_unlock_irqrestore       
>      1.77%  ls       libuClibc-0.9.34-git.so  [.] __stdio_fwrite                    
>      1.43%  ls       [kernel.kallsyms]        [k] copy_page_to_iter                 
>      1.36%  ls       libuClibc-0.9.34-git.so  [.] _ppfs_init                        
>      1.22%  ls       [kernel.kallsyms]        [k] filemap_map_pages 
>  --------------------------->8-------------------------
> 
> Thanks a lot for your prompt response.
> Feel free to add my Tested-by then.

+Arnaldo

Here is one for the urgent queue.
