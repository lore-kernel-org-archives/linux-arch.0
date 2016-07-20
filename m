From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 00/11] mm: Hardened usercopy
Date: Wed, 20 Jul 2016 10:44:43 -0700
Message-ID: <CAGXu5jKk=1QzO8op-3aaPJ9HtceFsSNWwof--eb+wSi1UPnMUQ@mail.gmail.com>
References: <1468619065-3222-1-git-send-email-keescook@chromium.org>
 <063D6719AE5E284EB5DD2968C1650D6D5F4FD6A3@AcuExch.aculab.com>
 <CAGXu5j+QH8Fdk7p6bZV_yMv1puHRxZRu5z45+tKrmLyGBTymFw@mail.gmail.com> <063D6719AE5E284EB5DD2968C1650D6D5F4FEA62@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:32839 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbcGTRor (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jul 2016 13:44:47 -0400
Received: by mail-wm0-f49.google.com with SMTP id p129so2185508wmp.0
        for <linux-arch@vger.kernel.org>; Wed, 20 Jul 2016 10:44:46 -0700 (PDT)
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D5F4FEA62@AcuExch.aculab.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Will Deacon <will.deacon@arm.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Christoph Lameter <cl@linux.com>, Andrea Arcangeli <aarcange@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, PaX Team <pageexec@freemail.hu>, Borislav Petkov <bp@suse.de>, Mathias Krause <minipli@googlemail.com>, Fenghua Yu <fenghua.yu@intel.com>, Rik van Riel <riel@redhat.com>, David

On Wed, Jul 20, 2016 at 9:02 AM, David Laight <David.Laight@aculab.com> wrote:
> From: Kees Cook
>> Sent: 20 July 2016 16:32
> ...
>> Yup: that's exactly what it's doing: walking up the stack. :)
>
> Remind me to make sure all our customers run kernels with it disabled.

What's your concern with stack walking?

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
