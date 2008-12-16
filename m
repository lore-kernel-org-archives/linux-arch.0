From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] allow bug table entries to use relative pointers (and
	use it on x86-64)
Date: Tue, 16 Dec 2008 18:40:48 +0100
Message-ID: <20081216174048.GH11683@elte.hu>
References: <4947A1BB.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:38795 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751078AbYLPRlA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 16 Dec 2008 12:41:00 -0500
Content-Disposition: inline
In-Reply-To: <4947A1BB.76E4.0078.0@novell.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jan Beulich <jbeulich@novell.com>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com, linux-arch@vger.kernel.org


* Jan Beulich <jbeulich@novell.com> wrote:

> This allows reducing the bug table size by half. Perhaps there are
> other 64-bit architectures that could also make use of this.
> 
> Signed-off-by: Jan Beulich <jbeulich@novell.com>
> 
> ---
>  arch/x86/Kconfig           |    4 ++++
>  arch/x86/include/asm/bug.h |    2 +-
>  include/asm-generic/bug.h  |    8 ++++++++
>  lib/bug.c                  |   19 +++++++++++++++++--
>  4 files changed, 30 insertions(+), 3 deletions(-)

applied to tip/x86/debug, thanks Jan!

	Ingo
