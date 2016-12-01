From: Michal Marek <mmarek@suse.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Thu, 1 Dec 2016 17:21:02 +0100
Message-ID: <91d0141e-07af-b8bb-c360-49d64598aa58@suse.com>
References: <20161129131922.GA31466@angband.pl>
 <CA+55aFxCKgTrh1gS-cMyhBa0QoLW2DL2+DYxOAcA-Bd15H15vg@mail.gmail.com>
 <CA+55aFw7G1QJ0dwMXJKJqFVhVsWGsAdxZTOsmcCD7POUde2+dA@mail.gmail.com>
 <2899250.iZaPagXLk8@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <2899250.iZaPagXLk8@wuerfel>
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Ben Hutchings <ben@decadent.org.uk>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 2016-12-01 14:58, Arnd Bergmann wrote:
> On Tuesday, November 29, 2016 9:14:46 AM CET Linus Torvalds wrote:
>> On Tue, Nov 29, 2016 at 9:10 AM, Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> So quite frankly, I don't want to make our kernel sources worse due to
>>> broken shit tools getting something wrong that we shouldn't even care
>>> about.
>>
>> And yes, I'm on binutils 2.26 (with no issues), so it could be that
>> it's 2.27 that triggers this.
>>
>> We could make the pr_warn_once() mention "broken binutils?" so that
>> people know why the warning happens.
> 
> I've tried to get to the bottom of this, but couldn't find anything
> related to the toolchain version. I've tried binutils 2.23, 2.24, 2.26
> and 2.27, and also gcc-7.0, gcc-5.4.1 and gcc-4.9.3, but with today's
> linux-next, I always get
> 
> WARNING: EXPORT symbol "mcount" [arch/x86/entry/built-in.ko] version generation failed, symbol will not be versioned.
> WARNING: EXPORT symbol "mcount" [arch/x86/built-in.ko] version generation failed, symbol will not be versioned.
> WARNING: EXPORT symbol "cmpxchg8b_emu" [vmlinux] version generation failed, symbol will not be versioned.
> WARNING: EXPORT symbol "empty_zero_page" [vmlinux] version generation failed, symbol will not be versioned.
> WARNING: EXPORT symbol "mcount" [vmlinux] version generation failed, symbol will not be versioned.
> WARNING: EXPORT symbol "cmpxchg8b_emu" [vmlinux] version generation failed, symbol will not be versioned.
> WARNING: EXPORT symbol "empty_zero_page" [vmlinux] version generation failed, symbol will not be versioned.
> WARNING: EXPORT symbol "mcount" [vmlinux] version generation failed, symbol will not be versioned.
> 
> Out of 12 randconfig builds that had CONFIG_MODVERSIONS enabled, all 12
> had this problem, though not always with all the symbols.

That we are not generating modversions for the asm exports is a known
problem, independent of the toolchain. The problem with some toolchains
(presumably, because that's the next thing to blame if the source and
the .config is identical) is that the CRCs do not appear as 0 in the
___kcrctab/___kcrctab_gpl section.

Michal

