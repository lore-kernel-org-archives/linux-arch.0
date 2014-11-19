Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44374 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754717AbaKSMlo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 19 Nov 2014 07:41:44 -0500
Date: Wed, 19 Nov 2014 13:40:58 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCHv8 1/4] syscalls,x86: implement execveat() system call
In-Reply-To: <1415982183-20525-2-git-send-email-drysdale@google.com>
Message-ID: <alpine.DEB.2.11.1411191249560.3909@nanos>
References: <1415982183-20525-1-git-send-email-drysdale@google.com> <1415982183-20525-2-git-send-email-drysdale@google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Drysdale <drysdale@google.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andy Lutomirski <luto@amacapital.net>, Alexander Viro <viro@zeniv.linux.org.uk>, Meredydd Luff <meredydd@senatehouse.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Oleg Nesterov <oleg@redhat.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@aerifal.cx>, Christoph Hellwig <hch@infradead.org>, x86@kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, sparclinux@vger.kernel.org
Message-ID: <20141119124058.eByWMxJWZfU6FiM_89sRqXUn1cmPiNfOC3Qm6IhbasM@z>

On Fri, 14 Nov 2014, David Drysdale wrote:
> Only x86-64, i386 and x32 ABIs are supported in this patch.

Can you please split this into the core/fs changes and the actual x86
hookup?
 
Thanks,

	tglx
