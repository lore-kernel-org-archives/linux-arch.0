Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail02.prevas.se ([62.95.78.10]:29256 "EHLO mail02.prevas.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751172AbdK2PTu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Nov 2017 10:19:50 -0500
Subject: Re: [PATCH 0/2] mm: introduce MAP_FIXED_SAFE
References: <20171129144219.22867-1-mhocko@kernel.org>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <b154b794-7a8b-995e-0954-9234b9446b31@prevas.dk>
Date: Wed, 29 Nov 2017 16:13:53 +0100
MIME-Version: 1.0
In-Reply-To: <20171129144219.22867-1-mhocko@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>, linux-api@vger.kernel.org
Cc: Khalid Aziz <khalid.aziz@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Florian Weimer <fweimer@redhat.com>, John Hubbard <jhubbard@nvidia.com>, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Joel Stanley <joel@jms.id.au>, Kees Cook <keescook@chromium.org>, Michal Hocko <mhocko@suse.com>
Message-ID: <20171129151353.ICKQm-FVtE_6ldUEwXG7Iia2F_TfSxw9ETfmauzIBiQ@z>

On 2017-11-29 15:42, Michal Hocko wrote:
> 
> The first patch introduced MAP_FIXED_SAFE which enforces the given
> address but unlike MAP_FIXED it fails with ENOMEM if the given range
> conflicts with an existing one.

[s/ENOMEM/EEXIST/, as it seems you also did in the actual patch and
changelog]

>The flag is introduced as a completely
> new one rather than a MAP_FIXED extension because of the backward
> compatibility. We really want a never-clobber semantic even on older
> kernels which do not recognize the flag. Unfortunately mmap sucks wrt.
> flags evaluation because we do not EINVAL on unknown flags. On those
> kernels we would simply use the traditional hint based semantic so the
> caller can still get a different address (which sucks) but at least not
> silently corrupt an existing mapping. I do not see a good way around
> that.

I think it would be nice if this rationale was in the 1/2 changelog,
along with the hint about what userspace that wants to be compatible
with old kernels will have to do (namely, check that it got what it
requested) - which I see you did put in the man page.

-- 
Rasmus Villemoes
Software Developer
Prevas A/S
Hedeager 3
DK-8200 Aarhus N
+45 51210274
rasmus.villemoes@prevas.dk
www.prevas.dk
