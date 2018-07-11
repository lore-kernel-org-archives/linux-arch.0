Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51815 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732562AbeGKQ1e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Jul 2018 12:27:34 -0400
Subject: Re: [RFC PATCH v2 15/27] mm/mprotect: Prevent mprotect from changing
 shadow stack
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-16-yu-cheng.yu@intel.com>
 <04800c52-1f86-c485-ba7c-2216d8c4966f@linux.intel.com>
 <20180711091232.GU2476@hirez.programming.kicks-ass.net>
 <1531325272.13297.27.camel@intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <a4dae7e3-58a7-5c38-1071-2deee758bb98@linux.intel.com>
Date: Wed, 11 Jul 2018 09:22:28 -0700
MIME-Version: 1.0
In-Reply-To: <1531325272.13297.27.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromiun.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20180711162228.XvexMuzstxlGa9jRbDnlGDMrp2Zx8qiod9Qp5OT7dp0@z>

On 07/11/2018 09:07 AM, Yu-cheng Yu wrote:
>> Why do we need to disallow this? AFAICT the worst that can happen is
>> that a process wrecks itself, so what?
> Agree.  I will remove the patch.

No so quick. :)

We still need to find out a way to handle things that ask for an
mprotect() which is incompatible with shadow stacks.  PROT_READ without
PROT_WRITE comes to mind.  We also need to be careful that we don't
copy-on-write/copy-on-access pages which fault on PROT_NONE.  I *think*
it'll get done correctly but we have to be sure.

BTW, where are all the selftests for this code?  We're slowly building
up a list of pathological things that need to get tested.

I don't think this can or should get merged before we have selftests.
