Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751645AbdK3G6j (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Nov 2017 01:58:39 -0500
Date: Thu, 30 Nov 2017 07:58:35 +0100
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 0/2] mm: introduce MAP_FIXED_SAFE
Message-ID: <20171130065835.dbw4ajh5q5whikhf@dhcp22.suse.cz>
References: <20171129144219.22867-1-mhocko@kernel.org>
 <CAGXu5jLa=b2HhjWXXTQunaZuz11qUhm5aNXHpS26jVqb=G-gfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLa=b2HhjWXXTQunaZuz11qUhm5aNXHpS26jVqb=G-gfw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Linux API <linux-api@vger.kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrea Arcangeli <aarcange@redhat.com>, Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Florian Weimer <fweimer@redhat.com>, John Hubbard <jhubbard@nvidia.com>, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Joel Stanley <joel@jms.id.au>
Message-ID: <20171130065835.-Yy2jIOWyHHn5D75IudjvlJ8yG1Sxiuq7qLjg_7OMlc@z>

On Wed 29-11-17 14:25:36, Kees Cook wrote:
> On Wed, Nov 29, 2017 at 6:42 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > The first patch introduced MAP_FIXED_SAFE which enforces the given
> > address but unlike MAP_FIXED it fails with ENOMEM if the given range
> > conflicts with an existing one. The flag is introduced as a completely
> 
> I still think this name should be better. "SAFE" doesn't say what it's
> safe from...

It is safe in a sense it doesn't perform any address space dangerous
operations. mmap is _inherently_ about the address space so the context
should be kind of clear.

> MAP_FIXED_UNIQUE
> MAP_FIXED_ONCE
> MAP_FIXED_FRESH

Well, I can open a poll for the best name, but none of those you are
proposing sound much better to me. Yeah, naming sucks...
-- 
Michal Hocko
SUSE Labs
