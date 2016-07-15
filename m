From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 11/11] mm: SLUB hardened usercopy support
Date: Thu, 14 Jul 2016 21:29:25 -0700
Message-ID: <CAGXu5j+Ub2-jmTa-XmF90Gd+ze1os+eqk_yijouCSQoLvU1hNQ@mail.gmail.com>
References: <1468446964-22213-1-git-send-email-keescook@chromium.org>
 <1468446964-22213-12-git-send-email-keescook@chromium.org> <20160715020550.GB13944@balbir.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20160715020550.GB13944@balbir.ozlabs.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Balbir Singh <bsingharora@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Rik van Riel <riel@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, "David S. Miller" <davem@davemloft.net>, "x86@kernel.org" <x86@kernel.org>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>, Mathias Krause <minipli@googlemail.com>, Ja
List-Id: linux-arch.vger.kernel.org

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

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
