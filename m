Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43103 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbfH3UJG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Aug 2019 16:09:06 -0400
MIME-Version: 1.0
References: <20190828210934.17711-1-efremov@linux.com>
In-Reply-To: <20190828210934.17711-1-efremov@linux.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 30 Aug 2019 22:08:49 +0200
Message-ID: <CAK8P3a3T3r3b2uW977HiuMi0uYKs4V_d4e=PDnkWDpqs+wrLww@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: add unlikely to default BUG_ON(x)
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Denis Efremov <efremov@linux.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20190830200849.EJN2nQfKUgIVxWHo5ZzvqYp4kbxVmC-4GrY1egohJTQ@z>

On Wed, Aug 28, 2019 at 11:09 PM Denis Efremov <efremov@linux.com> wrote:
>
> Add unlikely to default BUG_ON(x) in !CONFIG_BUG. It makes
> the define consistent with BUG_ON(x) in CONFIG_BUG.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: <linux-arch@vger.kernel.org>

This makes sense, I've applied it to the asm-generic tree for now.

Two concerns though:

- adding unlikely() can cause new (usually false-postive) compile time
  warnings to show up in random configurations, so we'll have to see what
  the build bots think

- Kees Cook has recently sent a series for asm/bug.h that was merged by
  Andrew Morton. If there are is a conflict with your patch, it may be better
  to merge both through the same tree, either linux-mm or asm-generic.

        Arnd
