Return-Path: <SRS0=KXl1=5R=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:20532 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732219AbgDATWG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 1 Apr 2020 15:22:06 -0400
Subject: Re: [RFC PATCH v9 09/27] x86/mm: Introduce _PAGE_DIRTY_SW
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-10-yu-cheng.yu@intel.com>
 <325d3a25-0016-ea19-c0c9-7958066fc94e@intel.com>
 <6f68d7af6a618c087a85d2db6ad40b346e055452.camel@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <6689281d-b71d-9044-eeb7-09c9228a61e0@intel.com>
Date: Wed, 1 Apr 2020 12:22:03 -0700
MIME-Version: 1.0
In-Reply-To: <6f68d7af6a618c087a85d2db6ad40b346e055452.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Message-ID: <20200401192203.6hT-xb-wTQztaEuugsvoQtrjDEyyDYHveICJ61OdWn4@z>

On 4/1/20 12:08 PM, Yu-cheng Yu wrote:
>>> +/*
>>> + * This bit indicates a copy-on-write page, and is different from
>>> + * _PAGE_BIT_SOFT_DIRTY, which tracks which pages a task writes to.
>>> + */
>>> +#define _PAGE_BIT_DIRTY_SW	_PAGE_BIT_SOFTW5 /* was written to */
>> Does it *only* indicate a copy-on-write (or copy-on-access) page?  If
>> so, haven't we misnamed it?
> It indicates either a copy-on-write page or a read-only page that has been
> cow'ed.  What about _PAGE_BIT_COW?

Sounds sane to me.
