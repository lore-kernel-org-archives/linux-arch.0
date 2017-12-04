Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50658 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754108AbdLDK5F (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Dec 2017 05:57:05 -0500
Date: Mon, 4 Dec 2017 11:55:49 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [PATCH v2] mmap.2: MAP_FIXED updated documentation
Message-ID: <20171204105549.GA31332@rei>
References: <20171204021411.4786-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171204021411.4786-1-jhubbard@nvidia.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: john.hubbard@gmail.com
Cc: Michael Kerrisk <mtk.manpages@gmail.com>, linux-man <linux-man@vger.kernel.org>, linux-api@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Jann Horn <jannh@google.com>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, John Hubbard <jhubbard@nvidia.com>
Message-ID: <20171204105549.VaNe9FYjVrEE3Kr4yhsyuUCBcUIT50QWQL2s8qRK9Jc@z>

Hi!
I know that we are not touching the rest of the existing description for
MAP_FIXED however the second sentence in the manual page says that "addr
must be a multiple of the page size." Which however is misleading as
this is not enough on some architectures. Code in the wild seems to
(mis)use SHMLBA for aligment purposes but I'm not sure that we should
advise something like that in the manpages.

So what about something as:

"addr must be suitably aligned, for most architectures multiple of page
size is sufficient, however some may impose additional restrictions for
page mapping addresses."

Which should at least hint the reader that this is architecture specific.

-- 
Cyril Hrubis
chrubis@suse.cz
