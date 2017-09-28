From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [RFC PATCH 1/2] arm64: mm: Use READ_ONCE/WRITE_ONCE when
 accessing page tables
Date: Thu, 28 Sep 2017 14:18:05 -0500
Message-ID: <CAOZdJXXwyFYOAUM5nXC670yqfniiR7GKLrKFqm9-rLjoS_oXTg@mail.gmail.com>
References: <1506527369-19535-1-git-send-email-will.deacon@arm.com> <1506527369-19535-2-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38026 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbdI1TSI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Sep 2017 15:18:08 -0400
In-Reply-To: <1506527369-19535-2-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, paulmck@linux.vnet.ibm.com, kirill.shutemov@linux.intel.com, lkml <linux-kernel@vger.kernel.org>, Yury Norov <ynorov@caviumnetworks.com>, rruigrok@codeaurora.org, linux-arch@vger.kernel.org, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>

On Wed, Sep 27, 2017 at 10:49 AM, Will Deacon <will.deacon@arm.com> wrote:
> This patch consistently uses these macros in the arch
> code, as well as explicitly namespacing pointers to page table entries
> from the entries themselves by using adopting a 'p' suffix for the former
> (as is sometimes used elsewhere in the kernel source).

Would you consider splitting up this patch into two, where the second
patch makes all the cosmetic changes?  That would make the "meatier"
patch easier to back-port and review.
