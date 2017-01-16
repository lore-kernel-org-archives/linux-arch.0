Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35536 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbdAPLfA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Jan 2017 06:35:00 -0500
Received: by mail-wm0-f68.google.com with SMTP id d140so13729979wmd.2
        for <linux-arch@vger.kernel.org>; Mon, 16 Jan 2017 03:34:59 -0800 (PST)
Date: Mon, 16 Jan 2017 11:34:39 +0000
From: Yao Qi <qiyaoltc@gmail.com>
Subject: Re: [RFC PATCH 06/10] arm64/sve: Disallow VL setting for individual
 threads by default
Message-ID: <20170116113439.GF28060@E107787-LIN>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
 <1484220369-23970-7-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1484220369-23970-7-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Alan Hayward <alan.hayward@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, Florian Weimer <fweimer@redhat.com>, Joseph Myers <joseph@codesourcery.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Torvald Riegel <triegel@redhat.com>, gdb@sourceware.org
Message-ID: <20170116113439._P0voEJhw3Wj9_e-8QCGKaGSMtaJKlCrrlC9dkJrjMs@z>

On 17-01-12 11:26:05, Dave Martin wrote:
> General-purpose code in userspace is not expected to work correctly
> if multiple threads are allowed to run concurrently with different
> vector lengths in a single process.
> 
> This patch adds an explicit flag PR_SVE_SET_VL_THREAD to request
> this behaviour.  Without the flag, vector length setting is
> permitted only for a single-threaded process (which matches the
> expected usage model of setting the vector length at process
> startup).

Hi Dave,
PR_SVE_SET_VL_THREAD can be arch-independent, IMO, because prctl
needs a scope.  Looks some of them are system-wide, some of them are
about threads within the same process (like, PR_MPX_ENABLE_MANAGEMENT).
IOW, PR_SVE_SET_VL_THREAD can be general flag, to indicate the scope
of each new ptrcl command is per-thread.

I happen to see PR_SET_FP_MODE in man pages, which is about setting
FP register modes in runtime.  It is a little similar to setting VL in
this patch.  However the doc doesn't mention the effect or the scope
of this command.

-- 
Yao (齐尧)
