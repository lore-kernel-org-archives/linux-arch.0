Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:35645 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752009AbeEODFW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 23:05:22 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH 06/11] powerpc: Remove unused task argument from prctl functions
In-Reply-To: <1526318067-4964-7-git-send-email-Dave.Martin@arm.com>
References: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com> <1526318067-4964-7-git-send-email-Dave.Martin@arm.com>
Date: Tue, 15 May 2018 13:05:21 +1000
Message-ID: <87in7ppqj2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Message-ID: <20180515030521.CJubwIGbxfWTuQL4EGf9-SkMGNhIAMjIOwq22A3ixGw@z>

Dave Martin <Dave.Martin@arm.com> writes:

> Some powerpc-specific prctl backends take a task argument that is
> redundant, since the only thing ever passed is "current".
>
> This patch gets rid of the redundant arguments.
>
> No functional change.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/processor.h | 16 ++++++++--------
>  arch/powerpc/kernel/process.c        | 30 +++++++++++++++---------------
>  kernel/sys.c                         | 12 ++++++------
>  3 files changed, 29 insertions(+), 29 deletions(-)

This looks fine. I'm happy for it to get tested in linux-next to shake
out anything subtle.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
