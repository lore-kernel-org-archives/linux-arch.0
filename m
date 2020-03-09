From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
Date: Mon, 9 Mar 2020 15:19:13 -0700
Message-ID: <56ab33ac-865b-b37e-75f2-a489424566c3@intel.com>
References: <CAMe9rOoRTVUzNC88Ho2XTTNJCymrd3L=XdB9xFcgxPVwAZ0FWA@mail.gmail.com>
 <AE81FEF5-ECC5-46AA-804D-9D64E656D16E@amacapital.net>
 <CAMe9rOoDMenvD9XRL1szR5yLQEwv9Q6f4O7CtwbdZ-cJqzezKA@mail.gmail.com>
 <0088001c-0b12-a7dc-ff2a-9d5c282fa36b@intel.com>
 <CAMe9rOqf0OHL9397Vikgb=UWhRMf+FmGq-9VAJNmfmzNMMDkCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:5055 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbgCIWTP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 9 Mar 2020 18:19:15 -0400
In-Reply-To: <CAMe9rOqf0OHL9397Vikgb=UWhRMf+FmGq-9VAJNmfmzNMMDkCw@mail.gmail.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Yu-cheng Yu <yu-cheng.yu@intel.com>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.ne>

On 3/9/20 2:12 PM, H.J. Lu wrote:
>> But what are the rules for clone()?  Should there be rules for
>> mismatches for CET enabling between threads if a process (not child
>> processes)?
> What did you mean? A threaded application is either CET enabled or not
> CET enabled.   A new thread from clone makes no difference.

Stacks are fundamentally thread-local resources.  The registers that
point to them and MSRs that manage shadow stacks are all CPU-thread
local.  Nothing is fundamentally tied to the address space shared across
the process.

A thread might also share *no* control flow with its child.  It might
ask the thread to start in code that the parent can never even reach.

It sounds like you've picked a Linux implementation that has
restrictions on top of the fundamentals.  That's not wrong per se, but
it does deserve explanation and deliberate, not experimental design.

Could you go back to the folks at Intel and try to figure out what this
was designed to *do*?  Yes, I'm probably one of those folks.  You know
where to find me. :)
