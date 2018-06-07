Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932427AbeFGSuY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 7 Jun 2018 14:50:24 -0400
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC67B208AC
        for <linux-arch@vger.kernel.org>; Thu,  7 Jun 2018 18:50:23 +0000 (UTC)
Received: by mail-wm0-f47.google.com with SMTP id p126-v6so19876707wmb.2
        for <linux-arch@vger.kernel.org>; Thu, 07 Jun 2018 11:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-11-yu-cheng.yu@intel.com>
In-Reply-To: <20180607143807.3611-11-yu-cheng.yu@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 11:50:10 -0700
Message-ID: <CALCETrXTyXYCDJxbCA+cbzZirmMKRQq8XSS4+Lyeo_QMywdxFw@mail.gmail.com>
Subject: Re: [PATCH 10/10] mm: Prevent munmap and remap_file_pages of shadow stack
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
Message-ID: <20180607185010.4IOn63-RnAMhkrxE_4EqDbzz89KNjDFEqwguYpRbUio@z>

On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:

blocking remap_file_pages() seems reasonable.  I'm not sure what's
wrong with munmap().
