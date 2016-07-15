Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37774 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbcGOE31 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jul 2016 00:29:27 -0400
Received: by mail-wm0-f43.google.com with SMTP id i5so12640716wmg.0
        for <linux-arch@vger.kernel.org>; Thu, 14 Jul 2016 21:29:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160715020550.GB13944@balbir.ozlabs.ibm.com>
References: <1468446964-22213-1-git-send-email-keescook@chromium.org>
 <1468446964-22213-12-git-send-email-keescook@chromium.org> <20160715020550.GB13944@balbir.ozlabs.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 14 Jul 2016 21:29:25 -0700
Message-ID: <CAGXu5j+Ub2-jmTa-XmF90Gd+ze1os+eqk_yijouCSQoLvU1hNQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] mm: SLUB hardened usercopy support
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Rik van Riel <riel@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, "David S. Miller" <davem@davemloft.net>, "x86@kernel.org" <x86@kernel.org>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>, Mathias Krause <minipli@googlemail.com>, Jan Kara <jack@suse.cz>, Vitaly Wool <vitalywool@gmail.com>, Andrea Arcangeli <aarcange@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, Laura Abbott <labbott@fedoraproject.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-ia64@vger.kernel.org, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, sparclinux <sparclinux@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
Message-ID: <20160715042925.-TR00JW-gBTRCBszXDsclut5lb8MI4mUS_4ZG6CqsLA@z>

On Thu, Jul 14, 2016 at 7:05 PM, Balbir Singh <bsingharora@gmail.com> wrote:
> On Wed, Jul 13, 2016 at 02:56:04PM -0700, Kees Cook wrote:
>> Under CONFIG_HARDENED_USERCOPY, this adds object size checking to the
>> SLUB allocator to catch any copies that may span objects. Includes a
>> redzone handling fix from Michael Ellerman.
>>
>> Based on code from PaX and grsecurity.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  init/Kconfig |  1 +
>>  mm/slub.c    | 36 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 37 insertions(+)
>>
>> diff --git a/init/Kconfig b/init/Kconfig
>> index 798c2020ee7c..1c4711819dfd 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -1765,6 +1765,7 @@ config SLAB
>>
>>  config SLUB
>>       bool "SLUB (Unqueued Allocator)"
>> +     select HAVE_HARDENED_USERCOPY_ALLOCATOR
>
> Should this patch come in earlier from a build perspective? I think
> patch 1 introduces and uses __check_heap_object.

__check_heap_object in patch 1 is protected by a check for
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR.

It seemed better to be to do arch enablement first, and then add the
per-allocator heap object size check since it was a distinct piece.
I'm happy to rearrange things, though, if there's a good reason.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
