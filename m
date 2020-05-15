Return-Path: <SRS0=kV/L=65=vger.kernel.org=linux-doc-owner@kernel.org>
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
 <20200429220732.31602-2-yu-cheng.yu@intel.com>
 <b5197a8d-5d8b-e1f7-68d4-58d80261904c@intel.com>
 <dd5b9bab31ecf247a0b4890e22bfbb486ff52001.camel@intel.com>
 <5cc163ff9058d1b27778e5f0a016c88a3b1a1598.camel@intel.com>
 <b0581ddc-0d99-cbcf-278e-0be55ba939a0@intel.com>
 <44c055342bda4fb4730703f987ae35195d1d0c38.camel@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <32235ffc-6e6c-fb3d-80c4-a0478e2d0e0f@intel.com>
Date: Fri, 15 May 2020 15:43:56 -0700
MIME-Version: 1.0
In-Reply-To: <44c055342bda4fb4730703f987ae35195d1d0c38.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-doc-owner@vger.kernel.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200515224356.aYEZ12RJp7uWCVUrqgGrpkSybfkfdHQDoRo1HC60XMI@z>

On 5/15/20 2:33 PM, Yu-cheng Yu wrote:
> On Fri, 2020-05-15 at 11:39 -0700, Dave Hansen wrote:
>> On 5/12/20 4:20 PM, Yu-cheng Yu wrote:
>> Can a binary compiled with CET run without CET?
> 
> Yes, but a few details:
> 
> - The shadow stack is transparent to the application.  A CET application does
> not have anything different from a non-CET application.  However, if a CET
> application uses any CET instructions (e.g. INCSSP), it must first check if CET
> is turned on.
> - If an application is compiled for IBT, the compiler inserts ENDBRs at branch
> targets.  These are nops if IBT is not on.

I appreciate the detailed response, but it wasn't quite what I was
asking.  Let's ignore IBT for now and just talk about shadow stacks.

An app compiled with the new ELF flags and running on a CET-enabled
kernel and CPU will start off with shadow stacks allocated and enabled,
right?  It can turn its shadow stack off per-thread with the new prctl.
 But, otherwise, it's stuck, the only way to turn shadow stacks off at
startup would be editing the binary.

Basically, if there ends up being a bug in an app that violates the
shadow stack rules, the app is broken, period.  The only recourse is to
have the kernel disable CET and reboot.

Is that right?

>> Can a binary compiled without CET run CET-enabled code?
> 
> Partially yes, but in reality somewhat difficult.
...
> - If a not-CET application does fork(), and the child wants to turn on CET, it
> would be difficult to manage the stack frames, unless the child knows what is is
> doing.  

It might be hard to do, but it is possible with the patches you posted?
 I think you're saying that the CET-enabled binary would do
arch_setup_elf_property() when it was first exec()'d.  Later, it could
use the new prctl(ARCH_X86_CET_DISABLE) to disable its shadow stack,
then fork() and the child would not be using CET.  Right?

What is ARCH_X86_CET_DISABLE used for, anyway?

> The JIT examples I mentioned previously run with CET enabled from the
> beginning.  Do you have a reason to do this?  In other words, if the JIT code
> needs CET, the app could have started with CET in the first place.

Let's say I have a JIT'd sandbox.  I want the sandbox to be
CET-protected, but the JIT engine itself not to be.

> - If you are asking about dlopen(), the library will have the same setting as
> the main application.  Do you have any reason to have a library running with
> CET, but the application does not have CET?

Sure, using old binaries.  That's why IBT has a legacy bitmap and things
like MPX had ways of jumping into old non-enabled binaries.

>> Can different threads in a process have different CET enabling state?
> 
> Yes, if the parent starts with CET, children can turn it off.

How would that work, though?  clone() by default will copy the parent
xsave state, which means it will be CET-enabled, which means it needs a
shadow stack.  So, if I want a CET-free child thread, I need to clone(),
then turn CET off, then free the shadow stack?

>> Does this *code* work?  Could you please indicate which JITs have been
>> enabled to use the code in this series?  How much of the new ABI is in use?
> 
> JIT does not necessarily use all of the ABI.  The JIT changes mainly fix stack
> frames and insert ENDBRs.  I do not work on JIT.  What I found is LLVM JIT fixes
> are tested and in the master branch.  Sljit fixes are in the release.

Huh, so who is using the new prctl() ABIs?

>> Where are the selftests/ for this new ABI?  Were you planning on
>> submitting any with this series?
> 
> The ABI is more related to the application side, and therefore most suitable for
> GLIBC unit tests.

I was mostly concerned with the kernel selftests.  The things in
tools/testing/selftests/x86 in the kernel tree.

> The more complicated areas such as pthreads, signals, ucontext,
> fork() are all included there.  I have been constantly running these 
> tests without any problems.  I can provide more details if testing is
> the concern.

For something this complicated, with new kernel ABIs, we need an
in-kernel sefltest.

MPX was not that much different from this feature.  It required a
boatload of compiler and linker changes to function.  Yet, there was a
simple in-kernel test for it that didn't require *any* of that big pile
of toolchain bits.

Is there a reason we don't have one of those for CET?
