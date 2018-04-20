Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:46951 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755655AbeDTQHA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Apr 2018 12:07:00 -0400
MIME-Version: 1.0
In-Reply-To: <20180420143811.9994-21-ebiederm@xmission.com>
References: <87604mhrnb.fsf@xmission.com> <20180420143811.9994-21-ebiederm@xmission.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 20 Apr 2018 09:06:59 -0700
Message-ID: <CAMo8BfLcxvEK4BqteXGGzUNWXS1iRfUtSkO364MjL1URPbpKOQ@mail.gmail.com>
Subject: Re: [REVIEW][PATCH 21/22] signal/xtensa: Consistenly use SIGBUS in do_unaligned_user
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org, stable@vger.kernel.org
Message-ID: <20180420160659.lxq62qzl68a0A2G6Qdl9eKNFe2m3hiFPcxGzV_uzRuQ@z>

On Fri, Apr 20, 2018 at 7:38 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> While working on changing this code to use force_sig_fault I
> discovered that do_unaliged_user is sets si_signo to SIGBUS and passes
> SIGSEGV to force_sig_info.  Which is just b0rked.
>
> The code is reporting a SIGBUS error so replace the SIGSEGV with SIGBUS.
>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> Cc: stable@vger.kernel.org
> Fixes: 5a0015d62668 ("[PATCH] xtensa: Architecture support for Tensilica Xtensa Part 3")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/xtensa/kernel/traps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
