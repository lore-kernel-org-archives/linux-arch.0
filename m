Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfDDO2J (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Apr 2019 10:28:09 -0400
Date: Thu, 4 Apr 2019 10:28:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 4/6 v3] csky: Fix syscall_get_arguments() and
 syscall_set_arguments()
Message-ID: <20190404102805.56f5f168@gandalf.local.home>
In-Reply-To: <20190404140200.GB4962@altlinux.org>
References: <20190401134104.676620247@goodmis.org>
        <20190401134421.121919570@goodmis.org>
        <20190404140200.GB4962@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Palmer Dabbelt <palmer@sifive.com>, Will Drewry <wad@chromium.org>, Guo Ren <guoren@kernel.org>
Message-ID: <20190404142805.0ZF8Sm8DfW5rROuvqgJMCcHSsYkPRDFO9SiGzc4_U-w@z>

On Thu, 4 Apr 2019 17:02:01 +0300
"Dmitry V. Levin" <ldv@altlinux.org> wrote:
> According to
> https://lore.kernel.org/lkml/20190330004949.GA15705@guoren-Inspiron-7460/
> the following tags could be added to this patch:
> 
> Tested-by: Guo Ren <ren_guo@c-sky.com>
> Acked-by: Guo Ren <ren_guo@c-sky.com>

Thanks! Added.

-- Steve
