Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46562 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751077AbdLAP1x (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 1 Dec 2017 10:27:53 -0500
Date: Fri, 1 Dec 2017 16:26:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [PATCH 0/2] mm: introduce MAP_FIXED_SAFE
Message-ID: <20171201152640.GA3765@rei>
References: <20171129144219.22867-1-mhocko@kernel.org>
 <CAGXu5jLa=b2HhjWXXTQunaZuz11qUhm5aNXHpS26jVqb=G-gfw@mail.gmail.com>
 <20171130065835.dbw4ajh5q5whikhf@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171130065835.dbw4ajh5q5whikhf@dhcp22.suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Linux API <linux-api@vger.kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrea Arcangeli <aarcange@redhat.com>, Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Florian Weimer <fweimer@redhat.com>, John Hubbard <jhubbard@nvidia.com>, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Joel Stanley <joel@jms.id.au>
Message-ID: <20171201152640.ndHbZU1vN1J60Ao_ZBMe1q4YFis6AxQ3nNxhicuqRhs@z>

Hi!
> > MAP_FIXED_UNIQUE
> > MAP_FIXED_ONCE
> > MAP_FIXED_FRESH
> 
> Well, I can open a poll for the best name, but none of those you are
> proposing sound much better to me. Yeah, naming sucks...

Given that MAP_FIXED replaces the previous mapping MAP_FIXED_NOREPLACE
would probably be a best fit.

-- 
Cyril Hrubis
chrubis@suse.cz
