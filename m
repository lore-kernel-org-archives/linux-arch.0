From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Mon, 8 Jan 2018 10:51:54 +0100
Message-ID: <20180108095154.GD3040@hirez.programming.kicks-ass.net>
References: <20180106195551.3207f75d@alans-desktop>
 <20180106200912.zhzdt4qmfrojeeqe@ast-mbp>
 <20180106202213.23e553fb@alans-desktop>
 <20180106211729.cp5oet3at3hyce4o@ast-mbp>
 <20180106230507.3547c9a0@alans-desktop>
 <20180107033812.awq3vz4gdkps7tix@ast-mbp>
 <20180107063356.GA9425@1wt.eu>
 <CA+55aFzqb-p_Ng2nsXvFsibtNC2rH5fwrefwnwA3TTFVtzM3FA@mail.gmail.com>
 <CAPcyv4gm0tAbLHHyMvsbghV+SpnbaTCmJd6N8imwUnRZ9k2xUA@mail.gmail.com>
 <20180108022409.q2riz6wzbcm3dkx6@ast-mbp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:39929 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932077AbeAHJwI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jan 2018 04:52:08 -0500
Content-Disposition: inline
In-Reply-To: <20180108022409.q2riz6wzbcm3dkx6@ast-mbp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Network Development <netdev@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

On Sun, Jan 07, 2018 at 06:24:11PM -0800, Alexei Starovoitov wrote:
> How about:
> CONFIG_SPECTRE1_WORKAROUND_INDEX_MASK
> CONFIG_SPECTRE1_WORKAROUND_LOAD_FENCE

INSTRUCTION_FENCE if anything. LFENCE for Intel (and now also for AMD as
per 0592b0bce169) is a misnomer, IFENCE would be a better name for it.
