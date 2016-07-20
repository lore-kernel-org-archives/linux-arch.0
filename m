From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 00/11] mm: Hardened usercopy
Date: Wed, 20 Jul 2016 08:31:37 -0700
Message-ID: <CAGXu5j+QH8Fdk7p6bZV_yMv1puHRxZRu5z45+tKrmLyGBTymFw@mail.gmail.com>
References: <1468619065-3222-1-git-send-email-keescook@chromium.org> <063D6719AE5E284EB5DD2968C1650D6D5F4FD6A3@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33406 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236AbcGTPbk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jul 2016 11:31:40 -0400
Received: by mail-wm0-f50.google.com with SMTP id p129so1561264wmp.0
        for <linux-arch@vger.kernel.org>; Wed, 20 Jul 2016 08:31:40 -0700 (PDT)
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D5F4FD6A3@AcuExch.aculab.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Will Deacon <will.deacon@arm.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Christoph Lameter <cl@linux.com>, Andrea Arcangeli <aarcange@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, PaX Team <pageexec@freemail.hu>, Borislav Petkov <bp@suse.de>, Mathias Krause <minipli@googlemail.com>, Fenghua Yu <fenghua.yu@intel.com>, Rik van Riel <riel@redhat.com>, David

On Wed, Jul 20, 2016 at 2:52 AM, David Laight <David.Laight@aculab.com> wrote:
> From: Kees Cook
>> Sent: 15 July 2016 22:44
>> This is a start of the mainline port of PAX_USERCOPY[1].
> ...
>> - if address range is in the current process stack, it must be within the
>>   current stack frame (if such checking is possible) or at least entirely
>>   within the current process's stack.
> ...
>
> That description doesn't seem quite right to me.
> I presume the check is:
>   Within the current process's stack and not crossing the ends of the
>   current stack frame.

Actually, it's a bad description all around. :) The check is that the
range is within a valid stack frame (current or any prior caller's
frame). i.e. it does not cross a frame or touch the saved frame
pointer nor instruction pointer.

> The 'current' stack frame is likely to be that of copy_to/from_user().
> Even if you use the stack of the caller, any problematic buffers
> are likely to have been passed in from a calling function.
> So unless you are going to walk the stack (good luck on that)
> I'm not sure checking the stack frames is worth it.

Yup: that's exactly what it's doing: walking up the stack. :)

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
