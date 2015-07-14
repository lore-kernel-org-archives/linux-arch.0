From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: "perf record" if BITS_PER_LONG != 64 &&
 !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
Date: Tue, 14 Jul 2015 12:52:09 +0000
Message-ID: <1436878329.2839.26.camel@synopsys.com>
References: <1436875946.2839.22.camel@synopsys.com>
	 <55A5023C.7020907@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:46547 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbbGNMwO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2015 08:52:14 -0400
In-Reply-To: <55A5023C.7020907@intel.com>
Content-Language: en-US
Content-ID: <7D85E48B095F3E4BA230A49ADE773DD8@internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "eranian@google.com" <eranian@google.com>, "jolsa@redhat.com" <jolsa@redhat.com>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "namhyung@gmail.com" <namhyung@gmail.com>, "dsahern@gmail.com" <dsahern@gmail.com>, "fweisbec@gmail.com" <fweisbec@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

Hi Adrian,

On Tue, 2015-07-14 at 15:36 +-0300, Adrian Hunter wrote:
+AD4- On 14/07/15 15:12, Alexey Brodkin wrote:
+AD4- How about this:
+AD4- 
+AD4- From: Adrian Hunter +ADw-adrian.hunter+AEA-intel.com+AD4-
+AD4- Date: Tue, 14 Jul 2015 15:32:41 +-0300
+AD4- Subject: +AFs-PATCH+AF0- perf tools: Fix misplaced check for
+AD4-  HAVE+AF8-SYNC+AF8-COMPARE+AF8-AND+AF8-SWAP+AF8-SUPPORT
+AD4- 
+AD4- Move the checking for HAVE+AF8-SYNC+AF8-COMPARE+AF8-AND+AF8-SWAP+AF8-SUPPORT
+AD4- for AUX area mmaps until after checking if such mmaps are
+AD4- used anyway.
+AD4- 
+AD4- Signed-off-by: Adrian Hunter +ADw-adrian.hunter+AEA-intel.com+AD4-
+AD4- ---
+AD4-  tools/perf/util/auxtrace.c +AHw- 10 +-+-+-+-+------
+AD4-  1 file changed, 5 insertions(+-), 5 deletions(-)
+AD4- 
+AD4- diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
+AD4- index 7e7405c9b936..83d9dd96fe08 100644
+AD4- --- a/tools/perf/util/auxtrace.c
+AD4- +-+-+- b/tools/perf/util/auxtrace.c
+AD4- +AEAAQA- -53,11 +-53,6 +AEAAQA- int auxtrace+AF8-mmap+AF8AXw-mmap(struct auxtrace+AF8-mmap +ACo-mm,
+AD4-  +AHs-
+AD4-  	struct perf+AF8-event+AF8-mmap+AF8-page +ACo-pc +AD0- userpg+ADs-
+AD4-  
+AD4- -+ACM-if BITS+AF8-PER+AF8-LONG +ACEAPQ- 64 +ACYAJg- +ACE-defined(HAVE+AF8-SYNC+AF8-COMPARE+AF8-AND+AF8-SWAP+AF8-SUPPORT)
+AD4- -	pr+AF8-err(+ACI-Cannot use AUX area tracing mmaps+AFw-n+ACI-)+ADs-
+AD4- -	return -1+ADs-
+AD4- -+ACM-endif
+AD4- -
+AD4-  	WARN+AF8-ONCE(mm-+AD4-base, +ACI-Uninitialized auxtrace+AF8-mmap+AFw-n+ACI-)+ADs-
+AD4-  
+AD4-  	mm-+AD4-userpg +AD0- userpg+ADs-
+AD4- +AEAAQA- -73,6 +-68,11 +AEAAQA- int auxtrace+AF8-mmap+AF8AXw-mmap(struct auxtrace+AF8-mmap +ACo-mm,
+AD4-  		return 0+ADs-
+AD4-  	+AH0-
+AD4-  
+AD4- +-+ACM-if BITS+AF8-PER+AF8-LONG +ACEAPQ- 64 +ACYAJg- +ACE-defined(HAVE+AF8-SYNC+AF8-COMPARE+AF8-AND+AF8-SWAP+AF8-SUPPORT)
+AD4- +-	pr+AF8-err(+ACI-Cannot use AUX area tracing mmaps+AFw-n+ACI-)+ADs-
+AD4- +-	return -1+ADs-
+AD4- +-+ACM-endif
+AD4- +-
+AD4-  	pc-+AD4-aux+AF8-offset +AD0- mp-+AD4-offset+ADs-
+AD4-  	pc-+AD4-aux+AF8-size +AD0- mp-+AD4-len+ADs-

That was really fast+ACE-

And indeed fixes reported problem with +ACI-record+ACI-.
 ---------------------------+AD4-8-------------------------
+ACM- perf record ls -la
total 32
drwx------    2 root     root           140 Jan  1 00:00 .
drwxrwxr-x   18 root     root           420 Jul 14  2015 ..
-rw-------    1 root     root            19 Jan  1 00:00 .ash+AF8-history
-rw-rw-r--    1 root     root             0 Jul 14  2015 .bash+AF8-history
-rw-rw-r--    1 root     root           175 Jul 14  2015 .bash+AF8-logout
-rw-rw-r--    1 root     root            78 Jul 14  2015 .bash+AF8-profile
-rw-------    1 root     root           312 Jan  1 00:00 perf.data
+AFs- perf record: Woken up 1 times to write data +AF0-
+AFs- perf record: Captured and wrote 0.059 MB perf.data (1528 samples) +AF0-

+ACM- perf report
+ACM- To display the perf.data header info, please use --header/--header-only options.
+ACM-
+ACM-
+ACM- Total Lost Samples: 0
+ACM-
+ACM- Samples: 1K of event 'cycles'
+ACM- Event count (approx.): 2902149
+ACM-
+ACM- Overhead  Command  Shared Object            Symbol                                
+ACM- ........  .......  .......................  ......................................
+ACM-
     7.37+ACU-  ls       libuClibc-0.9.34-git.so  +AFs-.+AF0- +AF8-ppfs+AF8-parsespec                   
     4.40+ACU-  ls       +AFs-kernel.kallsyms+AF0-        +AFs-k+AF0- memset                            
     3.96+ACU-  ls       +AFs-kernel.kallsyms+AF0-        +AFs-k+AF0- aligndestination                  
     3.74+ACU-  ls       ld-uClibc-0.9.34-git.so  +AFs-.+AF0- +AF8-dl+AF8-find+AF8-hash                     
     2.34+ACU-  ls       +AFs-kernel.kallsyms+AF0-        +AFs-k+AF0- perf+AF8-event+AF8-exec                   
     2.28+ACU-  ls       +AFs-kernel.kallsyms+AF0-        +AFs-k+AF0- flush+AF8-signal+AF8-handlers             
     2.28+ACU-  ls       +AFs-kernel.kallsyms+AF0-        +AFs-k+AF0- +AF8-raw+AF8-spin+AF8-unlock+AF8-irqrestore       
     1.77+ACU-  ls       libuClibc-0.9.34-git.so  +AFs-.+AF0- +AF8AXw-stdio+AF8-fwrite                    
     1.43+ACU-  ls       +AFs-kernel.kallsyms+AF0-        +AFs-k+AF0- copy+AF8-page+AF8-to+AF8-iter                 
     1.36+ACU-  ls       libuClibc-0.9.34-git.so  +AFs-.+AF0- +AF8-ppfs+AF8-init                        
     1.22+ACU-  ls       +AFs-kernel.kallsyms+AF0-        +AFs-k+AF0- filemap+AF8-map+AF8-pages 
 ---------------------------+AD4-8-------------------------

Thanks a lot for your prompt response.
Feel free to add my Tested-by then.

-Alexey