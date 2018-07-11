Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:20438 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732677AbeGKRhR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Jul 2018 13:37:17 -0400
Message-ID: <1531330096.15351.10.camel@intel.com>
Subject: Re: [RFC PATCH v2 12/27] x86/mm: Shadow stack page fault error
 checking
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Wed, 11 Jul 2018 10:28:16 -0700
In-Reply-To: <61793360-f37c-ec19-c390-abe3c76a5f5c@linux.intel.com>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
         <20180710222639.8241-13-yu-cheng.yu@intel.com>
         <61793360-f37c-ec19-c390-abe3c76a5f5c@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromiun.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20180711172816.lTEYy98GUPFS9xgEDJOl6fbxLg7JpkRVdVDEYZC_6EU@z>

On Tue, 2018-07-10 at 15:52 -0700, Dave Hansen wrote:
> On 07/10/2018 03:26 PM, Yu-cheng Yu wrote:
> > 
> > +++ b/arch/x86/include/asm/traps.h
> > @@ -157,6 +157,7 @@ enum {
> >   *   bit 3 ==				1: use of reserved
> > bit detected
> >   *   bit 4 ==				1: fault was an
> > instruction fetch
> >   *   bit 5 ==				1: protection keys
> > block access
> > + *   bit 6 ==				1: shadow stack
> > access fault
> >   */
> Could we document this bit better?
> 
> Is this a fault where the *processor* thought it should be a shadow
> stack fault?  Or is it also set on faults to valid shadow stack PTEs
> that just happen to fault for other reasons, say protection keys?

Thanks Vedvyas for explaining this to me.
I will add this to comments:

This flag is 1 if (1) CR4.CET = 1; and (2) the access causing the page-
fault exception was a shadow-stack data access.

So this bit does not report the reason for the fault. It reports the
type of access; i.e. it was a shadow-stack-load or a shadow-stack-store 
that took the page fault. The fault could have been caused by any
variety of reasons including protection keys.
