From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 00/10] Control Flow Enforcement - Part (3)
Date: Tue, 12 Jun 2018 09:00:03 -0700
Message-ID: <CALCETrXK6hypCb5sXwxWRKr=J6_7XtS6s5GB1WPBiqi79q8-8g@mail.gmail.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <bbfde1b3-5e1b-80e3-30e8-fd1e46a2ceb1@gmail.com>
 <1528815820.8271.16.camel@2b52.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528815820.8271.16.camel@2b52.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: bsingharora@gmail.com, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 12, 2018 at 8:06 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> On Tue, 2018-06-12 at 20:56 +1000, Balbir Singh wrote:
> >
> > On 08/06/18 00:37, Yu-cheng Yu wrote:
> > > This series introduces CET - Shadow stack
> > >
> > > At the high level, shadow stack is:
> > >
> > >     Allocated from a task's address space with vm_flags VM_SHSTK;
> > >     Its PTEs must be read-only and dirty;
> > >     Fixed sized, but the default size can be changed by sys admin.
> > >
> > > For a forked child, the shadow stack is duplicated when the next
> > > shadow stack access takes place.
> > >
> > > For a pthread child, a new shadow stack is allocated.
> > >
> > > The signal handler uses the same shadow stack as the main program.
> > >
> >
> > Even with sigaltstack()?
> >
> >
> > Balbir Singh.
>
> Yes.
>

I think we're going to need some provision to add an alternate signal
stack to handle the case where the shadow stack overflows.
