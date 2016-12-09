Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932146AbcLIHz5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Dec 2016 02:55:57 -0500
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
References: <20161129135118.24696-1-kilobyte@angband.pl>
 <CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com>
 <30bb2db4-47bd-0c35-8328-ef032b551f06@suse.com>
 <CA+55aFxOGw57Gm-QiNs13kfy5k=aRrn3+98415V0g73eGc66mg@mail.gmail.com>
 <20161129195721.GI2697@decadent.org.uk>
 <CA+55aFyQko0t8oMZjhnwhWHrmBUyWjGhsnT=oUOU-W7_04xdzw@mail.gmail.com>
 <20161201051852.28dc335f@roar.ozlabs.ibm.com>
 <CA+55aFzMTrLMrr69ipdaKhz+RJhUu3BxB+kg0689qq_470qEcw@mail.gmail.com>
 <20161201041325.GX35881@redhat.com>
 <20161201153215.43b6cec7@roar.ozlabs.ibm.com>
 <20161201152039.GB35881@redhat.com>
 <20161209135041.5ff12770@roar.ozlabs.ibm.com>
From: Stanislav Kozina <skozina@redhat.com>
Message-ID: <0937c184-1946-c494-56b6-c38fd0b632c2@redhat.com>
Date: Fri, 9 Dec 2016 08:55:51 +0100
MIME-Version: 1.0
In-Reply-To: <20161209135041.5ff12770@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>, Don Zickus <dzickus@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20161209075551.n2rIDEtscg6hNBrv1F-6cSMObHNMqw79s8tN2NFoRIU@z>

>> The question is how to provide a similar guarantee if a different way?
> As a tool to aid distro reviewers, modversions has some value, but the
> debug info parsing tools that have been mentioned in this thread seem
> superior (not that I've tested them).

On the other hand the big advantage of modversions is that it also 
verifies the checksum during runtime (module loading). In other words, I 
believe that any other solution should still generate some form of 
checksum/watermark which can be easily checked for compatibility on 
module load.
It should not be hard to add to the DWARF based tools though. We'd just 
parse DWARF data instead of the C code.

Regards,
-Stanislav
