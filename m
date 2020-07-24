Return-Path: <SRS0=Lhqp=BD=vger.kernel.org=linux-doc-owner@kernel.org>
Message-ID: <d15816d6172ea770b63e52443aced5607f1e35c1.camel@intel.com>
Subject: Re: [PATCH v10 00/26] Control-flow Enforcement: Shadow Stack
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Thu, 23 Jul 2020 20:40:33 -0700
In-Reply-To: <f38b5b34-8432-9531-01b5-d0ae924ffafe@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
         <20200723162531.GF21891@linux.intel.com>
         <2e9806a3-7485-a0d0-b63d-f112fcff954c@intel.com>
         <20200723165649.GG21891@linux.intel.com>
         <f38b5b34-8432-9531-01b5-d0ae924ffafe@intel.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-doc-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>, Sean Christopherson <sean.j.christopherson@intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200724034033.ISYxhmyMtML99jqkjhUQIXAi0MH14ipBWOOCxdjeGvw@z>

On Thu, 2020-07-23 at 11:41 -0700, Dave Hansen wrote:
> On 7/23/20 9:56 AM, Sean Christopherson wrote:
> > On Thu, Jul 23, 2020 at 09:41:37AM -0700, Dave Hansen wrote:
> > > On 7/23/20 9:25 AM, Sean Christopherson wrote:
> > > > How would people feel about taking the above two patches (02 and 03 in the
> > > > series) through the KVM tree to enable KVM virtualization of CET before the
> > > > kernel itself gains CET support?  I.e. add the MSR and feature bits, along
> > > > with the XSAVES context switching.  The feature definitons could use "" to
> > > > suppress displaying them in /proc/cpuinfo to avoid falsely advertising CET
> > > > to userspace.
> > > > 
> > > > AIUI, there are ABI issues that need to be sorted out, and that is likely
> > > > going to drag on for some time. 
> > > > 
> > > > Is this a "hell no" sort of idea, or something that would be feasible if we
> > > > can show that there are no negative impacts to the kernel?
> > > Negative impacts like bloating every task->fpu with XSAVE state that
> > > will never get used? ;)
> > Gah, should have qualified that with "meaningful or measurable negative
> > impacts".  E.g. the extra 40 bytes for CET XSAVE state seems like it would
> > be acceptable overhead, but noticeably increasing the latency of XSAVES
> > and/or XRSTORS would not be acceptable.
> 
> It's 40 bytes, but it's 40 bytes of just pure, unadulterated waste.  It
> would have no *chance* of being used.  It's also quite precisely
> measurable on a given system:
> 
> 	cat /proc/slabinfo | grep task_struct | awk '{print $3 * 40}'

If there is value in getting these two patches merged first, we can move
XFEATURE_MASK_CET_USER to XFEATURE_MASK_SUPERVISOR_UNSUPPORTED for now, until
CET is eventually merged.  That way, there is no space wasted.

Yu-cheng
