Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60667 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752749AbdLMOmQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Dec 2017 09:42:16 -0500
Date: Wed, 13 Dec 2017 15:40:50 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [PATCH 2/2] mmap.2: MAP_FIXED updated documentation
Message-ID: <20171213144050.GG11493@rei>
References: <20171213092550.2774-1-mhocko@kernel.org>
 <20171213093110.3550-1-mhocko@kernel.org>
 <20171213093110.3550-2-mhocko@kernel.org>
 <20171213125540.GA18897@amd>
 <20171213130458.GI25185@dhcp22.suse.cz>
 <20171213130900.GA19932@amd>
 <20171213131640.GJ25185@dhcp22.suse.cz>
 <20171213132105.GA20517@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171213132105.GA20517@amd>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Michal Hocko <mhocko@kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>, linux-api@vger.kernel.org, Khalid Aziz <khalid.aziz@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Florian Weimer <fweimer@redhat.com>, John Hubbard <jhubbard@nvidia.com>, Matthew Wilcox <willy@infradead.org>, Jann Horn <jannh@google.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>
Message-ID: <20171213144050.rgAOu_3wUzAaB4qzHLxyjxALgegQ8c7N_vaOlyNMr8E@z>

Hi!
> You selected stupid name for a flag. Everyone and their dog agrees
> with that. There's even consensus on better name (and everyone agrees
> it is better than .._SAFE). Of course, we could have debate if it is
> NOREPLACE or NOREMOVE or ... and that would be bikeshed. This was just
> poor naming on your part.

Well while everybody agrees that the name is so bad that basically
anything else would be better, there does not seem to be consensus on
which one to pick. I do understand that this frustrating and fruitless.

So what do we do now, roll a dice to choose new name?

Or do we ask BFDL[1] to choose the name?

[1] https://en.wikipedia.org/wiki/Benevolent_dictator_for_life

-- 
Cyril Hrubis
chrubis@suse.cz
