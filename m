From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/9] mm: Hardened usercopy
Date: Fri, 8 Jul 2016 10:46:39 +0200
Message-ID: <20160708084639.GA4562@gmail.com>
References: <1467843928-29351-1-git-send-email-keescook@chromium.org>
Reply-To: kernel-hardening@lists.openwall.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-hardening-return-3852-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Content-Disposition: inline
In-Reply-To: <1467843928-29351-1-git-send-email-keescook@chromium.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, "David S. Miller" <davem@davemloft.net>, x86@kernel.org, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>, Mathias Krause <minipli@googlemail.com>, Jan Kara <jack@suse.cz>, Vitaly
List-Id: linux-arch.vger.kernel.org


* Kees Cook <keescook@chromium.org> wrote:

> - I couldn't detect a measurable performance change with these features
>   enabled. Kernel build times were unchanged, hackbench was unchanged,
>   etc. I think we could flip this to "on by default" at some point.

Could you please try to find some syscall workload that does many small user 
copies and thus excercises this code path aggressively?

If that measurement works out fine then I'd prefer to enable these security checks 
by default.

Thaks,

	Ingo
