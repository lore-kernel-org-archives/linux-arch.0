From: Jann Horn <jannh@google.com>
Subject: Re: [kernel-hardening] [PATCH v4.1 01/10] Documentation: document array_ptr
Date: Mon, 22 Jan 2018 20:00:40 +0100
Message-ID: <CAG48ez3SQNMKxMLNKCV4o8qAbqzB4d+EPo8a4wHzDgqkGAX8Dw@mail.gmail.com>
References: <151648235823.34747.15181877619346237802.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151648236454.34747.93245075402067564.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34433 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbeAVTBC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jan 2018 14:01:02 -0500
Received: by mail-oi0-f46.google.com with SMTP id k15so4043262oib.1
        for <linux-arch@vger.kernel.org>; Mon, 22 Jan 2018 11:01:02 -0800 (PST)
In-Reply-To: <151648236454.34747.93245075402067564.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Mark Rutland <mark.rutland@arm.com>, linux-arch <linux-arch@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, Will Deacon <will.deacon@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>, alan@linux.intel.com

On Sat, Jan 20, 2018 at 10:06 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> From: Mark Rutland <mark.rutland@arm.com>
>
> Document the rationale and usage of the new array_ptr() helper.
[...]
> +A call to array_ptr(arr, idx, sz) returns a sanitized pointer to
> +arr[idx] only if idx falls in the [0, sz) interval. When idx < 0 or idx > sz,

"or idx >= sz"?
