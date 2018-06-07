Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933932AbeFGPjt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 7 Jun 2018 11:39:49 -0400
Received: from mail-it0-f42.google.com (mail-it0-f42.google.com [209.85.214.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF08120874
        for <linux-arch@vger.kernel.org>; Thu,  7 Jun 2018 15:39:48 +0000 (UTC)
Received: by mail-it0-f42.google.com with SMTP id j135-v6so2931817itj.1
        for <linux-arch@vger.kernel.org>; Thu, 07 Jun 2018 08:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143544.3477-1-yu-cheng.yu@intel.com> <20180607143544.3477-6-yu-cheng.yu@intel.com>
In-Reply-To: <20180607143544.3477-6-yu-cheng.yu@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 08:39:36 -0700
Message-ID: <CALCETrWVZfWUSOy6wRyVBfP2b2TzZuPt8bCe6q0Pa5r7onO+VA@mail.gmail.com>
Subject: Re: [PATCH 5/5] Documentation/x86: Add CET description
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
Message-ID: <20180607153936.WaU_1AGvXSRj75ToXIxavFLJjX1iXFm4eJJk-qxvcfY@z>

On Thu, Jun 7, 2018 at 7:40 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:

Fix the subject line, please.  This is more than just docs.

>
> Explain how CET works and the noshstk/noibt kernel parameters.

Maybe no_cet_shstk and no_cet_ibt?  noshstk sounds like gibberish and
people might need a reminder.
