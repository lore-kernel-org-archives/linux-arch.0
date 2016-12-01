Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50087 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754625AbcLAQOX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 1 Dec 2016 11:14:23 -0500
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
References: <20161129131922.GA31466@angband.pl>
 <20161129135118.24696-1-kilobyte@angband.pl>
 <CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com>
 <30bb2db4-47bd-0c35-8328-ef032b551f06@suse.com>
 <CA+55aFxOGw57Gm-QiNs13kfy5k=aRrn3+98415V0g73eGc66mg@mail.gmail.com>
 <20161129195721.GI2697@decadent.org.uk>
 <CA+55aFyQko0t8oMZjhnwhWHrmBUyWjGhsnT=oUOU-W7_04xdzw@mail.gmail.com>
 <20161201051852.28dc335f@roar.ozlabs.ibm.com>
 <CA+55aFzMTrLMrr69ipdaKhz+RJhUu3BxB+kg0689qq_470qEcw@mail.gmail.com>
 <20161201041325.GX35881@redhat.com>
From: Michal Marek <mmarek@suse.com>
Message-ID: <29219570-8ede-8388-9313-d1d4db226b2a@suse.com>
Date: Thu, 1 Dec 2016 17:14:19 +0100
MIME-Version: 1.0
In-Reply-To: <20161201041325.GX35881@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Don Zickus <dzickus@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, skozina@redhat.com, Ben Hutchings <ben@decadent.org.uk>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20161201161419.9VUr_uFwqm3aIiBjVbNZ_IumZC3LR_So7FJxO57X2K0@z>

On 2016-12-01 05:13, Don Zickus wrote:
> Sorry for chiming in late, but yes RHEL is a big user of MODVERSIONS for our
> kabi protection work.  Despite our best intentions we still have lots of
> partners and customers that provide value-add out-of-tree drivers to their
> customers.  These module builders requested we have a mechanism to allow
> rolling modules forward for each of our minor RHEL updates without breaking
> their drivers.

FWIW, in SLES we use CONFIG_MODVERSION for pretty much the same reasons
you listed. We also enable it in openSUSE, but there it's not as crucial.

Michal
