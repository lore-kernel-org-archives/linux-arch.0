Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932550AbeFGUya (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 7 Jun 2018 16:54:30 -0400
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 925E6208B3
        for <linux-arch@vger.kernel.org>; Thu,  7 Jun 2018 20:54:29 +0000 (UTC)
Received: by mail-wm0-f50.google.com with SMTP id v131-v6so21807563wma.1
        for <linux-arch@vger.kernel.org>; Thu, 07 Jun 2018 13:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-10-yu-cheng.yu@intel.com>
In-Reply-To: <20180607143807.3611-10-yu-cheng.yu@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 13:54:16 -0700
Message-ID: <CALCETrU8fK1j=H_9xpJrrCSUTcadb8dfjJX-YZwiWDZZFmLxRQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] mm: Prevent madvise from changing shadow stack
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
Message-ID: <20180607205416.19ponjk8LMDaZC5Sjlq1-Wqf1GVuGl7NBD0I1DqPDyg@z>

On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Seems reasonable to me.
