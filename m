Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:38000 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752217AbdK2WMr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Nov 2017 17:12:47 -0500
Received: by mail-vk0-f52.google.com with SMTP id l187so2226631vke.5
        for <linux-arch@vger.kernel.org>; Wed, 29 Nov 2017 14:12:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171129144219.22867-1-mhocko@kernel.org>
References: <20171129144219.22867-1-mhocko@kernel.org>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 29 Nov 2017 14:12:45 -0800
Message-ID: <CAGXu5jKxgkar3802JYUqrVF==h99hDH9UUdZSgH9T_-n9y22EA@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: introduce MAP_FIXED_SAFE
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Linux API <linux-api@vger.kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrea Arcangeli <aarcange@redhat.com>, Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Florian Weimer <fweimer@redhat.com>, John Hubbard <jhubbard@nvidia.com>, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Joel Stanley <joel@jms.id.au>, Michal Hocko <mhocko@suse.com>
Message-ID: <20171129221245.-zm8vT4nwn_lkg02XFN-4Wmn0_8ozCUE7BPEa2FdV0Q@z>

On Wed, Nov 29, 2017 at 6:42 AM, Michal Hocko <mhocko@kernel.org> wrote:
> Except we won't export expose the new semantic to the userspace at all.

I'm confused: the changes in patch 1 are explicitly adding
MAP_FIXED_SAFE to the uapi. If it's not supposed to be exposed,
shouldn't it go somewhere else?

-Kees

-- 
Kees Cook
Pixel Security
