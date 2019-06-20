Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:34506 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725913AbfFTUt6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Jun 2019 16:49:58 -0400
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
 <20190619081227.GL3419@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA2307501A252E40B@us01wembx1.internal.synopsys.com>
 <20190620075224.GT3419@hirez.programming.kicks-ass.net>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <9192bd26-5f34-dcbf-8552-2f474866a31e@synopsys.com>
Date: Thu, 20 Jun 2019 13:49:48 -0700
MIME-Version: 1.0
In-Reply-To: <20190620075224.GT3419@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jason Baron <jbaron@akamai.com>, Paolo Bonzini <pbonzini@redhat.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Message-ID: <20190620204948.0wwEcFEWEU0oJGp8kRIOnv7gOnwKoWklFPAHUQiFSn8@z>

On 6/20/19 12:52 AM, Peter Zijlstra wrote:
> 
> With everything little endian, everything seems just fine. If you load
> the first 2 byte at offset 0, you get the first 2 bytes of the
> instruction.

It has to do with the instruction encoding scheme and what part of instruction has
the major opcode/subopcode etc. For a canonical 4 byte instruction they happen to
be in the upper 16 bits (for some hardware efficiency reasons unknown to me). So
when a 2 byte insn follows a 4 byte, a 4 byte fetch already tells it what the 2nd
instruction opcode is and whether it is a 2, 4, 6 or 8 byte insn.


> 
> If OTOH your arch big endian, and you were to load the first two bytes
> at offset 0, you get the top two.
> 
> So this middle endian scheme, only seems to make sense if you're
> otherwise big endian.

Insn encoding is always middl eendina - irrespective of endianness.

> But AFAICT ARC is bi-endian and the jump-label
> patch under condsideration is explicitly !CPU_ENDIAN_BE32 -- which
> suggests the instruction stream is sensitive to the endian selection.

Nope they are not directly related. Likely the difference is when we patch the
instruction to memory it is written as data so might need some endian swap. Not
really rocket science. Perhaps it saves some testing effort etc.
Also we don't seem to have any customers interested in BE these days.

> Anyway, I was just 'surprised' at seeing middle endian mentioned,
> curiosity killed the cat and all that :-)

Curiosity may certainly kill cats, but on lkml curiosity is almost always a good
thing both for the enquirer and enquiree ;-)
