Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from seketeli.net ([94.23.218.202]:46132 "EHLO ms.seketeli.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752752AbcLNKMH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Dec 2016 05:12:07 -0500
From: Dodji Seketeli <dodji@seketeli.org>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from asm
References: <20161201125545.406d092c@roar.ozlabs.ibm.com>
        <1480559754.16599.92.camel@decadent.org.uk>
        <20161201143928.07a08348@roar.ozlabs.ibm.com>
        <6e8cf20b-2d2f-ba1f-e02c-c757d5a25db7@suse.com>
        <20161209133308.0acbb57a@roar.ozlabs.ibm.com>
        <1481296893.4509.135.camel@hellion.org.uk>
        <20161210021529.4a6e684f@roar.ozlabs.ibm.com>
        <86vaus3eld.fsf@seketeli.org>
        <f7c5d50d-8930-7ab1-62bb-8a5d0aead988@suse.com>
        <867f72vqec.fsf@seketeli.org> <20161214091539.GA9000@sepie.suse.cz>
        <86twa6svhi.fsf@seketeli.org>
        <a3cd76cb-48ac-5d86-0a82-ac7b11738813@suse.com>
Date: Wed, 14 Dec 2016 11:02:25 +0100
In-Reply-To: <a3cd76cb-48ac-5d86-0a82-ac7b11738813@suse.com> (Michal Marek's
        message of "Wed, 14 Dec 2016 10:44:07 +0100")
Message-ID: <86y3zirfpq.fsf@seketeli.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Ian Campbell <ijc@hellion.org.uk>, Ben Hutchings <ben@decadent.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20161214100225.ARwJPYDAU-mmL0bxrIjolZjlHU1MaQeY7GqA22NjZWM@z>

Michal Marek <mmarek@suse.com> a écrit:

>> Libabigail does a "whole binary" analysis of types.
>> 
>> So, consider the point of use of the type 'struct s1*'.  Even if 'struct
>> s' is just forward-declared at that point, the declaration of struct s1
>> is "resolved" to its definition.  Even if the definition comes later in
>> the binary.
>
> But there isn't any definition of struct s1 in t1.o. Does abidiff
> "steal" the definition from the other object file? That would be
> legitimate, I'm just curious.

If there is another translation unit in the *same* binary that defines
struct s1, then yes, it's "stolen", as you say.

But if in the entire binary, struct s1 is just declared (not defined),
then it'll compare equal to any struct s1 that is defined in the
*second* binary.

Cheers,

-- 
		Dodji
