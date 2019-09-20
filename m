From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC patch 02/15] x86/entry: Remove _TIF_NOHZ from _TIF_WORK_SYSCALL_ENTRY
Date: Fri, 20 Sep 2019 16:39:22 -0700
Message-ID: <CALCETrWHkRiXx_r8x6k=ArxTZc5YS0DewMQDVHFrjVY3Xt+H7A@mail.gmail.com>
References: <20190919150314.054351477@linutronix.de> <20190919150808.617944343@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190919150808.617944343@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm list <kvm@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 19, 2019 at 8:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Evaluating _TIF_NOHZ to decide whether to use the slow syscall entry path
> is not only pointless, it's actually counterproductive:
>
>  1) Context tracking code is invoked unconditionally before that flag is
>     evaluated.
>
>  2) If the flag is set the slow path is invoked for nothing due to #1

Can we also get rid of TIF_NOHZ on x86?
