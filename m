From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 0/2] introduce post-init read-only memory
Date: Tue, 24 Nov 2015 13:38:32 -0800
Message-ID: <1448401114-24650-1-git-send-email-keescook@chromium.org>
Reply-To: kernel-hardening@lists.openwall.com
Return-path: <kernel-hardening-return-1952-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org, kernel-hardening@lists.openwall.com
List-Id: linux-arch.vger.kernel.org

One of the easiest ways to protect the kernel from attack is to reduce
the internal attack surface exposed when a "write" flaw is available. By
making as much of the kernel read-only as possible, we reduce the
attack surface.

Many things are written to only during __init, and never changed
again. These cannot be made "const" since the compiler will do the wrong
thing (we do actually need to write to them). Instead, move these items
into a memory region that will be made read-only during mark_rodata_ro()
which happens after all kernel __init code has finished.

This introduces __read_only as a way to mark such memory, and uses it on
the x86 vDSO to kill an extant kernel exploitation method.

-Kees
