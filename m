Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754395AbdLFKCe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 6 Dec 2017 05:02:34 -0500
Date: Wed, 6 Dec 2017 11:01:18 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [PATCH v2] mmap.2: MAP_FIXED updated documentation
Message-ID: <20171206100118.GA13979@rei>
References: <20171204021411.4786-1-jhubbard@nvidia.com>
 <20171204105549.GA31332@rei>
 <efb6eae4-7f30-42c3-0efe-0ab5fbf0fdb4@nvidia.com>
 <20171205070510.aojohhvixijk3i27@dhcp22.suse.cz>
 <2cff594a-b481-269d-dd91-ff2cc2f4100a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cff594a-b481-269d-dd91-ff2cc2f4100a@nvidia.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Michal Hocko <mhocko@kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>, linux-man <linux-man@vger.kernel.org>, linux-api@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Jann Horn <jannh@google.com>, Matthew Wilcox <willy@infradead.org>
Message-ID: <20171206100118.RFLQ89evsSvAe0h7sQ7ZW0foshTe3wk8_LcBH-enx54@z>

Hi!
> (It does seem unfortunate that the man page cannot help the programmer
> actually write correct code here. He or she is forced to read the kernel
> implementation, in order to figure out the true alignment rules. I was
> hoping we could avoid that.)

It would be nice if we had this information exported somehere so that we
do not have to rely on per-architecture ifdefs.

What about adding MapAligment or something similar to the /proc/meminfo?

-- 
Cyril Hrubis
chrubis@suse.cz
