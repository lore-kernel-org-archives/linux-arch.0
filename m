From: Stanislav Kozina <skozina@redhat.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Tue, 13 Dec 2016 02:07:42 +0100
Message-ID: <ffc59023-0438-22d2-cd24-bae2929b278c@redhat.com>
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
 <20161210021529.4a6e684f@roar.ozlabs.ibm.com> <86vaus3eld.fsf@seketeli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <86vaus3eld.fsf@seketeli.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Dodji Seketeli <dodji@seketeli.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: Ian Campbell <ijc@hellion.org.uk>, Michal Marek <mmarek@suse.com>, Ben Hutchings <ben@decadent.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hello,

>> That said, a dwarf based checker tool should be able to do as good a job
>> (maybe a bit better because report is very informative and it may pick up
>> compiler alignments or padding options).
> So, Nicholas was kind enough to send me the two Linux Kernel binaries
> that he built with the tiny little interface change that we were
> discussing earlier.  Here is what the abidiff[1] tools says about that
> interface change:

Thanks Nicholas and Dodji for this great example, for comparison I think 
it would be nice to share the example run with kabi-dw too.
kabi-dw first dumps and unifies all type information into a set of text 
files, the unification takes a significant time. Then the two sets of 
these text files can be compared.

An example run would look like:
$ time ~/Code/kabi-dw/kabi-dw generate -o abi1 vmlinux.abi1
Generating symbol defs from vmlinux.abi1...

real    0m29.057s
user    0m13.929s
sys    0m14.862s
$ time ~/Code/kabi-dw/kabi-dw generate -o abi2 vmlinux.abi2
Generating symbol defs from vmlinux.abi2...

real    0m29.134s
user    0m13.961s
sys    0m14.921s
$ time ~/Code/kabi-dw/kabi-dw compare abi1 abi2
Changes detected in: 
home/npiggin/src/linux.vectors/mm/memory.c/struct--blah.txt
Inserted:
+0x0 int y;
Shifted:
-0x0 int x;
+0x4 int x;


real    0m0.176s
user    0m0.135s
sys    0m0.040s

The size of the generated text files with all the relevant type 
information is as follows:
$ du -hs abi1
16M    abi1
$ find abi1 -type f | wc -l
3162

Warm regards,
-Stanislav
