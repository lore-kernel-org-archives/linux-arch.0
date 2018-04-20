Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb0-f193.google.com ([209.85.213.193]:45952 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbeDTQ1g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Apr 2018 12:27:36 -0400
MIME-Version: 1.0
In-Reply-To: <20180420143811.9994-22-ebiederm@xmission.com>
References: <87604mhrnb.fsf@xmission.com> <20180420143811.9994-22-ebiederm@xmission.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 20 Apr 2018 09:27:35 -0700
Message-ID: <CAMo8Bf+LhSQX=debxSBLzpESb1LojBVdPd+L4x1ax5mBVvvYMA@mail.gmail.com>
Subject: Re: [REVIEW][PATCH 22/22] signal/xtensa: Use force_sig_fault where appropriate
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org
Message-ID: <20180420162735.Vq-Toxh5ex4H9nrD1B8KnzRys-XzQ6o0ZFORiZ5KYk0@z>

On Fri, Apr 20, 2018 at 7:38 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Filling in struct siginfo before calling force_sig_info a tedious and
> error prone process, where once in a great while the wrong fields
> are filled out, and siginfo has been inconsistently cleared.
>
> Simplify this process by using the helper force_sig_fault.  Which
> takes as a parameters all of the information it needs, ensures
> all of the fiddly bits of filling in struct siginfo are done properly
> and then calls force_sig_info.
>
> In short about a 5 line reduction in code for every time force_sig_info
> is called, which makes the calling function clearer.
>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: linux-xtensa@linux-xtensa.org
> Cc: linux-xtensa@linux-xtensa.org
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/xtensa/kernel/traps.c | 10 +---------
>  arch/xtensa/mm/fault.c     | 19 +++++--------------
>  2 files changed, 6 insertions(+), 23 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
