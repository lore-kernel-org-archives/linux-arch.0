From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH v2 01/17] asm: simd context helper API
Date: Sun, 26 Aug 2018 08:18:15 -0600
Message-ID: <CAHmME9q+JcT9pnZ5jgowf15O4BkVF-2-QkHA2o1ZKbVe4nAg6g@mail.gmail.com>
References: <20180824213849.23647-1-Jason@zx2c4.com> <20180824213849.23647-2-Jason@zx2c4.com>
 <alpine.DEB.2.21.1808261234240.1195@nanos.tec.linutronix.de>
 <CAHmME9qrc_f6uqGOrRVpnO_sTXHg2cg-WwWg4ik3yqu=HCOZSg@mail.gmail.com> <alpine.DEB.2.21.1808261602250.1195@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1808261602250.1195@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Andrew Lutomirski <luto@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org, Rik van Riel <riel@surriel.com>
List-Id: linux-arch.vger.kernel.org

On Sun, Aug 26, 2018 at 8:06 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > Do you mean to say you intend to make kernel_fpu_end() and
> > kernel_neon_end() only actually do something upon context switch, but
> > not when it's actually called? So that multiple calls to
> > kernel_fpu_begin() and kernel_neon_begin() can be made without
> > penalty?
>
> On context switch and exit to user. That allows to keep those code pathes
> fully preemptible. Still twisting my brain around the details.

Just to make sure we're on the same page, the goal is so that this code:

kernel_fpu_begin();
kernel_fpu_end();
kernel_fpu_begin();
kernel_fpu_end();
kernel_fpu_begin();
kernel_fpu_end();
kernel_fpu_begin();
kernel_fpu_end();
kernel_fpu_begin();
kernel_fpu_end();
kernel_fpu_begin();
kernel_fpu_end();
...

has the same performance as this code:

kernel_fpu_begin();
kernel_fpu_end();

(Unless of course the process is preempted or the like.)

Currently the present situation makes the performance of the above
wildly different, since kernel_fpu_end() does something immediately.

What about something like this:
- Add a tristate flag connected to task_struct (or in the global fpu
struct in the case that this happens in irq and there isn't a valid
current).
- On kernel_fpu_begin(), if the flag is 0, do the usual expensive
XSAVE stuff, and set the flag to 1.
- On kernel_fpu_begin(), if the flag is non-0, just set the flag to 1
and return.
- On kernel_fpu_end(), if the flag is non-0, set the flag to 2.
(Otherwise WARN() or BUG() or something.)
- On context switch / preemption / etc away from the task, if the flag
is non-0, XRSTOR and such.
- On context switch / preemption / etc back to the task, if the flag
is 1, XSAVE and such. If the flag is 2, set it to 0.

Jason
