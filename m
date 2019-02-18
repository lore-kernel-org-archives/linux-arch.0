From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/4] provide a generic free_initmem implementation
Date: Mon, 18 Feb 2019 10:49:48 +0100
Message-ID: <20190218094948.GA5892@lst.de>
References: <1550159977-8949-1-git-send-email-rppt@linux.ibm.com> <20190214170416.GA32441@lst.de> <20190214183854.GA10795@rapoport-lnx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190214183854.GA10795@rapoport-lnx>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Palmer Dabbelt <palmer@sifive.com>, Richard Kuo <rkuo@codeaurora.org>, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Thu, Feb 14, 2019 at 08:38:55PM +0200, Mike Rapoport wrote:
> On Thu, Feb 14, 2019 at 06:04:16PM +0100, Christoph Hellwig wrote:
> > This look fine to me, but I'm a little worried that as-is this will
> > just create conflicts with my series..
> 
> I'll rebase on top of your patches once they are in. Or I can send both
> series as a single set.
> Preferences? 

So far there wasn't really much a reason to rebase my series, hope
this gets picked up either by Andrew or Al (not sure what the right
place is).  I think for now just rebase your series on top, we can
then figure out how to proceed.
