Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935578AbeFGSWG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 7 Jun 2018 14:22:06 -0400
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DAC7208AE
        for <linux-arch@vger.kernel.org>; Thu,  7 Jun 2018 18:22:05 +0000 (UTC)
Received: by mail-wm0-f41.google.com with SMTP id o13-v6so19621017wmf.4
        for <linux-arch@vger.kernel.org>; Thu, 07 Jun 2018 11:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-5-yu-cheng.yu@intel.com>
In-Reply-To: <20180607143807.3611-5-yu-cheng.yu@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 11:21:51 -0700
Message-ID: <CALCETrUqXvh2FDXe6bveP10TFpzptEyQe2=mdfZFGKU0T+NXsA@mail.gmail.com>
Subject: Re: [PATCH 04/10] x86/cet: Handle thread shadow stack
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, Florian Weimer <fweimer@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
Message-ID: <20180607182151.rrSYEofgaPffPjC1TMyD9dZ1ISzsIZRg4-ugkTcayxk@z>

On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> When fork() specifies CLONE_VM but not CLONE_VFORK, the child
> needs a separate program stack and a separate shadow stack.
> This patch handles allocation and freeing of the thread shadow
> stack.

Aha -- you're trying to make this automatic.  I'm not convinced this
is a good idea.  The Linux kernel has a long and storied history of
enabling new hardware features in ways that are almost entirely
useless for userspace.

Florian, do you have any thoughts on how the user/kernel interaction
for the shadow stack should work?  My intuition would be that all
shadow stack management should be entirely controlled by userspace --
newly cloned threads (with CLONE_VM) should have no shadow stack
initially, and newly started processes should have no shadow stack
until they ask for one.  If it would be needed for optimization, there
could some indication in an ELF binary that it is requesting an
initial shadow stack.

But maybe some kind of automation like this patch does is actually reasonable.

--Andy
