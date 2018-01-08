From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Mon, 8 Jan 2018 19:21:38 +0100
Message-ID: <20180108182138.kzdwkdwmhc3564s2@gmail.com>
References: <20180106200912.zhzdt4qmfrojeeqe@ast-mbp>
 <20180106202213.23e553fb@alans-desktop>
 <20180106211729.cp5oet3at3hyce4o@ast-mbp>
 <20180106230507.3547c9a0@alans-desktop>
 <20180107033812.awq3vz4gdkps7tix@ast-mbp>
 <20180107063356.GA9425@1wt.eu>
 <CA+55aFzqb-p_Ng2nsXvFsibtNC2rH5fwrefwnwA3TTFVtzM3FA@mail.gmail.com>
 <CAPcyv4gm0tAbLHHyMvsbghV+SpnbaTCmJd6N8imwUnRZ9k2xUA@mail.gmail.com>
 <20180108022409.q2riz6wzbcm3dkx6@ast-mbp>
 <20180108095154.GD3040@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43428 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754862AbeAHSVm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jan 2018 13:21:42 -0500
Content-Disposition: inline
In-Reply-To: <20180108095154.GD3040@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Network Development <netdev@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Sun, Jan 07, 2018 at 06:24:11PM -0800, Alexei Starovoitov wrote:
> > How about:
> > CONFIG_SPECTRE1_WORKAROUND_INDEX_MASK
> > CONFIG_SPECTRE1_WORKAROUND_LOAD_FENCE
> 
> INSTRUCTION_FENCE if anything. LFENCE for Intel (and now also for AMD as
> per 0592b0bce169) is a misnomer, IFENCE would be a better name for it.

Btw., we should probably propagate that naming to most places and only point it 
out in comments/documentation that Intel/AMD calls this CPU functionality 'LFENCE' 
for historic reasons and that the opcode got stolen for the Spectre fixes.

Thanks,

	Ingo
