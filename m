Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:39301 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbfGWGld (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jul 2019 02:41:33 -0400
Date: Tue, 23 Jul 2019 08:41:24 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] kbuild: Fail if gold linker is detected
In-Reply-To: <CAK7LNATJGbSYyuxV7npC_bQiXQShb=7J7dcQcOaupnL5-GhADg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907230837400.1659@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907161434260.1767@nanos.tec.linutronix.de> <20190716170606.GA38406@archlinux-threadripper> <alpine.DEB.2.21.1907162059200.1767@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907162135590.1767@nanos.tec.linutronix.de>
 <CAK7LNASBiaMX8ihnmhLGmYfHX=ZHZmVN91nxmFZe-OCaw6Px2w@mail.gmail.com> <alpine.DEB.2.21.1907170955250.1767@nanos.tec.linutronix.de> <CAHbf0-GyQzWcRg_BP2B5pVzEJoxSE_hX5xFypS--7Q5LSHxzWw@mail.gmail.com>
 <CAK7LNATJGbSYyuxV7npC_bQiXQShb=7J7dcQcOaupnL5-GhADg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Mike Lothian <mike@fireburn.co.uk>, Nathan Chancellor <natechancellor@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, "H.J. Lu" <hjl.tools@gmail.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190723064124.7XiqiF34GgsBjJJ51pjPt4-RqJHAhC_NDKa-XrSTm-I@z>

On Tue, 23 Jul 2019, Masahiro Yamada wrote:
> Right.
> I was able to build with ld.gold
> 
> So, we can use gold, depending on the kernel configuration.

That's exactly the problem. It breaks with random kernel configurations
which is not acceptable except for people who know what they are doing.

I'm tired of dealing with half baken fixes and 'regression' reports. Either
there is an effort to fix the issues with gold like the clang people fix
their issues or it needs to be disabled. We have a clear statement that
gold developers have other priorities.

Thanks,

	tglx
