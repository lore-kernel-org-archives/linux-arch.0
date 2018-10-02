Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:60370 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbeJBWM6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Oct 2018 18:12:58 -0400
Date: Tue, 2 Oct 2018 17:29:03 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v4 02/27] x86/fpu/xstate: Change some names to
 separate XSAVES system and user states
Message-ID: <20181002152903.GB29601@zn.tnic>
References: <20180921150351.20898-1-yu-cheng.yu@intel.com>
 <20180921150351.20898-3-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180921150351.20898-3-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20181002152903.2sk_leqI-WUb9OCW8d3Cce1dbf8mAyuj4Yvs1Gd8YbQ@z>

On Fri, Sep 21, 2018 at 08:03:26AM -0700, Yu-cheng Yu wrote:
> To support XSAVES system states, change some names to distinguish
> user and system states.

I don't understand what the logic here is. SDM says:

XSAVES—Save Processor Extended States Supervisor

the stress being on "Supervisor" - why does it need to be renamed to
"system" now?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
