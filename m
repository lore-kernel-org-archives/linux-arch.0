From: Stanislav Kozina <skozina@redhat.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Fri, 9 Dec 2016 15:36:04 +0100
Message-ID: <249321c0-bcb1-f9d8-50f4-c083b656d02e@redhat.com>
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
 <0937c184-1946-c494-56b6-c38fd0b632c2@redhat.com>
 <20161209181459.1f0a4fed@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20161209181459.1f0a4fed@roar.ozlabs.ibm.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Don Zickus <dzickus@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

>>>> The question is how to provide a similar guarantee if a different way?
>>> As a tool to aid distro reviewers, modversions has some value, but the
>>> debug info parsing tools that have been mentioned in this thread seem
>>> superior (not that I've tested them).
>> On the other hand the big advantage of modversions is that it also
>> verifies the checksum during runtime (module loading). In other words, I
>> believe that any other solution should still generate some form of
>> checksum/watermark which can be easily checked for compatibility on
>> module load.
>> It should not be hard to add to the DWARF based tools though. We'd just
>> parse DWARF data instead of the C code.
> A runtime check is still done, with per-module vermagic which distros
> can change when they bump the ABI version. Is it really necessary to
> have more than that (i.e., per-symbol versioning)?

 From my point of view, it is. We need to allow changing ABI for some 
modules while maintaining it for others.
In fact I think that there should be version not only for every exported 
symbol (in the EXPORT_SYMBOL() sense), but also for every public type 
(in the sense of eg. structure defined in the public header file).

Thanks,
-Stanislav
