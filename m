From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH -tip v2 0/7] kprobes: Fix %p in kprobes
Date: Fri, 27 Apr 2018 23:51:17 +0900
Message-ID: <20180427235117.c0bcfc30ed4cb0c97038e555@kernel.org>
References: <152473007907.8819.10449983839199591406.stgit@devbox>
        <20180426084022.GA6777@kroah.com>
        <20180426211434.140fa33d@vmware.local.home>
        <20180427065637.GB4361@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180427065637.GB4361@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Richter <tmricht@linux.ibm.com>, akpm@linux-foundation.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.c
List-Id: linux-arch.vger.kernel.org

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
