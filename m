From: Jon Masters <jcm@redhat.com>
Subject: Re: [RFC PATCH 0/2] Missing READ_ONCE in core and arch-specific
 pgtable code leading to crashes
Date: Tue, 3 Oct 2017 02:36:42 -0400
Message-ID: <95366fe6-e1eb-dd39-6f13-903704b5180f@redhat.com>
References: <1506527369-19535-1-git-send-email-will.deacon@arm.com>
 <9f351432-3c6b-3b06-7b49-bc9a5806aff5@redhat.com>
 <20170929085634.GA14791@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750767AbdJCGgp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Oct 2017 02:36:45 -0400
In-Reply-To: <20170929085634.GA14791@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>, Jon Masters <jcm@redhat.com>
Cc: peterz@infradead.org, paulmck@linux.vnet.ibm.com, kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org, ynorov@caviumnetworks.com, rruigrok@codeaurora.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, catalin.marinas@arm.com, timur@codeaurora.org

On 09/29/2017 04:56 AM, Will Deacon wrote:

> The full fix isn't just cosmetic; it's also addressing the wider problem
> of unannotated racing page table accesses outside of the specific failure
> case we've run into.

Let us know if there are additional tests we should be running on the
Red Hat end. We've got high hundreds of ARM server systems at this
point, including pretty much everything out there.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
