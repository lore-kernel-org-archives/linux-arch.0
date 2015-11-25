Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:53805 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbbKYKMM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Nov 2015 05:12:12 -0500
Subject: Re: [kernel-hardening] [PATCH 0/2] introduce post-init read-only
 memory
References: <1448401114-24650-1-git-send-email-keescook@chromium.org>
 <CA+rthh-euk2hGGWjsDqXogWSmzmJNV1aiUVfnTfrzyQhndgbOQ@mail.gmail.com>
From: Clemens Ladisch <clemens@ladisch.de>
Message-ID: <56558826.1060202@ladisch.de>
Date: Wed, 25 Nov 2015 11:06:30 +0100
MIME-Version: 1.0
In-Reply-To: <CA+rthh-euk2hGGWjsDqXogWSmzmJNV1aiUVfnTfrzyQhndgbOQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathias Krause <minipli@googlemail.com>, kernel-hardening@lists.openwall.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86-ml <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org, PaX Team <pageexec@freemail.hu>, Emese Revfy <re.emese@gmail.com>
Message-ID: <20151125100630.3TDsq2FTo9f0r9NfNuyzQyeIYlPabkU_zbgJ0ebTBrE@z>

Mathias Krause wrote:
> [...]
> So, prior extending the usage of the __read_only annotation some
> toolchain support is needed. Maybe a gcc plugin that'll warn/error on
> code that writes to such a variable but is not __init itself.

Or mark them as "const".  This would require the initialization code to
cast it away, probably with a helper macro.


Regards,
Clemens
