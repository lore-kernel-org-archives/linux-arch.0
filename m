Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:15748 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727293AbeH2Ue6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Aug 2018 16:34:58 -0400
Subject: Re: [RFC PATCH 5/6] x86/alternatives: use temporary mm for text
 poking
References: <20180829081147.184610-1-namit@vmware.com>
 <20180829081147.184610-6-namit@vmware.com>
 <20180829092839.GP24124@hirez.programming.kicks-ass.net>
 <CALCETrXe9CUMo3c44UtmkxD4w68PvmoypdCyvCFvWiZVuxy=sQ@mail.gmail.com>
 <20180829161400.GV24124@hirez.programming.kicks-ass.net>
 <CALCETrVixiv+9Eb7yO334gF_C4CLgr0cTDzS==FZ3TXSgMNt9Q@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <17f2c74c-93fb-5ec8-4022-bd433fe0e429@intel.com>
Date: Wed, 29 Aug 2018 09:37:13 -0700
MIME-Version: 1.0
In-Reply-To: <CALCETrVixiv+9Eb7yO334gF_C4CLgr0cTDzS==FZ3TXSgMNt9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Nadav Amit <namit@vmware.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>
Message-ID: <20180829163713.W51wbh3tCWUPA2pbzkP5h28n7v4A5RMhN8zEU8PTHsI@z>

On 08/29/2018 09:32 AM, Andy Lutomirski wrote:
> It's plausible that there are workloads where the current code is
> faster, such as where we're munmapping a single page via syscall and
> we'd prefer to only flush that one TLB entry even if the flush
> operation is slower as a result.

Yeah, I don't specifically remember testing it.  But, I know I wanted to
avoid throwing away thousands of TLB entries when we only want to rid
ourselves of one.
