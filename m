From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/2] io: prevent compiler reordering on the default
 readX() implementation
Date: Tue, 3 Apr 2018 13:13:30 +0200
Message-ID: <CAK8P3a3fZx42sQY41Pf+Q3fMNrP2FgXvvntnrLkQXbAezOQjEw@mail.gmail.com>
References: <1522425494-2916-1-git-send-email-okaya@codeaurora.org>
 <1522425494-2916-2-git-send-email-okaya@codeaurora.org> <20180403104925.fuyajja6tyanlna4@lakrids.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180403104925.fuyajja6tyanlna4@lakrids.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>, sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Apr 3, 2018 at 12:49 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Fri, Mar 30, 2018 at 11:58:13AM -0400, Sinan Kaya wrote:
>> The default implementation of mapping readX() to __raw_readX() is wrong.
>> readX() has stronger ordering semantics. Compiler is allowed to reorder
>> __raw_readX().
>
> Could you please specify what the compiler is potentially reordering
> __raw_readX() against, and why this would be wrong?
>
> e.g. do we care about prior normal memory accesses, subsequent normal
> memory accesses, and/or other IO accesses?
>
> I assume that the asm-generic __raw_{read,write}X() implementations are
> all ordered w.r.t. each other (at least for a specific device).

I think that is correct: the compiler won't reorder those because of the
'volatile' pointer dereference, but it can reorder access to a normal
pointer against a __raw_readl()/__raw_writel(), which breaks the scenario
of using writel to trigger a DMA, or using a readl to see if a DMA has
completed.

The question is whether we should use a stronger barrier such
as rmb() amd wmb() here rather than a simple compiler barrier.

I would assume that on complex architectures with write buffers and
out-of-order prefetching, those are required, while on architectures
without those features, the barriers are cheap.

      Arnd
