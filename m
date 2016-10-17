From: Mathieu OTHACEHE <m.othacehe@gmail.com>
Subject: Re: [GIT PULL] kbuild changes for v4.9-rc1
Date: Mon, 17 Oct 2016 14:22:34 +0200
Message-ID: <871szfb1x1.fsf@gmail.com>
References: <20161017100130.GA16013@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35908 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932588AbcJQMYm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2016 08:24:42 -0400
In-reply-to: <20161017100130.GA16013@angband.pl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adam Borowski <kilobyte@angband.pl>
Cc: Nicholas Piggin <npiggin@gmail.com>, Omar Sandoval <osandov@osandov.com>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org


> +#include <asm/uaccess.h>
> +#include <asm/uaccess.h>

Included twice.

> +#include <asm/string.h>
> +#include <asm/page.h>
> +#include <asm/checksum.h>
> +
> +#include <asm-generic/asm-prototypes.h>
> +
> +#include <asm/page.h>
> +#include <asm/pgtable.h>
> +#include <asm/special_insns.h>
> +#include <asm/preempt.h>

No <asm/arch_hweight.h> for __sw_hweight32 and __sw_hweight64 ? 
