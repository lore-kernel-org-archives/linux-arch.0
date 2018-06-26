Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38049 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751650AbeFZPAG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Jun 2018 11:00:06 -0400
Message-ID: <1530024994.27091.0.camel@intel.com>
Subject: Re: [PATCH 00/10] Control Flow Enforcement - Part (3)
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Tue, 26 Jun 2018 07:56:34 -0700
In-Reply-To: <CAG48ez2puLWrDDPg=ighCY+yxFoP-nN97MqVseqYabBad+eKmg@mail.gmail.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
         <CAG48ez2puLWrDDPg=ighCY+yxFoP-nN97MqVseqYabBad+eKmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jann Horn <jannh@google.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hjl.tools@gmail.com, vedvyas.shanbhogue@intel.com, ravi.v.shankar@intel.com, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <20180626145634.MRc5usK7TDJQb6963pNCaeY4EBKaUsnTx7FvNYFHW_A@z>

On Tue, 2018-06-26 at 04:46 +0200, Jann Horn wrote:
> On Tue, Jun 26, 2018 at 4:45 AM Yu-cheng Yu <yu-cheng.yu@intel.com>
> wrote:
> > 
> > 
> > This series introduces CET - Shadow stack
> > 
> > At the high level, shadow stack is:
> > 
> >         Allocated from a task's address space with vm_flags
> > VM_SHSTK;
> >         Its PTEs must be read-only and dirty;
> >         Fixed sized, but the default size can be changed by sys
> > admin.
> > 
> > For a forked child, the shadow stack is duplicated when the next
> > shadow stack access takes place.
> > 
> > For a pthread child, a new shadow stack is allocated.
> > 
> > The signal handler uses the same shadow stack as the main program.
> > 
> > Yu-cheng Yu (10):
> >   x86/cet: User-mode shadow stack support
> >   x86/cet: Introduce WRUSS instruction
> >   x86/cet: Signal handling for shadow stack
> >   x86/cet: Handle thread shadow stack
> >   x86/cet: ELF header parsing of Control Flow Enforcement
> >   x86/cet: Add arch_prctl functions for shadow stack
> >   mm: Prevent mprotect from changing shadow stack
> >   mm: Prevent mremap of shadow stack
> >   mm: Prevent madvise from changing shadow stack
> >   mm: Prevent munmap and remap_file_pages of shadow stack
> Shouldn't patches like these be CC'ed to linux-api@vger.kernel.org?

Yes, I will do that.

Thanks,
Yu-cheng
