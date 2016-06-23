Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55033 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425AbcFWRKm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Jun 2016 13:10:42 -0400
Date: Thu, 23 Jun 2016 19:10:37 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v3 00/13] Virtually mapped stacks with guard pages (x86,
 core)
Message-ID: <20160623171037.GB17372@redhat.com>
References: <cover.1466466093.git.luto@kernel.org>
 <CA+55aFyahpuy94qqECj0ZA6oD3Vy0r=gY2cH8_dB1a-4XURV2Q@mail.gmail.com>
 <CALCETrUuG0-tGNQ5iAEO2_gaK1eUq7AoALoBeQKcOP8cvxr=eA@mail.gmail.com>
 <CA+55aFx480bxx7VAmFqdsVGHjoSav4eCvVpcx5ZSpBQuq+=1Mw@mail.gmail.com>
 <20160623143126.GA16664@redhat.com>
 <CA+55aFwBL5ArLXZ0+YggTbp6Qon+OM+Foihe0yrQOmRRvu96VQ@mail.gmail.com>
 <CALCETrU2B0QYBgTTSAFiK026Bx96+Bk=k64bhrDT+TiXsV7D4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrU2B0QYBgTTSAFiK026Bx96+Bk=k64bhrDT+TiXsV7D4A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <20160623171037.Nts5KAsqs_0Liuf9_-U30Rfj6u9eoyLAEZ2sRWENX8g@z>

On 06/23, Andy Lutomirski wrote:
>
> That sounds a bit more fragile than I'm really comfortable with,
> although it'll at least oops reliably if we get it wrong.
>
> But I'm planning on moving ti->flags (and the rest of thread_info,
> either piecemeal or as a unit) into task_struct on architectures that
> opt in,

I agree, this looks better. probably it should not be that hard to fix
GET_THREAD_INFO/etc, but you know this much better than me.

Oleg.

