Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfHMWzW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 18:55:22 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0D142173B
        for <linux-arch@vger.kernel.org>; Tue, 13 Aug 2019 22:55:20 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id l2so2807174wmg.0
        for <linux-arch@vger.kernel.org>; Tue, 13 Aug 2019 15:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190813205225.12032-1-yu-cheng.yu@intel.com> <20190813205225.12032-16-yu-cheng.yu@intel.com>
In-Reply-To: <20190813205225.12032-16-yu-cheng.yu@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 13 Aug 2019 15:55:07 -0700
Message-ID: <CALCETrVKbqzivPfUOiGi5efHUpEsfPkNzP0CrmAZzcwUgf7quA@mail.gmail.com>
Subject: Re: [PATCH v8 15/27] mm: Handle shadow stack page fault
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190813225507.bukzWn4nrQhMRZoeBl8_XSZCfai3xRBqu1HBmTDeS5c@z>

On Tue, Aug 13, 2019 at 2:02 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> When a task does fork(), its shadow stack (SHSTK) must be duplicated
> for the child.  This patch implements a flow similar to copy-on-write
> of an anonymous page, but for SHSTK.
>
> A SHSTK PTE must be RO and dirty.  This dirty bit requirement is used
> to effect the copying.  In copy_one_pte(), clear the dirty bit from a
> SHSTK PTE to cause a page fault upon the next SHSTK access.  At that
> time, fix the PTE and copy/re-use the page.

Is using VM_SHSTK and special-casing all of this really better than
using a special mapping or other pseudo-file-backed VMA and putting
all the magic in the vm_operations?

--Andy
