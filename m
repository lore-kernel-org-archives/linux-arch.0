Return-Path: <SRS0=OG4P=7L=vger.kernel.org=linux-doc-owner@kernel.org>
Message-ID: <ce66498068c42913150ee3f4928a0d8e3435316d.camel@intel.com>
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Thu, 28 May 2020 19:08:28 -0700
In-Reply-To: <CALCETrWavh1_Atk=VPQbOoB5tY=zGWGukW8qjF51msKTJSJgQQ@mail.gmail.com>
References: <2eb98637-bd2d-dda6-7729-f06ea84256ca@intel.com>
         <58319765-891D-44B9-AF18-64492B01FF36@amacapital.net>
         <CALCETrWavh1_Atk=VPQbOoB5tY=zGWGukW8qjF51msKTJSJgQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-doc-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200529020828.wMExueEhvzuoMuNzDZjaMFqe3hHMm5HXdUxZzf9z8RU@z>

On Tue, 2020-05-19 at 18:04 -0700, Andy Lutomirski wrote:
> On Mon, May 18, 2020 at 6:35 PM Andy Lutomirski <luto@amacapital.net> wrote:
> > [...]
> > > On May 18, 2020, at 5:38 PM, Dave Hansen <dave.hansen@intel.com> wrote:
> > > [...]
> > > The sadistic parts of selftests/x86 come from real bugs.  Either bugs
> > > where the kernel fell over, or where behavior changed that broke apps.
> > > I'd suggest doing some research on where that particular test case came
> > > from.  Find the author of the test, look at the changelogs.
> > > 
> > > If this is something that a real app does, this is a problem.  If it's a
> > > sadistic test that Andy L added because it was an attack vector against
> > > the entry code, it's a different story.
> > 
> > There are quite a few tests that do these horrible things in there. IN my personal opinion, sigreturn.c is one of the most important tests we have — it does every horrible thing to the entry code that I thought of and that I could come up with a way of doing.  We have been saved from regressing many times by these tests.  CET, and especially the CPL0 version of CET, is its own set of entry horror, and we need to keep these tests working.
> > 
> > I assume the basic issue is that we call raise(), the context magically changes to 32-bit, but SSP has a 64-bit value, and horrors happen.  So I think two things need to happen:
> > 
> > 1. Someone needs to document what happens when IRET tries to put a 64-bit value into SSP but CS is compat. Because Intel has plenty of history of doing colossally broken things here. IOW you could easily be hitting a hardware design problem, not a software issue per se.
> > 
> > 2. The test needs to work. Assuming the hardware doesn’t do something utterly broken, either the 32-bit code needs to be adjusted to avoid any CALL
> > or RET, or you need to write a little raise_on_32bit_shstk() func that switches to an SSP that fits in 32 bits, calls raise(), and switches back.  From memory, I didn’t think there was a CALl or RET, so I’m guessing that SSP is getting truncated when we round trip through CPL3 compat mode and the result is that the kernel invoked the signal handler with the wrong SSP.  Whoops.
> > 
> 
> Following up here, I think this needs attention from the H/W architects.
> 
> From the SDM:
> 
> SYSRET and SYSEXIT:
> 
> IF ShadowStackEnabled(CPL)
> SSP ← IA32_PL3_SSP;
> FI;
> 
> IRET:
> 
> IF ShadowStackEnabled(CPL)
> IF CPL = 3
> THEN tempSSP ← IA32_PL3_SSP; FI;
> IF ((EFER.LMA AND CS.L) = 0 AND tempSSP[63:32] != 0)
> THEN #GP(0); FI;
> SSP ← tempSSP
> 
> The semantics of actually executing in compat mode with SSP >= 2^32
> are unclear.  If nothing else, VM exit will save the full SSP and a
> subsequent VM entry will fail.

Here is what I got after talking to the architect.

If the guest is in 32-bit mode, but its VM guest state SSP field is 64-bit, the
CPU only uses the lower 32 bits.

The SDM currently states a consistency check of the guest SSP field, but that
will be removed in the next version.  Upon VM entry, the CPU only requires the
guest SSP to be pseudo-canonical like the RIP and RSP.

> I don't know what the actual effect of operand-size-32 SYSRET or
> SYSEXIT with too big a PL3_SSP will be, but I think it needs to be
> documented.  Ideally it will not put the CPU in an invalid state.
> Ideally it will also not fault, because SYSRET faults in particular
> are fatal unless the vector uses IST, and please please please don't
> force more ISTs on anyone.

On SYSRET/SYSEXIT to a 32-bit context, the CPU only uses the lower 32 bits of
the user-mode SSP, and will not go into an invalid state and will not fault. 
The SDM will be explicit about this.

Yu-cheng

> 
> So I think we may need to put this entire series on hold until we get
> some answers, because I suspect we're going to have a nice little root
> hole otherwise.
