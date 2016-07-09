From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 0/9] mm: Hardened usercopy
Date: Sat, 9 Jul 2016 14:27:25 -0700
Message-ID: <CALCETrU5Emr7jZNH5bh7Z+C8fLOcAah9SzeJbDjqW7N-xWGxHA@mail.gmail.com>
References: <1467843928-29351-1-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <1467843928-29351-1-git-send-email-keescook@chromium.org>
Sender: sparclinux-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, Brad Spengler <spender@grsecurity.net>, Pekka Enberg <penberg@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Casey Schaufler <casey@schaufler-ca.com>, Will Deacon <will.deacon@arm.com>, Rik van Riel <riel@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dmitry Vyukov <dvyukov@google.com>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, X86 ML <x86@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-arch <linux-arch@vger.kernel.org>, David Rientjes <rientjes@google.com>, Mathias Krause <minipli@googlemail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, "David S. Miller" <davem@davemloft.net>, Laura Abbott <labbott@fedoraproject.or>
List-Id: linux-arch.vger.kernel.org

On Jul 6, 2016 6:25 PM, "Kees Cook" <keescook@chromium.org> wrote:
>
> Hi,
>
> This is a start of the mainline port of PAX_USERCOPY[1]. After I started
> writing tests (now in lkdtm in -next) for Casey's earlier port[2], I
> kept tweaking things further and further until I ended up with a whole
> new patch series. To that end, I took Rik's feedback and made a number
> of other changes and clean-ups as well.
>

I like the series, but I have one minor nit to pick.  The effect of
this series is to harden usercopy, but most of the code is really
about infrastructure to validate that a pointed-to object is valid.
Might it make sense to call the infrastructure part something else?
After all, this could be extended in the future for memcpy or even for
some GCC plugin to check pointers passed to ordinary (non-allocator)
functions.
