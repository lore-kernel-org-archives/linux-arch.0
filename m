Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:62174 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeLFRUr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Dec 2018 12:20:47 -0500
Date: Thu, 6 Dec 2018 17:20:37 +0000
From: Joseph Myers <joseph@codesourcery.com>
Subject: Re: [PATCH v3 0/6] mips: system call table generation support
In-Reply-To: <alpine.LFD.2.21.1812061659210.4294@eddie.linux-mips.org>
Message-ID: <alpine.DEB.2.21.1812061719180.12167@digraph.polyomino.org.uk>
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org> <CALxhOnjSEp++W5T3Sf0eX+8hPt08ER22M817M-Vhd24_96a_EQ@mail.gmail.com> <20181205063436.kzxgnvgexcgq572k@pburton-laptop> <alpine.LFD.2.21.1812061209220.7193@eddie.linux-mips.org>
 <alpine.DEB.2.21.1812061618110.12167@digraph.polyomino.org.uk> <alpine.LFD.2.21.1812061659210.4294@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>, Firoz Khan <firoz.khan@linaro.org>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, libc-alpha@sourceware.org
Message-ID: <20181206172037.TXhvnzfsJbgWfgW-oFg15K7bgfqnAQkVoXfsRq_DJKs@z>

On Thu, 6 Dec 2018, Maciej W. Rozycki wrote:

> On Thu, 6 Dec 2018, Joseph Myers wrote:
> 
> > >  I believe this file is used by the glibc build process to retrieve 
> > > syscall numbers for glibc's own use as well for <sys/syscall.h>.  Has the 
> > > change been verified not to break this process?
> > > 
> > >  Cc-ing <libc-alpha@sourceware.org> for information and possible further 
> > > input.
> > 
> > I'm not sure what "this file" is.  The glibc build uses the installed 
> > <asm/unistd.h> (the results of #including it, not any other kind of 
> > processing the file).
> 
>  So how are `SYS_<name>' macros generated that land in <bits/syscall.h>?

By gen-syscall-h.awk, which generates #ifdef conditionals for each 
possible __NR_* name (as listed in syscall-names.list in glibc).

-- 
Joseph S. Myers
joseph@codesourcery.com
