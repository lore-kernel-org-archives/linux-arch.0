From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [RFC PATCH v2 4/6] arm64: signal: Allocate extra sigcontext
 space as needed
Date: Tue, 6 Jun 2017 14:58:18 +0100
Message-ID: <20170606135815.GG30160@e103592.cambridge.arm.com>
References: <1492016239-19511-1-git-send-email-Dave.Martin@arm.com>
 <1492016495-19689-1-git-send-email-Dave.Martin@arm.com>
 <1492016495-19689-4-git-send-email-Dave.Martin@arm.com>
 <20170512165724.GB8387@e104818-lin.cambridge.arm.com>
 <20170515132442.GB3559@e103592.cambridge.arm.com>
 <20170523113019.GB5948@e104818-lin.cambridge.arm.com>
 <20170526113729.GO3559@e103592.cambridge.arm.com>
 <20170605141744.GB9163@e104818-lin.cambridge.arm.com>
 <20170606113739.GF30160@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751390AbdFFN6W (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jun 2017 09:58:22 -0400
Content-Disposition: inline
In-Reply-To: <20170606113739.GF30160@e103592.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org

On Tue, Jun 06, 2017 at 12:37:53PM +0100, Dave Martin wrote:
> On Mon, Jun 05, 2017 at 03:17:44PM +0100, Catalin Marinas wrote:

[...]

[extra_context.size]

> > I'd rather have the time size_t or __u64 to avoid implicit padding.
> 
> Sure, it can be a u64.  I wanted to avoid the suggestion that the frame
> should be that large, but 32 bits already allows it to be crazy large
> anyway, so I don't think making it 32-bit helps.

Actually, there is still implicit padding even with u64, since the total
size is 16 bytes + sizeof(extra_context.size).

Since u64 is much bigger then we'd ever want, and to avoid introducing
new bugs, do you object to keeping size as u32 and adding explicit
padding instead?

Cheers
---Dave
