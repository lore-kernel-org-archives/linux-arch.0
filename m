From: Kees Cook <keescook@chromium.org>
Subject: Re: [patch V4 01/15] seccomp: Provide stub for __secure_computing()
Date: Tue, 21 Jul 2020 14:21:09 -0700
Message-ID: <202007211421.FE862FEE@keescook>
References: <20200721105706.030914876@linutronix.de>
 <20200721110808.348199175@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200721110808.348199175@linutronix.de>
Sender: kvm-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 21, 2020 at 12:57:07PM +0200, Thomas Gleixner wrote:
> To avoid #ifdeffery in the upcoming generic syscall entry work code provide
> a stub for __secure_computing() as this is preferred over
> secure_computing() because the TIF flag is already evaluated.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
