From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v4 2/5] x86,entry: Only call user_exit if TIF_NOHZ
Date: Thu, 31 Jul 2014 18:58:04 +0200
Message-ID: <20140731165804.GB16800@redhat.com>
References: <cover.1406604806.git.luto@amacapital.net> <7123b2489cc5d1d5abb7bcf1364ca729cab3e6ca.1406604806.git.luto@amacapital.net> <20140729193232.GA8153@redhat.com> <20140730164344.GA27954@localhost.localdomain> <CALCETrUVaz3JFiNbyU=r3M-E9muHa1ffn7RX+_-4V_0U-hVaPw@mail.gmail.com> <20140731151630.GA7842@localhost.localdomain> <20140731164246.GA15974@redhat.com> <20140731164918.GC7842@localhost.localdomain> <20140731165423.GA16800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <20140731165423.GA16800@redhat.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Will Drewry <wad@chromium.org>, X86 ML <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-arch <linux-arch@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, Alexei Starovoitov <ast@plumgrid.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-arch.vger.kernel.org

On 07/31, Oleg Nesterov wrote:
>
> On 07/31, Frederic Weisbecker wrote:
> >
> > On Thu, Jul 31, 2014 at 06:42:46PM +0200, Oleg Nesterov wrote:
> > >
> > > And if we change this, then the code above becomes racy. The state of
> > > TIF_XYZ can be changed right after the check. OK, it is racy anyway ;)
> > > but still this adds more confusion.
> >
> > No because all running tasks have this flag set when context tracking is
> > enabled. And context tracking can't be disabled on runtime.
>
> Yes, yes, please note that I said "if we change this".

And "it is racy anyway" connects to the problems we discuss in another
thread.

Oleg.
