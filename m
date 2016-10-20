From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH] kconfig.h: remove config_enabled() macro
Date: Thu, 20 Oct 2016 09:25:27 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1610200920140.25105@knanqh.ubzr>
References: <1476616078-32252-1-git-send-email-yamada.masahiro@socionext.com> <1476957892.28989.24.camel@tiscali.nl> <CAK7LNATp2vta0_Qzcs-TuXAX8jQejZyLXiqKKvfi8M=NLtxgAA@mail.gmail.com> <1476967442.28989.38.camel@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476967442.28989.38.camel@tiscali.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Thomas Garnier <thgarnie@google.com>
List-Id: linux-arch.vger.kernel.org

On Thu, 20 Oct 2016, Paul Bolle wrote:

> [Added Nicolas.]
> 
> On Thu, 2016-10-20 at 21:06 +0900, Masahiro Yamada wrote:
> > 2016-10-20 19:04 GMT+09:00 Paul Bolle <pebolle@tiscali.nl>:
> > > Is there a reason to keep using the double underscore prefix?
> > 
> > I followed the suggestion in the following message:
> > 
> > https://lkml.org/lkml/2016/6/6/944
> 
> Nicolas: was there any specific reason to suggest __is_defined() and
> not, say, is_defined()?

Not really, except maybe to keep more distance from the defined() 
preprocessor macro. But I don't have a strong opinion either ways.


Nicolas
