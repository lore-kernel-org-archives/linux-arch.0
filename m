From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: [PATCH 5/23] make section names compatible with -ffunction-sections -fdata-sections: blackfin
Date: Tue, 1 Jul 2008 18:58:02 -0400
Message-ID: <8bd0f97a0807011558u2c02f6fcre2f3af3d5cced936@mail.gmail.com>
References: <200807020235.08025.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <200807020235.08025.vda.linux@googlemail.com>
Content-Disposition: inline
Sender: linux-embedded-owner@vger.kernel.org
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Lennert Buytenhek <kernel@wantstofly.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>, Andi Kleen <andi@firstfloor.org>, torvalds@linux-foundation.org, akpm@linux-foundation.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Miller <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 1, 2008 at 8:35 PM, Denys Vlasenko wrote:
> The purpose of this patch is to make kernel buildable
> with "gcc -ffunction-sections -fdata-sections".
> This patch fixes blackfin architecture.

the comment right above what you changed says it already works for
Blackfin.  so you arent fixing it at all.
>                /* This gets done first, so the glob doesn't suck it in */
>                . = ALIGN(32);
> -               *(.data.cacheline_aligned)
> +               *(.cacheline_aligned.data)

ive built Blackfin kernels with function/data sections a long time ago
... but iirc, there were toolchain problems, so i havent pursued it
since.

if you're going to muck with names, you might as well do it right the
first time: move the names into asm-generic/vmlinux.lds.h so we dont
have to worry about this kind of churn again.
-mike
