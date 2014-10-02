Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:11720 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951AbaJBQzl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 2 Oct 2014 12:55:41 -0400
Date: Thu, 2 Oct 2014 18:54:30 +0200
From: Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH V4 1/6] mm: Introduce a general RCU get_user_pages_fast.
Message-ID: <20141002165430.GK2342@redhat.com>
References: <1411740233-28038-1-git-send-email-steve.capper@linaro.org>
 <1411740233-28038-2-git-send-email-steve.capper@linaro.org>
 <20141002121902.GA2342@redhat.com>
 <CAPvkgC3VkmctmD9dROqkAEwi-Njm9zQqVx1=Byttr5_n-J7wYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPvkgC3VkmctmD9dROqkAEwi-Njm9zQqVx1=Byttr5_n-J7wYw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>, Gary Robertson <gary.robertson@linaro.org>, Christoffer Dall <christoffer.dall@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Anders Roxell <anders.roxell@linaro.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Dann Frazier <dann.frazier@canonical.com>, Mark Rutland <mark.rutland@arm.com>, Mel Gorman <mgorman@suse.de>, Hugh Dickins <hughd@google.com>
Message-ID: <20141002165430.rBhz-h5Rsw9Q0BoNypxbamUXAYOQHrjyWZnuSKgWbtc@z>

On Thu, Oct 02, 2014 at 11:18:00PM +0700, Steve Capper wrote:
> mm/gup.c was recently created?
> It may even make sense to move the weak version in a future patch?

I think the __weak stuff tends to go in lib, that's probably why it's
there. I don't mind either ways.

> I'm currently on holiday and have very limited access to email, I'd
> appreciate it if someone can keep an eye out for this during the merge
> window if this conflict arises?

No problem, I assume Andrew will merge your patchset first, so I can
resubmit against -mm patching the gup_fast_rcu too.

Thanks,
Andrea
