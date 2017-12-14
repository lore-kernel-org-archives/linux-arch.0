Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33127 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751035AbdLNHHV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Dec 2017 02:07:21 -0500
Date: Thu, 14 Dec 2017 08:07:18 +0100
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 2/2] mmap.2: MAP_FIXED updated documentation
Message-ID: <20171214070718.GA16951@dhcp22.suse.cz>
References: <20171213092550.2774-1-mhocko@kernel.org>
 <20171213093110.3550-1-mhocko@kernel.org>
 <20171213093110.3550-2-mhocko@kernel.org>
 <20171213125540.GA18897@amd>
 <20171213130458.GI25185@dhcp22.suse.cz>
 <20171213130900.GA19932@amd>
 <20171213131640.GJ25185@dhcp22.suse.cz>
 <20171213132105.GA20517@amd>
 <20171213144050.GG11493@rei>
 <CAGXu5jLqE6cUxk-Girx6PG7upEzz8jmu1OH_3LVC26iJc2vTxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLqE6cUxk-Girx6PG7upEzz8jmu1OH_3LVC26iJc2vTxQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Cyril Hrubis <chrubis@suse.cz>, Pavel Machek <pavel@ucw.cz>, Michael Kerrisk <mtk.manpages@gmail.com>, Linux API <linux-api@vger.kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrea Arcangeli <aarcange@redhat.com>, Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Florian Weimer <fweimer@redhat.com>, John Hubbard <jhubbard@nvidia.com>, Matthew Wilcox <willy@infradead.org>, Jann Horn <jannh@google.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>
Message-ID: <20171214070718.Srt-ara1PAZTA0P0H-0KFAYLR0JS7xBs--KuC6g4PDk@z>

On Wed 13-12-17 15:19:00, Kees Cook wrote:
> On Wed, Dec 13, 2017 at 6:40 AM, Cyril Hrubis <chrubis@suse.cz> wrote:
> > Hi!
> >> You selected stupid name for a flag. Everyone and their dog agrees
> >> with that. There's even consensus on better name (and everyone agrees
> >> it is better than .._SAFE). Of course, we could have debate if it is
> >> NOREPLACE or NOREMOVE or ... and that would be bikeshed. This was just
> >> poor naming on your part.
> >
> > Well while everybody agrees that the name is so bad that basically
> > anything else would be better, there does not seem to be consensus on
> > which one to pick. I do understand that this frustrating and fruitless.
> 
> Based on the earlier threads where I tried to end the bikeshedding, it
> seemed like MAP_FIXED_NOREPLACE was the least bad option.
> 
> > So what do we do now, roll a dice to choose new name?
> >
> > Or do we ask BFDL[1] to choose the name?
> 
> I'd like to hear feedback from Michael Kerrisk, as he's had to deal
> with these kinds of choices in the past. I'm fine to ask Linus too. I
> just want to get past the name since the feature is quite valuable.
> 
> And if Michal doesn't want to touch this patch any more, I'm happy to
> do the search/replace/resend. :P

I think Andrew can do the s@MAP_FIXED_SAFE@MAP_$FOO@ when adding the
patch to the mmotm tree. The reason why I refuse to repost is that a)
functionality doesn't really need a further rework (at least not based
on the review feedback) and b) I do not really see any large consensus
here. People claim to like this or that more but nobody (except of you
Kees) was willing to put their name under their preference in a form of
Acked-by. And that worries me, because generating "better" names sounds
too easy to allow a forward progress.
-- 
Michal Hocko
SUSE Labs
