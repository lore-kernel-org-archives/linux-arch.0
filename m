Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:33958 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfGTKyP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Jul 2019 06:54:15 -0400
Date: Sat, 20 Jul 2019 12:54:07 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] kbuild: Fail if gold linker is detected
In-Reply-To: <CAHbf0-FfD_tzRFfkYK=gWDOkB=+ecFuJPbZwPS3S3HJmDThPWw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907201253360.1782@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907161434260.1767@nanos.tec.linutronix.de> <20190716170606.GA38406@archlinux-threadripper> <alpine.DEB.2.21.1907162059200.1767@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907162135590.1767@nanos.tec.linutronix.de>
 <CAK7LNASBiaMX8ihnmhLGmYfHX=ZHZmVN91nxmFZe-OCaw6Px2w@mail.gmail.com> <alpine.DEB.2.21.1907170955250.1767@nanos.tec.linutronix.de> <CAHbf0-GyQzWcRg_BP2B5pVzEJoxSE_hX5xFypS--7Q5LSHxzWw@mail.gmail.com> <alpine.DEB.2.21.1907201133000.1782@nanos.tec.linutronix.de>
 <CAHbf0-FfD_tzRFfkYK=gWDOkB=+ecFuJPbZwPS3S3HJmDThPWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Lothian <mike@fireburn.co.uk>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Nathan Chancellor <natechancellor@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, "H.J. Lu" <hjl.tools@gmail.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, linux-arch@vger.kernel.org
Message-ID: <20190720105407.DcesK5_WMSzm6VjGUAOtVdJtQkpNEQR-yqIoz4TgSNI@z>

On Sat, 20 Jul 2019, Mike Lothian wrote:
> Here is my config
> 
> https://github.com/FireBurn/KernelStuff/blob/9b7e96581598d50b266f9df258e7de764949147a/dot_config_tip
> 

Builds perfectly fine.
