Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113]:36504 "EHLO
	e06smtp17.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932432AbaLDPYH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Dec 2014 10:24:07 -0500
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Thu, 4 Dec 2014 15:24:06 -0000
Message-ID: <54807C92.1010405@de.ibm.com>
Date: Thu, 04 Dec 2014 16:24:02 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCHv4 0/9] ACCESS_ONCE and non-scalar accesses
References: <1417645821-54731-1-git-send-email-borntraeger@de.ibm.com>
In-Reply-To: <1417645821-54731-1-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org
Message-ID: <20141204152402.JgSNXzryVk8UgdZGXaGgXKPoJ4uOuWJ9QwU5ZNuH7OA@z>

Am 03.12.2014 um 23:30 schrieb Christian Borntraeger:
> As discussed on LKML http://marc.info/?i=54611D86.4040306%40de.ibm.com
> ACCESS_ONCE might fail with specific compiler for non-scalar accesses.
> 
> Here is a set of patches to tackle that problem.
> 
> The first patch introduce READ_ONCE and ASSIGN_ONCE. If the data structure
> is larger than the machine word size memcpy is used and a warning is emitted.
> The next patches fix up all in-tree users of ACCESS_ONCE on non-scalar types.
> The last patch forces ACCESS_ONCE to work only on scalar types. 
> 
> I have cross-compiled the resulting kernel with defconfig and gcc 4.9 for
> microblaze, m68k, alpha, s390,x86_64, i686, sparc, sparc64, mips,
> ia64, arm and arm64.
> 
> Runtime tested on s390x and x86_64. I have also verified that ASSIGN_ONCE works
> as expected with some test changes as there are no user in this patch series.
> 
> Linus, ok for the next merge window?
> 
> Christian Borntraeger (9):
>   kernel: Provide READ_ONCE and ASSIGN_ONCE
>   mm: replace ACCESS_ONCE with READ_ONCE or barriers
>   x86/spinlock: Replace ACCESS_ONCE with READ_ONCE
>   x86/gup: Replace ACCESS_ONCE with READ_ONCE
>   mips/gup: Replace ACCESS_ONCE with READ_ONCE
>   arm64/spinlock: Replace ACCESS_ONCE READ_ONCE
>   arm/spinlock: Replace ACCESS_ONCE with READ_ONCE
>   s390/kvm: REPLACE ACCESS_ONCE with READ_ONCE
>   kernel: tighten rules for ACCESS ONCE
> 
>  arch/arm/include/asm/spinlock.h   |  4 +--
>  arch/arm64/include/asm/spinlock.h |  4 +--
>  arch/mips/mm/gup.c                |  2 +-
>  arch/s390/kvm/gaccess.c           | 14 ++++----
>  arch/x86/include/asm/spinlock.h   |  8 ++---
>  arch/x86/mm/gup.c                 |  2 +-
>  include/linux/compiler.h          | 74 ++++++++++++++++++++++++++++++++++++++-
>  mm/gup.c                          |  2 +-
>  mm/memory.c                       |  2 +-
>  mm/rmap.c                         |  3 +-
>  10 files changed, 95 insertions(+), 20 deletions(-)
> 

FWIW, the code is on

git://git.kernel.org/pub/scm/linux/kernel/git/borntraeger/linux.git linux-next
and
git://git.kernel.org/pub/scm/linux/kernel/git/borntraeger/linux.git ACCESS_ONCE

I rebased the queue against rc3 + the initial patch that triggered the  whole discussion.

Christian

