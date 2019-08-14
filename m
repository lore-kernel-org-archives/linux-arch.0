Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41343 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728053AbfHNQwE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Aug 2019 12:52:04 -0400
Message-ID: <c7731c682b55ec882ad3d4ea11ad7a823dcaae8f.camel@intel.com>
Subject: Re: [PATCH v8 11/27] x86/mm: Introduce _PAGE_DIRTY_SW
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Wed, 14 Aug 2019 09:42:23 -0700
In-Reply-To: <dac2d62b-9045-4767-87dd-eac12e7abafd@intel.com>
References: <20190813205225.12032-1-yu-cheng.yu@intel.com>
         <20190813205225.12032-12-yu-cheng.yu@intel.com>
         <dac2d62b-9045-4767-87dd-eac12e7abafd@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190814164223.h3LlWsVcVEnycJOLb3WNFdQd-sQp5YEwXY6kF35G6XQ@z>

On Tue, 2019-08-13 at 16:02 -0700, Dave Hansen wrote:
[...]
> Please also reconcile the supervisor XSAVE portion of your patches with
> the ones that Fenghua has been sending around.  I've given quite a bit
> of feedback to improve those.  Please consolidate and agree on a common
> set of patches with him.

XSAVES supervisor is now a six-patch set.  Maybe we can make it a separate
series?  I will consolidate and send it out.

Yu-cheng
