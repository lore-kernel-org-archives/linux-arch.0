Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934495AbeD0OvX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Apr 2018 10:51:23 -0400
Date: Fri, 27 Apr 2018 23:51:17 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH -tip v2 0/7] kprobes: Fix %p in kprobes
Message-ID: <20180427235117.c0bcfc30ed4cb0c97038e555@kernel.org>
In-Reply-To: <20180427065637.GB4361@kroah.com>
References: <152473007907.8819.10449983839199591406.stgit@devbox>
        <20180426084022.GA6777@kroah.com>
        <20180426211434.140fa33d@vmware.local.home>
        <20180427065637.GB4361@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Richter <tmricht@linux.ibm.com>, akpm@linux-foundation.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, stable@vger.kernel.org
Message-ID: <20180427145117.sNvQx_md17_74s7FtmfesGGuFEHoAseIXTcxUzDAbzo@z>

On Fri, 27 Apr 2018 08:56:37 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Thu, Apr 26, 2018 at 09:14:34PM -0400, Steven Rostedt wrote:
> > On Thu, 26 Apr 2018 10:40:22 +0200
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > > <formletter>
> > > 
> > > This is not the correct way to submit patches for inclusion in the
> > > stable kernel tree.  Please read:
> > >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > > for how to do this properly.
> > > 
> > > </formletter>
> > 
> > Is it because he didn't add the Cc: stable@vger.kernel.org tag?
> 
> Yes.

Ah, I misunderstood that. OK, adding that CC in the body.

Thanks,



-- 
Masami Hiramatsu <mhiramat@kernel.org>
