From: David Brown <david.brown@linaro.org>
Subject: Re: [PATCH v4 0/8] introduce post-init read-only
 memory
Date: Fri, 22 Jan 2016 10:19:54 -0700
Message-ID: <20160122171954.GA3945@davidb.org>
References: <1453226922-16831-1-git-send-email-keescook@chromium.org>
Reply-To: kernel-hardening@lists.openwall.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <kernel-hardening-return-2426-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Content-Disposition: inline
In-Reply-To: <1453226922-16831-1-git-send-email-keescook@chromium.org>
To: kernel-hardening@lists.openwall.com
Cc: Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, "H. Peter Anvin" <hpa@zytor.com>, Michael Ellerman <mpe@ellerman.id.au>, Mathias Krause <minipli@googlemail.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, PaX Team <pageexec@freemail.hu>, Emese Revfy <re.emese@gmail.com>, linux-kernel@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Laura Abbott <lauraa@codeaurora.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 19, 2016 at 10:08:34AM -0800, Kees Cook wrote:

>This introduces __ro_after_init as a way to mark such memory, and uses
>it on the x86 vDSO to kill an extant kernel exploitation method. Also
>adds a new kernel parameter to help debug future use and adds an lkdtm
>test to check the results.

I've tested these patches on 32-bit ARM using the provoke-crashes
test.  However, they do require CONFIG_ARM_KERNMEM_PERMS to be enabled
as well, which does incur additional memory usage.

Do we want to consider making CONFIG_ARM_KERNMEM_PERMS default y for
security reasons, and just document that memory-constrained systems
may want to turn it off?

I'll test the arm64 next.

David
