From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 5/5] kernel: tracepoints: add support for relative
 references
Date: Wed, 30 Aug 2017 09:17:53 -0400
Message-ID: <20170830091753.27e2ba47@gandalf.local.home>
References: <20170819181035.969-1-ard.biesheuvel@linaro.org>
        <20170819181035.969-6-ard.biesheuvel@linaro.org>
        <20170820105144.3e8269e7@gandalf.local.home>
        <CAKv+Gu8ckETOwKN8onbFB6mDv64qa_gqcUmJ0sEJCn=9Ovq+2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751317AbdH3NR6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 30 Aug 2017 09:17:58 -0400
In-Reply-To: <CAKv+Gu8ckETOwKN8onbFB6mDv64qa_gqcUmJ0sEJCn=9Ovq+2Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>, Andrew Morton <akpm@linux-foundation.org>

On Wed, 30 Aug 2017 13:52:26 +0100
Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On 20 August 2017 at 15:51, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Sat, 19 Aug 2017 19:10:35 +0100
> > Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >  
> >> To avoid the need for relocating absolute references to tracepoint
> >> structures at boot time when running relocatable kernels (which may
> >> take a disproportionate amount of space), add the option to emit
> >> these tables as relative references instead.
> >>  
> >
> > This patch looks fine. But I want to test the series before giving it
> > my Acked-by. I wont be able to do that till Tuesday at the earliest.
> >  
> 
> I guess this has slipped between the cracks?

Yes it has. Thanks for the reminder. I'm quite overwhelmed after coming
back from vacation, and getting pulled in various directions.

I'll see if I can run it through some tests today.

-- Steve
