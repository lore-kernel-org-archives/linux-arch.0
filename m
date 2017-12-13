From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 2/2] mmap.2: MAP_FIXED updated documentation
Date: Wed, 13 Dec 2017 14:04:58 +0100
Message-ID: <20171213130458.GI25185@dhcp22.suse.cz>
References: <20171213092550.2774-1-mhocko@kernel.org>
 <20171213093110.3550-1-mhocko@kernel.org>
 <20171213093110.3550-2-mhocko@kernel.org>
 <20171213125540.GA18897@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52773 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752847AbdLMNFA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Dec 2017 08:05:00 -0500
Content-Disposition: inline
In-Reply-To: <20171213125540.GA18897@amd>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>, linux-api@vger.kernel.org, Khalid Aziz <khalid.aziz@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Florian Weimer <fweimer@redhat.com>, John Hubbard <jhubbard@nvidia.com>, Matthew Wilcox <willy@infradead.org>, Jann Horn <jannh@google.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Cyril Hrubis <chrubis@suse.cz>

On Wed 13-12-17 13:55:40, Pavel Machek wrote:
> On Wed 2017-12-13 10:31:10, Michal Hocko wrote:
> > From: John Hubbard <jhubbard@nvidia.com>
> > 
> >     -- Expand the documentation to discuss the hazards in
> >        enough detail to allow avoiding them.
> > 
> >     -- Mention the upcoming MAP_FIXED_SAFE flag.
> 
> Pretty map everyone agreed MAP_FIXED_SAFE was a bad
> name. MAP_FIXED_NOREPLACE (IIRC) was best replacement.

Please read http://lkml.kernel.org/r/20171213092550.2774-1-mhocko@kernel.org
-- 
Michal Hocko
SUSE Labs
