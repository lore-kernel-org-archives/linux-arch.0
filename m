Return-Path: <SRS0=AQMQ=AK=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731246AbgF2TNB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 15:13:01 -0400
Subject: Re: [PATCH v3 0/2] prctl.2 man page updates for Linux 5.6
References: <1593020162-9365-1-git-send-email-Dave.Martin@arm.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <c17e330c-69f7-da7a-feae-cb8b8f5d7ea0@gmail.com>
Date: Mon, 29 Jun 2020 13:52:24 +0200
MIME-Version: 1.0
In-Reply-To: <1593020162-9365-1-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: mtk.manpages@gmail.com, linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <20200629115224.bdSBB1yO5UfoP2DRTH3ShsPd21EZqxWOn8XrDkgVu-M@z>

Hi Dave,

On 6/24/20 7:36 PM, Dave Martin wrote:
> A bunch of updates to the prctl(2) man page to fill in missing
> prctls (mostly) up to Linux 5.6 (along with a few other tweaks and
> fixes).
> 
> Patches from the v2 series [1] that have been applied or rejected
> already have been dropped.
> 
> All that remain here now are the SVE and tagged address ABI controls
> for arm64.
> 
> 
> 
> [1] https://lore.kernel.org/linux-man/1590614258-24728-1-git-send-email-Dave.Martin@arm.com/
> 
> 
> Dave Martin (2):
>   prctl.2: Add SVE prctls (arm64)
>   prctl.2: Add tagged address ABI control prctls (arm64)
> 
>  man2/prctl.2 | 331 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 331 insertions(+)
Thanks. I've pushed these changes to master now.

Cheers,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
