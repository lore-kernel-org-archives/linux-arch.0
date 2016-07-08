From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/9] mm: Hardened usercopy
Date: Fri, 8 Jul 2016 09:19:04 -0700
Message-ID: <CA+55aFzv4kQitzhWgxRAi5XXM30f70d4dbTGkr7t=fZSh4r3Ow@mail.gmail.com>
References: <1467843928-29351-1-git-send-email-keescook@chromium.org> <20160708084639.GA4562@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <20160708084639.GA4562@gmail.com>
Sender: linux-ia64-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rik van Riel <riel@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, "David S. Miller" <davem@davemloft.net>, the arch/x86 maintainers <x86@kernel.org>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Borisla
List-Id: linux-arch.vger.kernel.org

On Fri, Jul 8, 2016 at 1:46 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> Could you please try to find some syscall workload that does many small user
> copies and thus excercises this code path aggressively?

Any stat()-heavy path will hit cp_new_stat() very heavily. Think the
usual kind of "traverse the whole tree looking for something". "git
diff" will do it, just checking that everything is up-to-date.

That said, other things tend to dominate.

                 Linus
