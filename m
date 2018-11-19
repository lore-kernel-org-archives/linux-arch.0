Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55524 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730580AbeKTItd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Nov 2018 03:49:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so266759wmc.5
        for <linux-arch@vger.kernel.org>; Mon, 19 Nov 2018 14:23:44 -0800 (PST)
MIME-Version: 1.0
References: <20181119214934.6174-1-yu-cheng.yu@intel.com> <20181119214934.6174-10-yu-cheng.yu@intel.com>
In-Reply-To: <20181119214934.6174-10-yu-cheng.yu@intel.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 19 Nov 2018 14:23:32 -0800
Message-ID: <CALCETrUkXMHcwX8u+mGDD9Vj+iQE7CRMHL7jQnfAT6WXV8SBEQ@mail.gmail.com>
Subject: Re: [RFC PATCH v6 09/11] x86/vsyscall/32: Add ENDBR32 to vsyscall
 entry point
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>
Message-ID: <20181119222332.hsJA40ljbtZw2iNZp-at2q9VtEPkbelTxhL2kb5XBXc@z>

On Mon, Nov 19, 2018 at 1:55 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> From: "H.J. Lu" <hjl.tools@gmail.com>
>
> Add ENDBR32 to vsyscall entry point.

$SUBJECT should be "x86/vdso/32: Add ENDBR32 to __kernel_vsyscall entry point".

--Andy
