From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2 01/11] mm: Implement stack frame object validation
Date: Wed, 13 Jul 2016 15:01:28 -0700
Message-ID: <CALCETrVDJDjdoh7yvOPd=_5twQnzQRhe8G2KLaRw-NnA1Uf__g@mail.gmail.com>
References: <1468446964-22213-1-git-send-email-keescook@chromium.org> <1468446964-22213-2-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1468446964-22213-2-git-send-email-keescook@chromium.org>
Sender: owner-linux-mm@kvack.org
To: Kees Cook <keescook@chromium.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rik van Riel <riel@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, "David S. Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>, Mathias Krause <minipli@googl>
List-Id: linux-arch.vger.kernel.org

On Wed, Jul 13, 2016 at 2:55 PM, Kees Cook <keescook@chromium.org> wrote:
> This creates per-architecture function arch_within_stack_frames() that
> should validate if a given object is contained by a kernel stack frame.
> Initial implementation is on x86.
>
> This is based on code from PaX.
>

This, along with Josh's livepatch work, are two examples of unwinders
that matter for correctness instead of just debugging.  ISTM this
should just use Josh's code directly once it's been written.

--Andy

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
