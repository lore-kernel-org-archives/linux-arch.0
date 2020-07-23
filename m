Return-Path: <SRS0=uZ41=BC=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgGWOA0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 10:00:26 -0400
Date: Thu, 23 Jul 2020 16:00:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 5/6] powerpc/pseries: implement paravirt qspinlocks
 for SPLPAR
Message-ID: <20200723140011.GR5523@worktop.programming.kicks-ass.net>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <20200706043540.1563616-6-npiggin@gmail.com>
 <874kqhvu1v.fsf@mpe.ellerman.id.au>
 <8265d782-4e50-a9b2-a908-0cb588ffa09c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8265d782-4e50-a9b2-a908-0cb588ffa09c@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Anton Blanchard <anton@ozlabs.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20200723140011.vgaAdip2fiDpBBGAaYHPMyeKjN5p5JiToBu6mHB07zo@z>

On Thu, Jul 09, 2020 at 12:06:13PM -0400, Waiman Long wrote:
> We don't really need to do a pv_spinlocks_init() if pv_kick() isn't
> supported.

Waiman, if you cannot explain how not having kick is a sane thing, what
are you saying here?
