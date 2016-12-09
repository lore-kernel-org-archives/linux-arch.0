From: Stanislav Kozina <skozina@redhat.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Fri, 9 Dec 2016 08:55:51 +0100
Message-ID: <0937c184-1946-c494-56b6-c38fd0b632c2@redhat.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161209135041.5ff12770@roar.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>, Don Zickus <dzickus@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

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
