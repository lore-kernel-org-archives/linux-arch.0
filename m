Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from a9-32.smtp-out.amazonses.com ([54.240.9.32]:43830 "EHLO
        a9-32.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727849AbfGKHyn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 11 Jul 2019 03:54:43 -0400
Date: Thu, 11 Jul 2019 07:54:42 +0000
From: Christopher Lameter <cl@linux.com>
Subject: Re: [RFC PATCH] mm: remove quicklist page table caches
In-Reply-To: <20190711030339.20892-1-npiggin@gmail.com>
Message-ID: <0100016be006fbda-65d42038-d656-4d74-8b50-9c800afe4f96-000000@email.amazonses.com>
References: <20190711030339.20892-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org

On Thu, 11 Jul 2019, Nicholas Piggin wrote:

> Remove page table allocator "quicklists". These have been around for a
> long time, but have not got much traction in the last decade and are
> only used on ia64 and sh architectures.

I also think its good to remove this code. Note sure though if IA64
may still have a need of it. But then its not clear that the IA64 arch is
still in use. Is it still maintained?

> Also it might be better to instead make more general improvements to
> page allocator if this is still so slow.

Well yes many have thought so and made attempts to improve the situation
which generally have failed. But even the fast path of the page allocator
seems to bloat more and more. The situation is deteriorating instead of
getting better and as a result lots of subsystems create their own caches
to avoid the page allocator.
