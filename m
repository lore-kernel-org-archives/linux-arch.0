Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:46915 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751174Ab2LWLvc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 23 Dec 2012 06:51:32 -0500
Date: Sun, 23 Dec 2012 11:11:18 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH 0/6] ARM: mm: HugeTLB + THP support.
Message-ID: <20121223111118.GC16237@mudshark.cambridge.arm.com>
References: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
 <50D4671F.1010003@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50D4671F.1010003@free-electrons.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Steve Capper <Steve.Capper@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "aarcange@redhat.com" <aarcange@redhat.com>, "bill4carson@gmail.com" <bill4carson@gmail.com>, "tawfik@marvell.com" <tawfik@marvell.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "cmetcalf@tilera.com" <cmetcalf@tilera.com>, "mhocko@suse.cz" <mhocko@suse.cz>, "maen@marvell.com" <maen@marvell.com>, "hoffman@marvell.com" <hoffman@marvell.com>, "notasas@gmail.com" <notasas@gmail.com>, "kirill@shutemov.name" <kirill@shutemov.name>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "shadi@marvell.com" <shadi@marvell.com>, Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Message-ID: <20121223111118.4C5pV32FB9x-U1tFtydjwSNpvubXI8wnwlenGkvg9L0@z>

On Fri, Dec 21, 2012 at 01:41:51PM +0000, Gregory CLEMENT wrote:
> On 10/18/2012 06:15 PM, Steve Capper wrote:
> > Hello,
> Hi Steve,

Hi Gregory,

> I resurrected this old thread to have some news about this subject.
> We are interested to get this support for the Armada 370/XP based boards.
> 
> I am surprised that there wasn't any feedback on this series. We are
> willing to help this feature being merge in the kernel.
> 
> Testing your series on the board we have could help you?

Whilst testing is always welcome, the thing this code *really* needs is some
proper review, especially for the implementation for 3-level page tables. We
tested pretty extensively on v6, v7 and v7+lpae platforms ourselves but, of
course, if you do uncover an issue then please shout.

Will
