From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 1/1] bug: fix problem including <linux.bug.h> from linux/kernel.h
Date: Wed, 24 May 2017 15:37:59 +0200
Message-ID: <CAKwiHFgm2AmSmcWPO+-apH+7SW9Mjh_-jRUNepdx5FUiWukGRQ@mail.gmail.com>
References: <20170524132107.6919-1-abbotti@mev.co.uk> <20170524132107.6919-2-abbotti@mev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:36104 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758294AbdEXNiB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2017 09:38:01 -0400
Received: by mail-ua0-f181.google.com with SMTP id j17so96870150uag.3
        for <linux-arch@vger.kernel.org>; Wed, 24 May 2017 06:38:01 -0700 (PDT)
In-Reply-To: <20170524132107.6919-2-abbotti@mev.co.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ian Abbott <abbotti@mev.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Michal Nazarewicz <mina86@mina86.com>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Borislav Petkov <bp@suse.de>, Johannes Berg <johannes.berg@intel.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Potapenko <glider@google.com>

On 24 May 2017 at 15:21, Ian Abbott <abbotti@mev.co.uk> wrote:
> If "include/linux/kernel.h" includes <linux/bug.h>, a circular
> dependency is introduced

Then don't. Can't we just create linux/build_bug.h and have that
contain the BUILD_BUG related macros - they're really completely
unrelated to all the asm-cruft bug.h needs to know about. build_bug.h
can then include compiler.h and not much else to figure out how it may
implement its macros. Then kernel.h can include build_bug.h, and we
don't force each and every translation unit to include bug.h and
everything that then pulls in. We just got rid of a lot of header
bloat, let's try to keep it that way.

Rasmus
