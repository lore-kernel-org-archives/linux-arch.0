Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-am1on0063.outbound.protection.outlook.com ([157.56.112.63]:4246
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751407AbcF2HXi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 29 Jun 2016 03:23:38 -0400
Subject: Re: [PATCH v4 00/29] virtually mapped stacks and thread_info cleanup
References: <cover.1466974736.git.luto@kernel.org>
From: =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <5773736D.40500@nextfour.com>
Date: Wed, 29 Jun 2016 10:06:21 +0300
MIME-Version: 1.0
In-Reply-To: <cover.1466974736.git.luto@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <20160629070621.mIk05r0PZSht2bo8KKsrhHXF-r_5mD6m9BfWB98dLwA@z>

On 06/27/2016 12:55 AM, Andy Lutomirski wrote:
> Hi all-
> 

> 
> Known issues:
>  - tcp md5, virtio_net, and virtio_console will have issues.  Eric Dumazet
>    has a patch for tcp md5, and Michael Tsirkin says he'll fix virtio_net
>    and virtio_console.
> 
 How about PTRACE_SETREGS, it's using the child stack's vmapped address to put regs?

--Mika


