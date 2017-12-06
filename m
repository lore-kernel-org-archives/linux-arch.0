Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:32949 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752197AbdLFEuL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 Dec 2017 23:50:11 -0500
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 0/2] mm: introduce MAP_FIXED_SAFE
In-Reply-To: <20171130065835.dbw4ajh5q5whikhf@dhcp22.suse.cz>
References: <20171129144219.22867-1-mhocko@kernel.org> <CAGXu5jLa=b2HhjWXXTQunaZuz11qUhm5aNXHpS26jVqb=G-gfw@mail.gmail.com> <20171130065835.dbw4ajh5q5whikhf@dhcp22.suse.cz>
Date: Wed, 06 Dec 2017 15:50:09 +1100
Message-ID: <87zi6we9z2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>, Kees Cook <keescook@chromium.org>
Cc: Linux API <linux-api@vger.kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrea Arcangeli <aarcange@redhat.com>, Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Florian Weimer <fweimer@redhat.com>, John Hubbard <jhubbard@nvidia.com>, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Joel Stanley <joel@jms.id.au>
Message-ID: <20171206045009.Lv54yh5k3dmKBJwC4V_HqknMiS89ZOedNTBGGU9M-ug@z>

Michal Hocko <mhocko@kernel.org> writes:

> On Wed 29-11-17 14:25:36, Kees Cook wrote:
>> On Wed, Nov 29, 2017 at 6:42 AM, Michal Hocko <mhocko@kernel.org> wrote:
>> > The first patch introduced MAP_FIXED_SAFE which enforces the given
>> > address but unlike MAP_FIXED it fails with ENOMEM if the given range
>> > conflicts with an existing one. The flag is introduced as a completely
>> 
>> I still think this name should be better. "SAFE" doesn't say what it's
>> safe from...

Yes exactly.

> It is safe in a sense it doesn't perform any address space dangerous
> operations. mmap is _inherently_ about the address space so the context
> should be kind of clear.

So now you have to define what "dangerous" means.

>> MAP_FIXED_UNIQUE
>> MAP_FIXED_ONCE
>> MAP_FIXED_FRESH
>
> Well, I can open a poll for the best name, but none of those you are
> proposing sound much better to me. Yeah, naming sucks...

I think Kees and I both previously suggested MAP_NO_CLOBBER for the
modifier.

So the obvious option for this would be MAP_FIXED_NO_CLOBBER.

Which is a bit longer sure, but says more or less exactly what it does.

cheers
