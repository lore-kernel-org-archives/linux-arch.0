From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [GIT PULL] kbuild changes for v4.9-rc1
Date: Sun, 18 Dec 2016 16:08:10 +0100
Message-ID: <7e93909c-d2ab-a07a-c2ed-cdb1c44937d0@suse.cz>
References: <20161017065131.GA27863@angband.pl>
 <20161017175951.31d8f4b7@roar.ozlabs.ibm.com>
 <20161017100130.GA16013@angband.pl>
 <7212667f-f508-2b41-a380-8f736814d8cc@suse.cz>
 <CA+55aFxjJbAXRq2HSxhfn2gWsGiLPTcqoRrrDLJrLd2vFLu9YQ@mail.gmail.com>
 <5ee08a93-6b17-d1c2-af1c-ab9aa218903c@suse.cz>
 <CA+55aFzRqCYxkqpHioWz-o4WPTDbFmmbHNWFm2oGkYObNOQX=w@mail.gmail.com>
 <9dec52ac-dc82-73c5-6b36-b5eb7cc052fa@suse.cz>
 <8311f14c-3d1e-6354-323a-87701cabaa97@broadcom.com>
 <0fca8045-30c0-590d-07b8-d7d7d9791759@gmail.com>
 <9aa0d77b-5cb4-f67f-4a09-2c6336b32db6@suse.cz>
 <eff67256-ea61-ef88-251b-b67fcf6a9538@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35426 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753568AbcLRPIO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Dec 2016 10:08:14 -0500
In-Reply-To: <eff67256-ea61-ef88-251b-b67fcf6a9538@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nikolay Borisov <n.borisov.lkml@gmail.com>, Arend Van Spriel <arend.vanspriel@broadcom.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Adam Borowski <kilobyte@angband.pl>, Nicholas Piggin <npiggin@gmail.com>, Omar Sandoval <osandov@osandov.com>, Michal Marek <mmarek@suse.com>, Alexey Dobriyan <adobriyan@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Al Viro <viro@zeniv.linux.org.uk>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On 12/18/2016, 03:54 PM, Nikolay Borisov wrote:
> 
> 
> On 18.12.2016 16:45, Jiri Slaby wrote:
>> Moreover, with some modules, __put_user_1 and others are reported
>> instead of mcount.
> 
> 
> nm vmlinux | grep __fentry__
> nm vmlinux | grep mcount
> 
> What do these report ? I bet you that in your vmlinux the first one
> would return something like :
> 
> ffffffff822f1810 T __fentry__
> ffffffff827fdc20 r __kcrctab___fentry__
> ffffffff82809461 r __kstrtab___fentry__
> ffffffff827e6c20 R __ksymtab___fentry__
>  and nothing for the second. Whereas doing nm on the module in question
> would give nothing for __fentry__ and something like: U mcount

Well, I have just won a beer:
$ nm vmlinux | grep mcount
         w __crc_mcount
c0b3bd34 r __kcrctab_mcount
c0b41692 r __kstrtab_mcount
c0b2dd04 R __ksymtab_mcount
c0896130 T mcount
c0c9ee20 T __start_mcount_loc
c0cba89c T __stop_mcount_loc
$ nm vmlinux | grep __fentry__
$ nm sound/soundcore.ko | grep mcount
         U mcount

No, I am really not stupid. We compile the kernels like this for over a
decade and it really broke with 4.9. Applying the patch fixes the
problem. Reverting it, makes it recur.

regards,
-- 
js
suse labs
