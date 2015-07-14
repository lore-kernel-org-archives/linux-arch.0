From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: "perf record" if BITS_PER_LONG != 64 &&
 !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
Date: Tue, 14 Jul 2015 12:12:26 +0000
Message-ID: <1436875946.2839.22.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:53294 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751644AbbGNMNA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2015 08:13:00 -0400
Content-Language: en-US
Content-ID: <6497DEFD0EE5E548B4514B1A841997AC@internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "jolsa@redhat.com" <jolsa@redhat.com>, "eranian@google.com" <eranian@google.com>, "namhyung@gmail.com" <namhyung@gmail.com>, "dsahern@gmail.com" <dsahern@gmail.com>, "fweisbec@gmail.com" <fweisbec@gmail.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

Hi Adrian,

Just noticed that starting from Linux v4.2-rc1 +ACI-perf record+ACI-
doesn't work on ARC. That's what I see:
 ------------+AD4-8------------
 +ACM- perf record ls -la
 Cannot use AUX area tracing mmaps
 failed to mmap with 38 (Function not implemented)
 ------------+AD4-8------------

I believe that happens because by default auxtrace is enabled
(NO+AF8-AUXTRACE+AD0-0) and so auxtrace+AF8-mmap+AF8AXw-mmap() from
+ACI-tools/perf/util/auxtrace.c+ACI- gets compiled in and following
check fails:
 ------------+AD4-8------------
 +ACM-if BITS+AF8-PER+AF8-LONG +ACEAPQ- 64 +ACYAJg- +ACE-defined(HAVE+AF8-SYNC+AF8-COMPARE+AF8-AND+AF8-SWAP+AF8-SUPPORT)
 	pr+AF8-err(+ACI-Cannot use AUX area tracing mmaps+AFw-n+ACI-)+ADs-
 	return -1+ADs-
 +ACM-endif
 ------------+AD4-8------------

Unfortunately we don't have +AF8AXw-sync+AF8-val+AF8-compare+AF8-and+AF8-swap()
in our current toolchain. And ARC as of today is 32-bit architecture.

Now if I pass NO+AF8-AUXTRACE+AD0-1 in perf building command then everything
works as expected.

So I'm wondering what would be the best way to get perf properly
working for ARC (at least) and probably other architecture/toolchain
combos?

I see at least 2 options:

 +AFs-1+AF0- Add feature check for BITS+AF8-PER+AF8-LONG. And then if
     +ACI-BITS+AF8-PER+AF8-LONG +ACEAPQ- 32 +ACY- HAVE+AF8-SYNC+AF8-COMPARE+AF8-AND+AF8-SWAP+AF8-SUPPORT+ACI-
     automatically set +ACI-NO+AF8-AUXTRACE+AD0-1+ACI- on building perf.

 +AFs-2+AF0- By default enable auxtrace only on selected architectures.
     For example Intel 64-bit and maybe others who really capable of
     running auxtrace (and may make use of it).

Any suggestions are much appreciated.

Just in case that's my back-trace to auxtrace+AF8-mmap+AF8AXw-mmap():
 ------------+AD4-8------------
+ACM-0  auxtrace+AF8-mmap+AF8AXw-mmap (mm+AD0-0x11a1a44, mp+AD0-0x5fa468c0, userpg+AD0-0x2021e000, fd+AD0-4)
    at util/auxtrace.c:57
+ACM-1  0x0005d3b0 in +AF8AXw-perf+AF8-evlist+AF8AXw-mmap (evlist+AD0-0x11a0f30, evlist+AD0-0x11a0f30, 
    fd+AD0-4, mp+AD0-0x5fa468b8, idx+AD0-0) at util/evlist.c:838
+ACM-2  perf+AF8-evlist+AF8AXw-mmap+AF8-per+AF8-evsel (evlist+AD0-evlist+AEA-entry+AD0-0x11a0f30, 
    idx+AD0-idx+AEA-entry+AD0-0, mp+AD0-mp+AEA-entry+AD0-0x5fa468b8, cpu+AD0-cpu+AEA-entry+AD0-0, 
    thread+AD0-thread+AEA-entry+AD0-0, output+AD0-output+AEA-entry+AD0-0x5fa468b4) at util/evlist.c:861
+ACM-3  0x0005de1e in perf+AF8-evlist+AF8AXw-mmap+AF8-per+AF8-cpu (mp+AD0-0x5fa468b8, evlist+AD0-0x11a0f30)
    at util/evlist.c:910
+ACM-4  perf+AF8-evlist+AF8AXw-mmap+AF8-ex (evlist+AD0-0x11a0f30, evlist+AEA-entry+AD0-0x0, 
    pages+AD0APA-optimized out+AD4-, overwrite+AD0-overwrite+AEA-entry+AD0-false, auxtrace+AF8-pages+AD0-0, 
    auxtrace+AF8-overwrite+AD0APA-optimized out+AD4-) at util/evlist.c:1095
+ACM-5  0x0001e906 in record+AF8AXw-open (rec+AD0-0xf11a0 +ADw-record+AD4-) at builtin-record.c:305
+ACM-6  +AF8AXw-cmd+AF8-record (rec+AD0-0xf11a0 +ADw-record+AD4-, argv+AD0APA-optimized out+AD4-, 
    argc+AD0APA-optimized out+AD4-) at builtin-record.c:519
+ACM-7  cmd+AF8-record (argc+AD0APA-optimized out+AD4-, argv+AD0APA-optimized out+AD4-, 
    prefix+AD0APA-optimized out+AD4-) at builtin-record.c:1168
+ACM-8  0x00053758 in run+AF8-builtin (p+AD0-p+AEA-entry+AD0-0xf2938 +ADw-commands+-72+AD4-, 
    argc+AD0-argc+AEA-entry+AD0-2, argv+AD0-argv+AEA-entry+AD0-0x11a1730) at perf.c:370
+ACM-9  0x00053f10 in handle+AF8-internal+AF8-command (argv+AD0-0x11a1730, argc+AD0-2)
    at perf.c:429
+ACM-10 run+AF8-argv (argv+AD0-0x5fa47c70, argcp+AD0-0x5fa47c74) at perf.c:473
+ACM-11 main (argc+AD0-2, argv+AD0-0x5fa47d98) at perf.c:588
 ------------+AD4-8------------

-Alexey