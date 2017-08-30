From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 5/5] kernel: tracepoints: add support for relative
 references
Date: Wed, 30 Aug 2017 14:13:51 -0400
Message-ID: <20170830141351.352baabe@gandalf.local.home>
References: <20170819181035.969-1-ard.biesheuvel@linaro.org>
        <20170819181035.969-6-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751470AbdH3SN4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 30 Aug 2017 14:13:56 -0400
In-Reply-To: <20170819181035.969-6-ard.biesheuvel@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nico@linaro.org>Martin Schwidefsky <sc>

On Sat, 19 Aug 2017 19:10:35 +0100
Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> To avoid the need for relocating absolute references to tracepoint
> structures at boot time when running relocatable kernels (which may
> take a disproportionate amount of space), add the option to emit
> these tables as relative references instead.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>

I ran this through various tests (not my full test suite mind you), and
it appears to work as it has before.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
