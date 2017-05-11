From: "PaX Team" <pageexec@freemail.hu>
Subject: Re: [PATCH v4 2/2] x86/refcount: Implement fast refcount overflow protection
Date: Thu, 11 May 2017 03:24:34 +0200
Message-ID: <5913BD52.2305.3F7C9B7B@pageexec.freemail.hu>
References: <1494356483-81678-1-git-send-email-keescook@chromium.org>, <1494356483-81678-3-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <kernel-hardening-return-7850-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-reply-to: <1494356483-81678-3-git-send-email-keescook@chromium.org>
Content-description: Mail message body
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jannh@google.com>, Eric Biggers <ebiggers3@gmail.com>, Christoph Hellwig <hch@infradead.org>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartnership.com>, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>, "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Rik van Riel <riel@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, kernel-hardening@lists.openwall.com
List-Id: linux-arch.vger.kernel.org

On 9 May 2017 at 12:01, Kees Cook wrote:
> Various differences from PaX:
> - uses earlier value reset implementation in assembly
> - uses UD0 and refcount exception handler instead of new int vector
> - uses .text.unlikely instead of custom named text sections

all the above together result in bloating .text.unlikely and thus the
kernel image in general. the much bigger problem is that you introduced
a vulnerability because now refcount underflow bugs can not only trigger
a UAF but also a subsequent double-free since decrementing the saturation
value will not trigger any checks until 0 is reached a second time.

> - applied only to refcount_t, not atomic_t (single size, only overflow)

this description doesn't seem to be in sync with the code as the refcount
decrementing functions are also instrumented (and introduce the problem
mentioned above).

> - reorganized refcount error handler
> - uses "js" instead of "jo" to trap all negative results instead of
>   just under/overflow transitions

if you're describing differences to PaX in such detail you might as well
specify which version of PaX it is different from and credit the above idea
to me lest someone get the impression that it was yours.

> +static __always_inline __must_check bool refcount_inc_not_zero(refcount_t *r)
> +{
> +	int c;
> +
> +	c = atomic_read(&(r->refs));
> +	do {
> +		if (unlikely(c <= 0))
> +			break;
> +	} while (!atomic_try_cmpxchg(&(r->refs), &c, c + 1));
> +
> +	/* Did we start or finish in an undesirable state? */
> +	if (unlikely(c <= 0 || c + 1 < 0)) {

while -fno-strict-overflow should save you in linux it's still not
prudent programming to rely on signed overflow, especially in security
related checks. it's just too fragile and sets a bad example...
