From: Dodji Seketeli <dodji@seketeli.org>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from asm
Date: Wed, 14 Dec 2016 09:58:03 +0100
Message-ID: <867f72vqec.fsf@seketeli.org>
References: <20161129131922.GA31466@angband.pl>
        <20161129135118.24696-1-kilobyte@angband.pl>
        <CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com>
        <30bb2db4-47bd-0c35-8328-ef032b551f06@suse.com>
        <CA+55aFxOGw57Gm-QiNs13kfy5k=aRrn3+98415V0g73eGc66mg@mail.gmail.com>
        <20161129195721.GI2697@decadent.org.uk>
        <CA+55aFyQko0t8oMZjhnwhWHrmBUyWjGhsnT=oUOU-W7_04xdzw@mail.gmail.com>
        <20161201051852.28dc335f@roar.ozlabs.ibm.com>
        <CA+55aFzMTrLMrr69ipdaKhz+RJhUu3BxB+kg0689qq_470qEcw@mail.gmail.com>
        <1480541581.16599.78.camel@decadent.org.uk>
        <20161201125545.406d092c@roar.ozlabs.ibm.com>
        <1480559754.16599.92.camel@decadent.org.uk>
        <20161201143928.07a08348@roar.ozlabs.ibm.com>
        <6e8cf20b-2d2f-ba1f-e02c-c757d5a25db7@suse.com>
        <20161209133308.0acbb57a@roar.ozlabs.ibm.com>
        <1481296893.4509.135.camel@hellion.org.uk>
        <20161210021529.4a6e684f@roar.ozlabs.ibm.com>
        <86vaus3eld.fsf@seketeli.org>
        <f7c5d50d-8930-7ab1-62bb-8a5d0aead988@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f7c5d50d-8930-7ab1-62bb-8a5d0aead988@suse.com> (Michal Marek's
        message of "Tue, 13 Dec 2016 23:51:00 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Marek <mmarek@suse.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Ian Campbell <ijc@hellion.org.uk>, Ben Hutchings <ben@decadent.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Michal Marek <mmarek@suse.com> a écrit:

[...]

> Does the abidiff tool handle the case when an exported symbol is moved
> between .c files? This is always a mess with genksyms, because the two
> .c files have different includes and thus the type expansion stops at
> different points. So typically the move needs to be reverted as a
> workaround.

Let's consider the function:

  'void foo(struct S*);'

If two ELF binaries contain a definition of that function foo which ELF
symbol is exported, if the type struct S hasn't changed, and if the only
difference between the ELF binaries is that foo was defined in the
translation unit a.c in the first binary and in b.c in the second
binary, then the comparison engine of libabigail (which is the library
that abidiff uses) will consider the declarations of the two foo
functions as being equal -- no matter what include file comes before the
definition point of foo in a.c and b.c.  If it does not, then it's a bug
that ought to be fixed.

If you feel that I haven't understood your question, then I guess a
minimal standalone example (in the form of C source code) that
illustrates your use case could be helpful to me.

Thanks.

-- 
		Dodji
