Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32816 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfH3Urb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Aug 2019 16:47:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so309623pfl.0
        for <linux-arch@vger.kernel.org>; Fri, 30 Aug 2019 13:47:30 -0700 (PDT)
Date: Fri, 30 Aug 2019 13:47:28 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] asm-generic: add unlikely to default BUG_ON(x)
Message-ID: <201908301347.60905D1675@keescook>
References: <20190828210934.17711-1-efremov@linux.com>
 <CAK8P3a3T3r3b2uW977HiuMi0uYKs4V_d4e=PDnkWDpqs+wrLww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3T3r3b2uW977HiuMi0uYKs4V_d4e=PDnkWDpqs+wrLww@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Denis Efremov <efremov@linux.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20190830204728.-G2AEutFaBmLmafDwcIPyZwzd84kp3MKyT2QSYLugho@z>

On Fri, Aug 30, 2019 at 10:08:49PM +0200, Arnd Bergmann wrote:
> On Wed, Aug 28, 2019 at 11:09 PM Denis Efremov <efremov@linux.com> wrote:
> >
> > Add unlikely to default BUG_ON(x) in !CONFIG_BUG. It makes
> > the define consistent with BUG_ON(x) in CONFIG_BUG.
> >
> > Signed-off-by: Denis Efremov <efremov@linux.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: <linux-arch@vger.kernel.org>
> 
> This makes sense, I've applied it to the asm-generic tree for now.
> 
> Two concerns though:
> 
> - adding unlikely() can cause new (usually false-postive) compile time
>   warnings to show up in random configurations, so we'll have to see what
>   the build bots think
> 
> - Kees Cook has recently sent a series for asm/bug.h that was merged by
>   Andrew Morton. If there are is a conflict with your patch, it may be better
>   to merge both through the same tree, either linux-mm or asm-generic.

FWIW, this patch looks sensible to me. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
