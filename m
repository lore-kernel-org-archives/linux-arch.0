From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4 8/8] x86, vdso: mark vDSO read-only after init
Date: Tue, 19 Jan 2016 11:09:06 -0800
Message-ID: <CALCETrVBbJROcYPmhAnOsjM6WCrY4+fhxCC75G1xz1bYawBNpw@mail.gmail.com>
References: <1453226922-16831-1-git-send-email-keescook@chromium.org> <1453226922-16831-9-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:36071 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932632AbcASTJ0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2016 14:09:26 -0500
Received: by mail-ob0-f175.google.com with SMTP id ba1so607004693obb.3
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2016 11:09:26 -0800 (PST)
In-Reply-To: <1453226922-16831-9-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Michael Ellerman <mpe@ellerman.id.au>, Mathias Krause <minipli@googlemail.com>, Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, PaX Team <pageexec@freemail.hu>, Emese Revfy <re.emese@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Tue, Jan 19, 2016 at 10:08 AM, Kees Cook <keescook@chromium.org> wrote:
> The vDSO does not need to be writable after __init, so mark it as
> __ro_after_init. The result kills the exploit method of writing to the
> vDSO from kernel space resulting in userspace executing the modified code,
> as shown here to bypass SMEP restrictions: http://itszn.com/blog/?p=21
>
> The memory map (with added vDSO address reporting) shows the vDSO moving
> into read-only memory:

Acked-by: Andy Lutomirski <luto@kernel.org>
