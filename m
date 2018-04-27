From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 1/7] kprobes: Make blacklist root user read only
Date: Fri, 27 Apr 2018 23:52:18 +0900
Message-ID: <20180427235218.60aec544b20f7abc5362482d@kernel.org>
References: <152481117776.22588.1210388093668905564.stgit@devbox>
        <152481120919.22588.16126591608892708741.stgit@devbox>
        <20180427065611.GA4361@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180427065611.GA4361@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Richter <tmricht@linux.ibm.com>, akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, 27 Apr 2018 08:56:11 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Apr 27, 2018 at 03:40:09PM +0900, Masami Hiramatsu wrote:
> > Since the blacklist file indicates a sensitive address
> > information to reader, it should be restricted to the
> > root user.
> > 
> > Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  kernel/kprobes.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>
> 
> If you want these to go to the stable tree(s), that is great, but please
> mark them properly.  As you did it here for this series, it will not
> work.

Sorry Greg. I'll mark it properly for next version.

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
