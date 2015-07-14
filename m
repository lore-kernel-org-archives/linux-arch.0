From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: "perf record" if BITS_PER_LONG != 64 && !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
Date: Tue, 14 Jul 2015 15:36:12 +0300
Message-ID: <55A5023C.7020907@intel.com>
References: <1436875946.2839.22.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44758 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799AbbGNMiq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Jul 2015 08:38:46 -0400
In-Reply-To: <1436875946.2839.22.camel@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "jolsa@redhat.com" <jolsa@redhat.com>, "eranian@google.com" <eranian@google.com>, "namhyung@gmail.com" <namhyung@gmail.com>, "dsahern@gmail.com" <dsahern@gmail.com>, "fweisbec@gmail.com" <fweisbec@gmail.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On 14/07/15 15:12, Alexey Brodkin wrote:
> Hi Adrian,
> 
> Just noticed that starting from Linux v4.2-rc1 "perf record"
> doesn't work on ARC. That's what I see:
>  ------------>8------------
>  # perf record ls -la
>  Cannot use AUX area tracing mmaps
>  failed to mmap with 38 (Function not implemented)
>  ------------>8------------
> 
> I believe that happens because by default auxtrace is enabled
> (NO_AUXTRACE=0) and so auxtrace_mmap__mmap() from
> "tools/perf/util/auxtrace.c" gets compiled in and following
> check fails:
>  ------------>8------------
>  #if BITS_PER_LONG != 64 && !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
>  	pr_err("Cannot use AUX area tracing mmaps\n");
>  	return -1;
>  #endif
>  ------------>8------------
> 
> Unfortunately we don't have __sync_val_compare_and_swap()
> in our current toolchain. And ARC as of today is 32-bit architecture.
> 
> Now if I pass NO_AUXTRACE=1 in perf building command then everything
> works as expected.
> 
> So I'm wondering what would be the best way to get perf properly
> working for ARC (at least) and probably other architecture/toolchain
> combos?
> 
> I see at least 2 options:
> 
>  [1] Add feature check for BITS_PER_LONG. And then if
>      "BITS_PER_LONG != 32 & HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT"
>      automatically set "NO_AUXTRACE=1" on building perf.
> 
>  [2] By default enable auxtrace only on selected architectures.
>      For example Intel 64-bit and maybe others who really capable of
>      running auxtrace (and may make use of it).
> 
> Any suggestions are much appreciated.
> 
> Just in case that's my back-trace to auxtrace_mmap__mmap():
>  ------------>8------------
> #0  auxtrace_mmap__mmap (mm=0x11a1a44, mp=0x5fa468c0, userpg=0x2021e000, fd=4)
>     at util/auxtrace.c:57
> #1  0x0005d3b0 in __perf_evlist__mmap (evlist=0x11a0f30, evlist=0x11a0f30, 
>     fd=4, mp=0x5fa468b8, idx=0) at util/evlist.c:838
> #2  perf_evlist__mmap_per_evsel (evlist=evlist@entry=0x11a0f30, 
>     idx=idx@entry=0, mp=mp@entry=0x5fa468b8, cpu=cpu@entry=0, 
>     thread=thread@entry=0, output=output@entry=0x5fa468b4) at util/evlist.c:861
> #3  0x0005de1e in perf_evlist__mmap_per_cpu (mp=0x5fa468b8, evlist=0x11a0f30)
>     at util/evlist.c:910
> #4  perf_evlist__mmap_ex (evlist=0x11a0f30, evlist@entry=0x0, 
>     pages=<optimized out>, overwrite=overwrite@entry=false, auxtrace_pages=0, 
>     auxtrace_overwrite=<optimized out>) at util/evlist.c:1095
> #5  0x0001e906 in record__open (rec=0xf11a0 <record>) at builtin-record.c:305
> #6  __cmd_record (rec=0xf11a0 <record>, argv=<optimized out>, 
>     argc=<optimized out>) at builtin-record.c:519
> #7  cmd_record (argc=<optimized out>, argv=<optimized out>, 
>     prefix=<optimized out>) at builtin-record.c:1168
> #8  0x00053758 in run_builtin (p=p@entry=0xf2938 <commands+72>, 
>     argc=argc@entry=2, argv=argv@entry=0x11a1730) at perf.c:370
> #9  0x00053f10 in handle_internal_command (argv=0x11a1730, argc=2)
>     at perf.c:429
> #10 run_argv (argv=0x5fa47c70, argcp=0x5fa47c74) at perf.c:473
> #11 main (argc=2, argv=0x5fa47d98) at perf.c:588
>  ------------>8------------
> 

How about this:

From: Adrian Hunter <adrian.hunter@intel.com>
Date: Tue, 14 Jul 2015 15:32:41 +0300
Subject: [PATCH] perf tools: Fix misplaced check for
 HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT

Move the checking for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT
for AUX area mmaps until after checking if such mmaps are
used anyway.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 7e7405c9b936..83d9dd96fe08 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -53,11 +53,6 @@ int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
 {
 	struct perf_event_mmap_page *pc = userpg;
 
-#if BITS_PER_LONG != 64 && !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
-	pr_err("Cannot use AUX area tracing mmaps\n");
-	return -1;
-#endif
-
 	WARN_ONCE(mm->base, "Uninitialized auxtrace_mmap\n");
 
 	mm->userpg = userpg;
@@ -73,6 +68,11 @@ int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
 		return 0;
 	}
 
+#if BITS_PER_LONG != 64 && !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
+	pr_err("Cannot use AUX area tracing mmaps\n");
+	return -1;
+#endif
+
 	pc->aux_offset = mp->offset;
 	pc->aux_size = mp->len;
 
-- 
1.9.1
