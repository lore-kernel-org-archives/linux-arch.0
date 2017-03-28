Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34600 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754508AbdC1IUa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Mar 2017 04:20:30 -0400
Received: by mail-pg0-f41.google.com with SMTP id 21so65768334pgg.1
        for <linux-arch@vger.kernel.org>; Tue, 28 Mar 2017 01:20:29 -0700 (PDT)
Date: Tue, 28 Mar 2017 01:20:16 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH] mm: fix section name for .data..ro_after_init
Message-ID: <20170328011951.33dc329c@cakuba.lan>
In-Reply-To: <20170327192213.GA129375@beast>
References: <20170327192213.GA129375@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Chris Metcalf <cmetcalf@mellanox.com>, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Eddie Kovsky <ewk@edkovsky.org>, linux-kernel@vger.kernel.org
Message-ID: <20170328082016.Y6uq7M2KZeN8_5Ztg_OH5ETGRmbz2rgwZOsD8fzlQO4@z>

On Mon, 27 Mar 2017 12:22:13 -0700, Kees Cook wrote:
> A section name for .data..ro_after_init was added by both:
> 
>     commit d07a980c1b8d ("s390: add proper __ro_after_init support")
> 
> and
> 
>     commit d7c19b066dcf ("mm: kmemleak: scan .data.ro_after_init")
> 
> The latter adds incorrect wrapping around the existing s390 section,
> and came later. I'd prefer the s390 naming, so this moves the
> s390-specific name up to the asm-generic/sections.h and renames the
> section as used by kmemleak (and in the future, kernel/extable.c).
> 
> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Eddie Kovsky <ewk@edkovsky.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
