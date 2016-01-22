Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34208 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938AbcAVRT6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jan 2016 12:19:58 -0500
Received: by mail-oi0-f50.google.com with SMTP id k206so52045625oia.1
        for <linux-arch@vger.kernel.org>; Fri, 22 Jan 2016 09:19:57 -0800 (PST)
Date: Fri, 22 Jan 2016 10:19:54 -0700
From: David Brown <david.brown@linaro.org>
Subject: Re: [kernel-hardening] [PATCH v4 0/8] introduce post-init read-only
 memory
Message-ID: <20160122171954.GA3945@davidb.org>
References: <1453226922-16831-1-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1453226922-16831-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kernel-hardening@lists.openwall.com
Cc: Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, "H. Peter Anvin" <hpa@zytor.com>, Michael Ellerman <mpe@ellerman.id.au>, Mathias Krause <minipli@googlemail.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, PaX Team <pageexec@freemail.hu>, Emese Revfy <re.emese@gmail.com>, linux-kernel@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Laura Abbott <lauraa@codeaurora.org>
Message-ID: <20160122171954.EmocBYQDbfKoYyzYGi72GbRfe0b5WRYW5kcS0tlvvFg@z>

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
