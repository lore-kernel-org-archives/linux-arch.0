Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:48730 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfHQJQu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 17 Aug 2019 05:16:50 -0400
Date: Sat, 17 Aug 2019 11:17:33 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v8 06/28] x86/asm/crypto: annotate local functions
Message-ID: <20190817091733.GB15364@zn.tnic>
References: <20190808103854.6192-1-jslaby@suse.cz>
 <20190808103854.6192-7-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190808103854.6192-7-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
Message-ID: <20190817091733.6DD0ZSenPtyjziOX5uklIrCjYY__taTlN76MqMA6k0k@z>

On Thu, Aug 08, 2019 at 12:38:32PM +0200, Jiri Slaby wrote:
> Use the newly added SYM_FUNC_START_LOCAL to annotate starts of all
> functions which do not have ".globl" annotation, but their ends are
> annotated by ENDPROC. This is needed to balance ENDPROC for tools that
> generate debuginfo.
> 
> To be symmetric, we also convert their ENDPROCs to the new SYM_FUNC_END.

All those functions look like they could be made local symbols by
prepending their names with ".L" so that they disappear from the
vmlinux symtable too.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
