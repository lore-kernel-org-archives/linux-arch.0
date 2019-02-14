Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:51880 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732722AbfBNRES (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Feb 2019 12:04:18 -0500
Date: Thu, 14 Feb 2019 18:04:16 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/4] provide a generic free_initmem implementation
Message-ID: <20190214170416.GA32441@lst.de>
References: <1550159977-8949-1-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550159977-8949-1-git-send-email-rppt@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>, Richard Kuo <rkuo@codeaurora.org>, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org
Message-ID: <20190214170416.FLBSpM4ESnKsxQjqdCU6JAlAwZt6CVTlRqVfb8SVLW0@z>

This look fine to me, but I'm a little worried that as-is this will
just create conflicts with my series..
