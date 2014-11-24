Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38113 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbaKXMq4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Nov 2014 07:46:56 -0500
Date: Mon, 24 Nov 2014 13:45:57 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCHv10 2/5] x86: Hook up execveat system call.
In-Reply-To: <1416830039-21952-3-git-send-email-drysdale@google.com>
Message-ID: <alpine.DEB.2.11.1411241345470.6439@nanos>
References: <1416830039-21952-1-git-send-email-drysdale@google.com> <1416830039-21952-3-git-send-email-drysdale@google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Drysdale <drysdale@google.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andy Lutomirski <luto@amacapital.net>, Alexander Viro <viro@zeniv.linux.org.uk>, Meredydd Luff <meredydd@senatehouse.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Stephen Rothwell <sfr@canb.auug.org.au>, Oleg Nesterov <oleg@redhat.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@aerifal.cx>, Christoph Hellwig <hch@infradead.org>, x86@kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, sparclinux@vger.kernel.org
Message-ID: <20141124124557.aNXQouG9agMSXhfRnjxSZG6DxPL7oLXWmWMxxtpz6tY@z>

On Mon, 24 Nov 2014, David Drysdale wrote:

> Hook up x86-64, i386 and x32 ABIs.
> 
> Signed-off-by: David Drysdale <drysdale@google.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
