Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52727 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752175AbdLMNEj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Dec 2017 08:04:39 -0500
Date: Wed, 13 Dec 2017 14:03:16 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [PATCH 2/2] mmap.2: MAP_FIXED updated documentation
Message-ID: <20171213130316.GD11493@rei>
References: <20171213092550.2774-1-mhocko@kernel.org>
 <20171213093110.3550-1-mhocko@kernel.org>
 <20171213093110.3550-2-mhocko@kernel.org>
 <20171213125540.GA18897@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171213125540.GA18897@amd>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Michal Hocko <mhocko@kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>, linux-api@vger.kernel.org, Khalid Aziz <khalid.aziz@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Florian Weimer <fweimer@redhat.com>, John Hubbard <jhubbard@nvidia.com>, Matthew Wilcox <willy@infradead.org>, Jann Horn <jannh@google.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Michal Hocko <mhocko@suse.com>
Message-ID: <20171213130316.y2E5_kvrOSqvEkxq5ckIWC2zIx-zIyGow0Mmm3Gek0s@z>

Hi!
> Pretty map everyone agreed MAP_FIXED_SAFE was a bad
> name. MAP_FIXED_NOREPLACE (IIRC) was best replacement.

For what it's worth I do agree here.

-- 
Cyril Hrubis
chrubis@suse.cz
