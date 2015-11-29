From: "PaX Team" <pageexec@freemail.hu>
Subject: Re: [PATCH 0/2] introduce post-init read-only memory
Date: Sun, 29 Nov 2015 12:15:01 +0100
Message-ID: <565ADE35.20892.225C67C2@pageexec.freemail.hu>
References: <1448401114-24650-1-git-send-email-keescook@chromium.org>, <565876F3.21515.18F8DF8F@pageexec.freemail.hu>, <20151129080853.GB23721@gmail.com>
Reply-To: kernel-hardening@lists.openwall.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <kernel-hardening-return-2011-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-reply-to: <20151129080853.GB23721@gmail.com>
Content-description: Mail message body
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kernel-hardening@lists.openwall.com, Mathias Krause <minipli@googlemail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86-ml <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org, Emese Revfy <re.emese@gmail.com>
List-Id: linux-arch.vger.kernel.org

On 29 Nov 2015 at 9:08, Ingo Molnar wrote:

> 
> * PaX Team <pageexec@freemail.hu> wrote:
> 
> > i don't see the compile time vs. runtime detection as 'competing' approaches, 
> > both have their own role. [...]
> 
> That's true - but only as long as 'this can be solved in tooling!' is not used as 
> an excuse to oppose the runtime solution and we end up doing neither.

actually, i already voiced my opinion elsewhere in the constify thread on
the kernel hardening list that adding/using __read_only is somewhat premature
without also adding the compile time verification part (as part of the
constify plugin for example). right now its use on the embedded vdso image
is simple and easy to verify but once people begin to add it to variables
that the compiler knows and cares about (say, the ops structures) then
things can become fragile without compile checking. so yes, i'd also advise
to get such tooling in *before* more __read_only usage is added.
