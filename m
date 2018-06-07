Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932366AbeFGStN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 7 Jun 2018 14:49:13 -0400
Received: from mail-wr0-f175.google.com (mail-wr0-f175.google.com [209.85.128.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BBD32089B
        for <linux-arch@vger.kernel.org>; Thu,  7 Jun 2018 18:49:13 +0000 (UTC)
Received: by mail-wr0-f175.google.com with SMTP id d2-v6so10860350wrm.10
        for <linux-arch@vger.kernel.org>; Thu, 07 Jun 2018 11:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-9-yu-cheng.yu@intel.com>
In-Reply-To: <20180607143807.3611-9-yu-cheng.yu@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 11:48:59 -0700
Message-ID: <CALCETrVX8nE6oFnJH7yZCydxtnC-VAhhnYs=ekJELc07a2UKiQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] mm: Prevent mremap of shadow stack
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
Message-ID: <20180607184859.PxuEatMTmpDkdOVo0TLWID5wr12mNYZXvEKgXpAbcAQ@z>

On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Please justify.  This seems actively harmful to me.
