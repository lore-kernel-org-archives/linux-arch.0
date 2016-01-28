Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34252 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934227AbcA1AIv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jan 2016 19:08:51 -0500
Received: by mail-oi0-f54.google.com with SMTP id k206so16697293oia.1
        for <linux-arch@vger.kernel.org>; Wed, 27 Jan 2016 16:08:51 -0800 (PST)
Date: Wed, 27 Jan 2016 17:09:06 -0700
From: David Brown <david.brown@linaro.org>
Subject: [PATCH] arm64: make CONFIG_DEBUG_RODATA non-optional
Message-ID: <20160128000906.GA42530@davidb.org>
References: <1453226922-16831-1-git-send-email-keescook@chromium.org>
 <1453226922-16831-4-git-send-email-keescook@chromium.org>
 <20160127211105.GA41450@davidb.org>
 <CAGXu5j+DLRoVE88a9++jVfEkN90HDiAaDAMnT2TrKqtMZ_yOww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAGXu5j+DLRoVE88a9++jVfEkN90HDiAaDAMnT2TrKqtMZ_yOww@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@amacapital.net>, "H. Peter Anvin" <hpa@zytor.com>, Michael Ellerman <mpe@ellerman.id.au>, Mathias Krause <minipli@googlemail.com>, Thomas Gleixner <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, PaX Team <pageexec@freemail.hu>, Emese Revfy <re.emese@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, yalin wang <yalin.wang2010@gmail.com>, Zi Shen Lim <zlim.lnx@gmail.com>, Yang Shi <yang.shi@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Laura Abbott <lauraa@codeaurora.org>, "Suzuki K. Poulose" <suzuki.poulose@arm.com>, Steve Capper <steve.capper@linaro.org>, Jeremy Linton <jeremy.linton@arm.com>, Mark Salter <msalter@redhat.com>, linux-arm-kernel@lists.infradead.org
Message-ID: <20160128000906.JCHyv-YbR3tZbIaijaw7D_xFQiAqHdmhvxapJJrQ3lw@z>
