From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 06/10] x86/cet: Add arch_prctl functions for shadow stack
Date: Thu, 07 Jun 2018 13:30:17 -0700
Message-ID: <1528403417.5265.35.camel@2b52.sc.intel.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
         <20180607143807.3611-7-yu-cheng.yu@intel.com>
         <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
List-Id: linux-arch.vger.kernel.org

On Thu, 2018-06-07 at 11:48 -0700, Andy Lutomirski wrote:
> On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> >
> > The following operations are provided.
> >
> > ARCH_CET_STATUS:
> >         return the current CET status
> >
> > ARCH_CET_DISABLE:
> >         disable CET features
> >
> > ARCH_CET_LOCK:
> >         lock out CET features
> >
> > ARCH_CET_EXEC:
> >         set CET features for exec()
> >
> > ARCH_CET_ALLOC_SHSTK:
> >         allocate a new shadow stack
> >
> > ARCH_CET_PUSH_SHSTK:
> >         put a return address on shadow stack
> >
> > ARCH_CET_ALLOC_SHSTK and ARCH_CET_PUSH_SHSTK are intended only for
> > the implementation of GLIBC ucontext related APIs.
> 
> Please document exactly what these all do and why.  I don't understand
> what purpose ARCH_CET_LOCK and ARCH_CET_EXEC serve.  CET is opt in for
> each ELF program, so I think there should be no need for a magic
> override.

CET is initially enabled if the loader has CET capability.  Then the
loader decides if the application can run with CET.  If the application
cannot run with CET (e.g. a dependent library does not have CET), then
the loader turns off CET before passing to the application.  When the
loader is done, it locks out CET and the feature cannot be turned off
anymore until the next exec() call.  When the next exec() is called, CET
feature is turned on/off based on the values set by ARCH_CET_EXEC.

I will put more details in Documentation/x86/intel_cet.txt.
 
