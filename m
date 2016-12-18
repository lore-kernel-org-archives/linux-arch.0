From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [GIT PULL] kbuild changes for v4.9-rc1
Date: Sun, 18 Dec 2016 15:45:00 +0100
Message-ID: <9aa0d77b-5cb4-f67f-4a09-2c6336b32db6@suse.cz>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36213 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932291AbcLROpF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Dec 2016 09:45:05 -0500
In-Reply-To: <0fca8045-30c0-590d-07b8-d7d7d9791759@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nikolay Borisov <n.borisov.lkml@gmail.com>, Arend Van Spriel <arend.vanspriel@broadcom.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Adam Borowski <kilobyte@angband.pl>, Nicholas Piggin <npiggin@gmail.com>, Omar Sandoval <osandov@osandov.com>, Michal Marek <mmarek@suse.com>, Alexey Dobriyan <adobriyan@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Al Viro <viro@zeniv.linux.org.uk>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On 12/18/2016, 02:27 PM, Nikolay Borisov wrote:
> This is the likely problem here.

No, it is not. How could a rpm be built with two compilers?

Moreover, with some modules, __put_user_1 and others are reported
instead of mcount.

-- 
js
suse labs
