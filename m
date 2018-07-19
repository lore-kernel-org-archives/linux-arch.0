Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:38597 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbeGSUQR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Jul 2018 16:16:17 -0400
Subject: Re: [RFC PATCH v2 16/27] mm: Modify can_follow_write_pte/pmd for
 shadow stack
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-17-yu-cheng.yu@intel.com>
 <de510df6-7ea9-edc6-9c49-2f80f16472b4@linux.intel.com>
 <1531328731.15351.3.camel@intel.com>
 <45a85b01-e005-8cb6-af96-b23ce9b5fca7@linux.intel.com>
 <1531868610.3541.21.camel@intel.com>
 <fa9db8c5-41c8-05e9-ad8d-dc6aaf11cb04@linux.intel.com>
 <1531944882.10738.1.camel@intel.com>
 <3f158401-f0b6-7bf7-48ab-2958354b28ad@linux.intel.com>
 <1531955428.12385.30.camel@intel.com>
 <f4c90626-51d8-5551-5b77-baaff81f16bb@linux.intel.com>
 <1532019963.16711.61.camel@intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <b3cafb94-39c1-3e03-a4f0-295e506da0a6@linux.intel.com>
Date: Thu, 19 Jul 2018 12:31:43 -0700
MIME-Version: 1.0
In-Reply-To: <1532019963.16711.61.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromiun.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20180719193143.IOEZTPnOAXmg8xT1Fpxan-o6ZHcP77Dd5ghaDNuTvqE@z>

On 07/19/2018 10:06 AM, Yu-cheng Yu wrote:
> Which pte_write() do you think is right?

There isn't one that's right.

The problem is that the behavior right now is ambiguous.  Some callers
of pte_write() need to know about _PAGE_RW alone and others want to know
if (_PAGE_RW || is_shstk()).

The point is that you need both, plus a big audit of all the pte_write()
users to ensure they use the right one.

For instance, see spurious_fault_check().  We can get a shadowstack
fault that also has X86_PF_WRITE, but pte_write()==0.  That might make a
shadowstack write fault falsely appear spurious.
