From: Kees Cook <keescook@chromium.org>
Subject: Re: [patch V4 11/15] x86/entry: Use generic syscall exit
 functionality
Date: Tue, 21 Jul 2020 14:47:56 -0700
Message-ID: <202007211447.8F89234@keescook>
References: <20200721105706.030914876@linutronix.de>
 <20200721110809.432210708@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200721110809.432210708@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 21, 2020 at 12:57:17PM +0200, Thomas Gleixner wrote:
> Replace the x86 variant with the generic version. Provide the relevant
> architecture specific helper functions and defines.
> 
> Use a temporary define for idtentry_exit_user which will be cleaned up
> seperately.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
