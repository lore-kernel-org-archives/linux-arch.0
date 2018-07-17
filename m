Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40998 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730092AbeGQXuF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Jul 2018 19:50:05 -0400
Subject: Re: [RFC PATCH v2 16/27] mm: Modify can_follow_write_pte/pmd for
 shadow stack
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-17-yu-cheng.yu@intel.com>
 <de510df6-7ea9-edc6-9c49-2f80f16472b4@linux.intel.com>
 <1531328731.15351.3.camel@intel.com>
 <45a85b01-e005-8cb6-af96-b23ce9b5fca7@linux.intel.com>
 <1531868610.3541.21.camel@intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <fa9db8c5-41c8-05e9-ad8d-dc6aaf11cb04@linux.intel.com>
Date: Tue, 17 Jul 2018 16:15:10 -0700
MIME-Version: 1.0
In-Reply-To: <1531868610.3541.21.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromiun.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20180717231510.bi36sXQNDwLGo8V-7Y1MUYULATj7_9NgZt81xLIAsBg@z>

On 07/17/2018 04:03 PM, Yu-cheng Yu wrote:
> We need to find a way to differentiate "someone can write to this PTE"
> from "the write bit is set in this PTE".

Please think about this:

	Should pte_write() tell us whether PTE.W=1, or should it tell us
	that *something* can write to the PTE, which would include
	PTE.W=0/D=1?
