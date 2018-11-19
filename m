Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38259 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730215AbeKTIst (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Nov 2018 03:48:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id k198so283349wmd.3
        for <linux-arch@vger.kernel.org>; Mon, 19 Nov 2018 14:23:01 -0800 (PST)
MIME-Version: 1.0
References: <20181119214934.6174-1-yu-cheng.yu@intel.com> <20181119214934.6174-11-yu-cheng.yu@intel.com>
In-Reply-To: <20181119214934.6174-11-yu-cheng.yu@intel.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 19 Nov 2018 14:22:50 -0800
Message-ID: <CALCETrWP20o62m_5mp_yCBFNMQ4YYV-kPKiytHObhvJs_bjFVQ@mail.gmail.com>
Subject: Re: [RFC PATCH v6 10/11] x86/vsyscall/64: Add ENDBR64 to vsyscall
 entry points
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>
Message-ID: <20181119222250.AqEC8WL_gWO4TVSP-kE2LMKdLFCcaoi_uAcwj4WMEAc@z>

On Mon, Nov 19, 2018 at 1:55 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> From: "H.J. Lu" <hjl.tools@gmail.com>
>
> Add ENDBR64 to vsyscall entry points.
>
> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>

Acked-by: Andy Lutomirski <luto@kernel.org>

although the scenarios where this matters will be extremely rare,
given that this code is mapped NX :)  Tools like 'pin' may care.

--Andy
