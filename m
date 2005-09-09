Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <43222038.5010302@linux-m68k.org>
Date: Sat, 10 Sep 2005 01:52:24 +0200
From: Roman Zippel <zippel@linux-m68k.org>
MIME-Version: 1.0
Subject: Re: spinlock-consolidation.patch
References: <20050909121521.12942a8d.akpm@osdl.org>
In-Reply-To: <20050909121521.12942a8d.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

Hi,

Andrew Morton wrote:

>  include/linux/spinlock_api_smp.h     |   57 ++
>  include/linux/spinlock_api_up.h      |   80 +++
>  include/linux/spinlock_types_up.h    |   51 ++
>  include/linux/spinlock_up.h          |   74 +++

These are rather small files and not useful outside of
<linux/spinlock.h>/<linux/spinlock_types.h>. Is it really needed to keep
these separate?

bye, Roman
