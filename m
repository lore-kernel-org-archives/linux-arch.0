From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [kernel-hardening] [PATCH v2 11/11] mm: SLUB hardened usercopy support
Date: Thu, 14 Jul 2016 20:07:01 +1000
Message-ID: <5787644c.9774240a.3c534.451eSMTPIN_ADDED_BROKEN@mx.google.com>
References: <1468446964-22213-1-git-send-email-keescook@chromium.org> <1468446964-22213-12-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1468446964-22213-12-git-send-email-keescook@chromium.org>
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Rik van Riel <riel@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, "David S. Miller" <davem@davemloft.net>, x86@kernel.org, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>, Mathias Krause <minipli@googlemail.com>, Jan Kara <jack@suse.cz>, Vitaly Wool <vitalywool@gmail.com>Andr
List-Id: linux-arch.vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> Under CONFIG_HARDENED_USERCOPY, this adds object size checking to the
> SLUB allocator to catch any copies that may span objects. Includes a
> redzone handling fix from Michael Ellerman.

Actually I think you wrote the fix, I just pointed you in that
direction. But anyway, this works for me, so if you like:

Tested-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
