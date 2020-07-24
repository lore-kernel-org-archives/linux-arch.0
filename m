From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v10 00/26] Control-flow Enforcement: Shadow Stack
Date: Thu, 23 Jul 2020 21:59:25 -0700
Message-ID: <20200724045925.GO21891@linux.intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
 <20200723162531.GF21891@linux.intel.com>
 <2e9806a3-7485-a0d0-b63d-f112fcff954c@intel.com>
 <20200723165649.GG21891@linux.intel.com>
 <f38b5b34-8432-9531-01b5-d0ae924ffafe@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:50157 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgGXE70 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Jul 2020 00:59:26 -0400
Content-Disposition: inline
In-Reply-To: <f38b5b34-8432-9531-01b5-d0ae924ffafe@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>

On Thu, Jul 23, 2020 at 11:41:55AM -0700, Dave Hansen wrote:
> On 7/23/20 9:56 AM, Sean Christopherson wrote:
> > On Thu, Jul 23, 2020 at 09:41:37AM -0700, Dave Hansen wrote:
> >> On 7/23/20 9:25 AM, Sean Christopherson wrote:
> >>> How would people feel about taking the above two patches (02 and 03 in the
> >>> series) through the KVM tree to enable KVM virtualization of CET before the
> >>> kernel itself gains CET support?  I.e. add the MSR and feature bits, along
> >>> with the XSAVES context switching.  The feature definitons could use "" to
> >>> suppress displaying them in /proc/cpuinfo to avoid falsely advertising CET
> >>> to userspace.
> >>>
> >>> AIUI, there are ABI issues that need to be sorted out, and that is likely
> >>> going to drag on for some time. 
> >>>
> >>> Is this a "hell no" sort of idea, or something that would be feasible if we
> >>> can show that there are no negative impacts to the kernel?
> >> Negative impacts like bloating every task->fpu with XSAVE state that
> >> will never get used? ;)
> > Gah, should have qualified that with "meaningful or measurable negative
> > impacts".  E.g. the extra 40 bytes for CET XSAVE state seems like it would
> > be acceptable overhead, but noticeably increasing the latency of XSAVES
> > and/or XRSTORS would not be acceptable.
> 
> It's 40 bytes, but it's 40 bytes of just pure, unadulterated waste.  It
> would have no *chance* of being used.  It's also quite precisely

Well, technically the guest would be using that space :-).

> measurable on a given system:
> 
> 	cat /proc/slabinfo | grep task_struct | awk '{print $3 * 40}'
> 
> I don't expect it would do *much* to XSAVE/XRSTOR.  There's probably an
> extra conditional and jump in the ucode, but that's probably in the
> noise.  I assume that all the CET state has functioning init and
> modified trackers and we don't do anything to spoil their state.  It
> would be good to check that in practice, though it probably isn't the
> end of the world either way.  We've had some bugs in the past where we
> accidentally took things out of their init state.
> 
> It will make signal entry/return slower since we use a plain XSAVE
> without the init optimization.  But, that's just a single cacheline on
> average and some 0's to write.  Probably not noticeable, including the
> 40 bytes of extra userspace signal stack space.
> 
> I think that puts me in the "mildly annoyed" camp more than "hell no",
> but "mildly annoyed" is pretty much my resting state, so it doesn't
> really move the needle. :)
> 
> Why the urgency, though?
> 
> 	https://windows-internals.com/cet-on-windows/
> 
> ?

No urgency, it'd simply be one less KVM feature for us to be carrying and
refreshing.  And as a sort of general question, I was curious if folks
would be open to merging KVM support before kernel.
