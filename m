Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:56498 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030834AbdADN6X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jan 2017 08:58:23 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC, PATCHv2 29/29] mm, x86: introduce RLIMIT_VADDR
Date: Wed, 04 Jan 2017 14:55:41 +0100
Message-ID: <5530270.v1BLsanhbo@wuerfel>
In-Reply-To: <CALCETrXmdAnbgjsxw=qTbP2PhVCzE8v3y5XMt8DVa4P9DowsGA@mail.gmail.com>
References: <20161227015413.187403-1-kirill.shutemov@linux.intel.com> <21511994.eBlbEPoKOz@wuerfel> <CALCETrXmdAnbgjsxw=qTbP2PhVCzE8v3y5XMt8DVa4P9DowsGA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Andy Lutomirski <luto@amacapital.net>, linux-arch <linux-arch@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, X86 ML <x86@kernel.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20170104135541.3_f5_DbBlhVXGted6jKHjtjoCtUueJeuqwuKkWY0hCc@z>

On Tuesday, January 3, 2017 2:09:16 PM CET Andy Lutomirski wrote:
> >
> >> When
> >> ADDR_LIMIT_EXPLICIT is in effect, prctl can set a 64-bit numeric
> >> limit.  If ADDR_LIMIT_EXPLICIT is cleared, the prctl value stops being
> >> settable and reading it via prctl returns whatever is implied by the
> >> other personality bits.
> >
> > I don't see anything wrong with it, but I'm a bit confused now
> > what this would be good for, compared to using just prctl.
> >
> > Is this about setuid clearing the personality but not the prctl,
> > or something else?
> 
> It's to avid ambiguity as to what happens if you set ADDR_LIMIT_32BIT
> and use the prctl.  ISTM it would be nice for the semantics to be
> fully defined in all cases.
> 

Ok, got it.

	Arnd
