Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:43927 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727423AbfBRJtu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 Feb 2019 04:49:50 -0500
Date: Mon, 18 Feb 2019 10:49:48 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/4] provide a generic free_initmem implementation
Message-ID: <20190218094948.GA5892@lst.de>
References: <1550159977-8949-1-git-send-email-rppt@linux.ibm.com> <20190214170416.GA32441@lst.de> <20190214183854.GA10795@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214183854.GA10795@rapoport-lnx>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Palmer Dabbelt <palmer@sifive.com>, Richard Kuo <rkuo@codeaurora.org>, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org
Message-ID: <20190218094948.2ZqH5zB1jIRvMYEx_gty5wdXKmpYplhV9E-fC-XwR-w@z>

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
