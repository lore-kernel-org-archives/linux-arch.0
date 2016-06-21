Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:54480 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbcFUJaM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2016 05:30:12 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 00/13] Virtually mapped stacks with guard pages (x86, core)
Date: Tue, 21 Jun 2016 11:24:18 +0200
Message-ID: <13212319.WrhLzgRA6Z@wuerfel>
In-Reply-To: <cover.1466466093.git.luto@kernel.org>
References: <cover.1466466093.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <20160621092418._tzFJxAtyygYMD7kbGjeiwOvuOfne2efV-y_T8acFm4@z>

On Monday, June 20, 2016 4:43:30 PM CEST Andy Lutomirski wrote:
> 
> On my laptop, this adds about 1.5µs of overhead to task creation,
> which seems to be mainly caused by vmalloc inefficiently allocating
> individual pages even when a higher-order page is available on the
> freelist.

Would it help to have a fixed virtual address for the stack instead
and map the current stack to that during a task switch, similar to
how we handle fixmap pages?

That would of course trade the allocation overhead for a task switch
overhead, which may be better or worse. It would also give "current"
a constant address, which may give a small performance advantage
but may also introduce a new attack vector unless we randomize it
again.

	Arnd
