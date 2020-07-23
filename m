Return-Path: <SRS0=uZ41=BC=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgGWSsS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 14:48:18 -0400
Date: Thu, 23 Jul 2020 20:47:59 +0200
From: peterz@infradead.org
Subject: Re: [PATCH v3 5/6] powerpc/pseries: implement paravirt qspinlocks
 for SPLPAR
Message-ID: <20200723184759.GS119549@hirez.programming.kicks-ass.net>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <20200706043540.1563616-6-npiggin@gmail.com>
 <874kqhvu1v.fsf@mpe.ellerman.id.au>
 <8265d782-4e50-a9b2-a908-0cb588ffa09c@redhat.com>
 <20200723140011.GR5523@worktop.programming.kicks-ass.net>
 <845de183-56f5-2958-3159-faa131d46401@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <845de183-56f5-2958-3159-faa131d46401@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Anton Blanchard <anton@ozlabs.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20200723184759.O6kBKNW75xW8VOIfUTA2i_8j0cJb7dQs1TlqTH8dbgA@z>

On Thu, Jul 23, 2020 at 02:32:36PM -0400, Waiman Long wrote:
> BTW, do you have any comment on my v2 lock holder cpu info qspinlock patch?
> I will have to update the patch to fix the reported 0-day test problem, but
> I want to collect other feedback before sending out v3.

I want to say I hate it all, it adds instructions to a path we spend an
aweful lot of time optimizing without really getting anything back for
it.

Will, how do you feel about it?
