From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
Date: Fri, 22 May 2020 18:49:53 +0200
Message-ID: <20200522164953.GA411971@hirez.programming.kicks-ass.net>
References: <20200429220732.31602-2-yu-cheng.yu@intel.com>
 <b5197a8d-5d8b-e1f7-68d4-58d80261904c@intel.com>
 <dd5b9bab31ecf247a0b4890e22bfbb486ff52001.camel@intel.com>
 <5cc163ff9058d1b27778e5f0a016c88a3b1a1598.camel@intel.com>
 <b0581ddc-0d99-cbcf-278e-0be55ba939a0@intel.com>
 <44c055342bda4fb4730703f987ae35195d1d0c38.camel@intel.com>
 <32235ffc-6e6c-fb3d-80c4-a0478e2d0e0f@intel.com>
 <6272c481-af90-05c5-7231-3ba44ff9bd02@citrix.com>
 <CAMe9rOqwbxis1xEWbOsftMB9Roxdb3=dp=_MgK8z2pwPP36uRw@mail.gmail.com>
 <f8ce9863-6ada-2bc4-5141-122f64292aba@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:45748 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730445AbgEVQxD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 May 2020 12:53:03 -0400
Content-Disposition: inline
In-Reply-To: <f8ce9863-6ada-2bc4-5141-122f64292aba@citrix.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, Dave Hansen <dave.hansen@intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat>

On Sat, May 16, 2020 at 03:09:22PM +0100, Andrew Cooper wrote:

> Sadly, the same is not true for kernel shadow stacks.
> 
> SSP is 0 after SYSCALL, SYSENTER and CLRSSBSY, and you've got to be
> careful to re-establish the shadow stack before a CALL, interrupt or
> exception tries pushing a word onto the shadow stack at 0xfffffffffffffff8.

Oh man, I can only imagine the joy that brings to #NM and friends :-(
