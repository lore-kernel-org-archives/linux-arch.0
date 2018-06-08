From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [PATCH 03/10] x86/cet: Signal handling for shadow stack
Date: Fri, 8 Jun 2018 15:07:50 +0300
Message-ID: <20180608120750.GB2525@uranus>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
 <20180607143807.3611-4-yu-cheng.yu@intel.com>
 <CALCETrWo77RS_wOzskw5OG-LdC1S-b_NY=uPWUmPbQEnNwANgQ@mail.gmail.com>
 <20180607200714.GA2525@uranus>
 <CALCETrXAoPsHK49c1Dpa8N0ccsxjwnVOTktKVaY++xjHxdmUzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrXAoPsHK49c1Dpa8N0ccsxjwnVOTktKVaY++xjHxdmUzg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>, Florian Weimer <fweimer@redhat.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
List-Id: linux-arch.vger.kernel.org

On Thu, Jun 07, 2018 at 01:57:03PM -0700, Andy Lutomirski wrote:
...
> >
> > I didn't read the whole series of patches in details
> > yet, hopefully will be able tomorrow. Thanks Andy for
> > CC'ing!
> 
> We have uc_flags.  It might be useful to carve out some of the flag
> space (24 bits?) to indicate something like the *size* of sigcontext
> and teach the kernel that new sigcontext fields should only be parsed
> on sigreturn() if the size is large enough.

Yes, this should do the trick.
