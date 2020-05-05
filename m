Return-Path: <SRS0=wOT8=6T=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:37084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbgEEKz2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 May 2020 06:55:28 -0400
Date: Tue, 5 May 2020 11:55:24 +0100
From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: Adding arch-specific user ABI documentation in linux-man
Message-ID: <20200505105522.GL30377@arm.com>
References: <20200504153214.GH30377@arm.com>
 <32259f3763344500a058a8ca8a3a33d8@bfs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32259f3763344500a058a8ca8a3a33d8@bfs.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Walter Harms <wharms@bfs.de>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-ID: <20200505105524.olxqq9pZYNExvZeYL5gHmOqDE39rLhhW8rA6aBNT4zg@z>

On Tue, May 05, 2020 at 07:45:32AM +0000, Walter Harms wrote:
> Hi Dave,
> you are pointing to an (IMHO) interesting question.
> How to document different CPUs ?
> Given that an operating system should hide the different CPU's using
> CPU specific features should be used sparsely at best.

Agreed!  But there are real situations where cpu specifics can't be
avoided, and having documentation will help people to use those features
correctly.

> the easy part are adds-on like flags for prctrl etc. simply add it to the page.

For prctl, that makes sense (it's a jumble of arch specifics already).

But would it be considered a problem if the ptrace page, say, becomes
80% arch-specific stuff?  That page is cumbersome enough already...

> Other things should go to a cpu specific pages (can of worms). The problem will
> be to keep that small but informative. I have no idea about the level of detail
> (and i have worked with a range of CPUs) that could be interesting for a programmer.
> An of cause every other CPU now needs also a page.

Fair enough.

Cheers
---Dave
