From: Michal Marek <mmarek@suse.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Tue, 29 Nov 2016 22:23:51 +0100
Message-ID: <04650a4f-8ba7-a44c-6777-68dc413b683d@suse.com>
References: <20161129131922.GA31466@angband.pl>
 <20161129135118.24696-1-kilobyte@angband.pl>
 <CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com>
 <20161129170522.GA3441@angband.pl>
 <CA+55aFxCKgTrh1gS-cMyhBa0QoLW2DL2+DYxOAcA-Bd15H15vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45033 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751917AbcK2VXy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 Nov 2016 16:23:54 -0500
In-Reply-To: <CA+55aFxCKgTrh1gS-cMyhBa0QoLW2DL2+DYxOAcA-Bd15H15vg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Adam Borowski <kilobyte@angband.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Ben Hutchings <ben@decadent.org.uk>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Dne 29.11.2016 v 18:10 Linus Torvalds napsal(a):
> How about this stupid patch? It weakens modversions, but that may be
> ok for Debian, and a better alternative than just saying "we don't
> support it at all".
[...]
> -	pr_warn("%s: no symbol version for %s\n", mod->name, symname);
> -	return 0;
> +	/* Broken toolchain. Warn once, then let it go.. */
> +	pr_warn_once("%s: no symbol version for %s\n", mod->name, symname);
> +	return 1;

Fine with me, if it goes with the revert of the "depends on BROKEN."

Michal
