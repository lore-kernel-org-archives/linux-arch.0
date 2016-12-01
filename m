Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from [195.159.176.226] ([195.159.176.226]:54048 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1756290AbcLAPuN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Dec 2016 10:50:13 -0500
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <glka-linux-arch@m.gmane.org>)
        id 1cCTca-0004d4-CO
        for linux-arch@vger.kernel.org; Thu, 01 Dec 2016 16:50:04 +0100
From: Dodji Seketeli <dodji@seketeli.org>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from asm
Date: Thu, 01 Dec 2016 16:19:23 +0100
Message-ID: <86k2bjk77o.fsf@seketeli.org>
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
        <830d2864-ab52-27c8-8178-ec86f3267079@redhat.com>
        <20161201220907.60375b4f@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, debian-kernel@lists.debian.org, linux-kernel@vger.kernel.orglinux-kbuild@vger.kernel.orglinux-kernel@vger.kernel.org
Message-ID: <20161201151923.wl7owtafkFTa0Y_QNdduNLcB86gY0u8beEeEgeWKny8@z>

Nicholas Piggin <npiggin@gmail.com> a écrit:

[...]

> On Thu, 1 Dec 2016 11:48:09 +0100
> Stanislav Kozina <skozina@redhat.com> wrote:
>
>> On 12/01/2016 05:13 AM, Don Zickus wrote:
>> 
>> ...
>> 
>> > I think GregKH pointed to one such tool, libabigail?  We are working on
>> > others too.  
>> 
>> I should mention one of the others here:
>> https://github.com/skozina/kabi-dw

[...]

> Now this seems much better for distro ABI checking.

Right, Incidentally, Fedora does distro-wide ABI verfication for
userspace libraries updates in a given stable distribution.  You can
look at an example of output of the libabigail-based tool that compares
a new version of an ELF library to it's latest stable version:

https://taskotron.fedoraproject.org/artifacts/all/a55cbac8-ab64-11e6-94e0-525400120b80/task_output/curl-7.51.0-2.fc25.log

The results of those ABI comparison can browsed at https://taskotron.fedoraproject.org/resultsdb/results?testcase_name=dist.abicheck.

Of course, you can run the comparison yourself by using a
libabigail-based tool like
https://sourceware.org/libabigail/manual/abipkgdiff.html which takes
.deb and .rpm packages.

We are currently working on making libabigail-based tools understand
Linux kernel specifities so that we can run that kind of analysis on
Kernel updates too.  Ideally, when this is done, you should be able to
just use abipkgdiff on two Linux Kernel packages and get the same kind
of output.

> The next question is, do they need any kernel support for rare cases
> where they do have to break the ABI of an export? Simple rename of the
> function with a _v2 postfix might be enough. We could retain some per
> symbol versioning in the kernel if needed, but how much would it
> actually help?

As a reviewer of the ABI change report emitted by the tool, if what you
want is to say "I reviewed that ABI change and it's OK, so please do not
show it to me next time", then you can feed the tool with a "suppression
specification".  It's a text file in the INI syntax in which you can
specify the kind of change you want the tool to suppress from its
output: https://sourceware.org/libabigail/manual/libabigail-concepts.html.

So I don't think you need to do anything to the source code of the
Kernel in the cases where you need to change the ABI.  Just tell the
tool about that change.

Cheers,

-- 
		Dodji

