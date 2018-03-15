From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 2/4] ioremap: Implement TLB_INV before huge mapping
Date: Thu, 15 Mar 2018 15:16:45 +0000
Message-ID: <20180315151645.fsgcywyawvtiwx52@lakrids.cambridge.arm.com>
References: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
 <1521117906-20107-3-git-send-email-cpandya@codeaurora.org>
 <20180315131316.fd5ftqwgdb5bf5we@lakrids.cambridge.arm.com>
 <839387ee-e1c2-cc71-c06a-7bc2d0eda73d@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <839387ee-e1c2-cc71-c06a-7bc2d0eda73d@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 15, 2018 at 06:55:32PM +0530, Chintan Pandya wrote:
> On 3/15/2018 6:43 PM, Mark Rutland wrote:
> > On Thu, Mar 15, 2018 at 06:15:04PM +0530, Chintan Pandya wrote:
> > > Huge mapping changes PMD/PUD which could have
> > > valid previous entries. This requires proper
> > > TLB maintanance on some architectures, like
> > > ARM64.
> > 
> > Just to check, I take it that you mean we could have a valid table
> > entry, but all the entries in that next level table must be invalid,
> > right?
> 
> That was my assumption but my assumption can be wrong if any VA gets
> block mapping for 1G directly (instead of the 2M cases we discussed
> so far), then this would go for a toss.

Ok. Just considering the 4K -> 2M case, is that an assumption, or a
guarantee?

Thanks,
Mark.
