Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:38495 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeAPVBL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jan 2018 16:01:11 -0500
Received: by mail-ua0-f193.google.com with SMTP id t7so8446740uae.5
        for <linux-arch@vger.kernel.org>; Tue, 16 Jan 2018 13:01:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <151571799008.27429.12325141216769795517.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151571798296.27429.7166552848688034184.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151571799008.27429.12325141216769795517.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 16 Jan 2018 13:01:09 -0800
Message-ID: <CAGXu5jKpJVAccE=Ch1=2Xx8ig-dq592gkorPNjzhQ044ORyAvw@mail.gmail.com>
Subject: Re: [PATCH v2 01/19] Documentation: document array_ptr
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, Mark Rutland <mark.rutland@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kernel-hardening@lists.openwall.com, Peter Zijlstra <peterz@infradead.org>, Jonathan Corbet <corbet@lwn.net>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@linux.intel.com>
Message-ID: <20180116210109.TvAzBU1xbhikL-tGiJEX8QZ9IlqSDb9m41AVZM-S7vY@z>

On Thu, Jan 11, 2018 at 4:46 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> From: Mark Rutland <mark.rutland@arm.com>
>
> Document the rationale and usage of the new array_ptr() helper.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/speculation.txt |  142 +++++++++++++++++++++++++++++++++++++++++
> [...]
> +NULL is returned. Additionally, array_ptr() an out-of-bounds poitner is
> +not propagated to code which is speculatively executed.

I think this meant to say:

Additionally, array_ptr() of an out-of-bounds pointer is
not propagated to code which is speculatively executed.

Other than that:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
