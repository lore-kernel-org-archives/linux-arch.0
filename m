From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: [PATCH] (updated, rolled up) make section names compatible with -ffunction-sections -fdata-sections
Date: Thu, 17 Jul 2008 21:15:21 -0400
Message-ID: <8bd0f97a0807171815x69185d2bnca3b410caf0a8afe@mail.gmail.com>
References: <200807172213.37411.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <200807172213.37411.vda.linux@googlemail.com>
Content-Disposition: inline
Sender: linux-embedded-owner@vger.kernel.org
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, mingo@elte.hu, x86@kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Lennert Buytenhek <kernel@wantstofly.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>, Andi Kleen <andi@firstfloor.org>, torvalds@linux-foundation.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Miller <davem@davemloft.net>, Linux Arch Maintainers <linux-arch@vger.kernel.org>, Bryan Wu <cooloney@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 17, 2008 at 4:13 PM, Denys Vlasenko
<vda.linux@googlemail.com> wrote:
> Hi Andrew,
>
> Here is the update against current Linus tree,
> rolled up into one patch.
>
> James Bottomley suggested a different naming scheme:
> instead of swapping parts (.text.head -> .head.text),
> prepend .kernel to our special section names.
> This patch implements his idea.
>
> ppc and v850 are dropped per comments from arch people.
> parisc and x86 had minor fixes. x86 fix added proper
> executable bits to a section:
>
> -.section ".text.head"
> +.section ".kernel.text.head","ax",@progbits
>
> Does arch/m68k/kernel/sun3-head.S need the same fix?
>
> The patch is run-tested on x86_64.
>
> I would like to ask arch maintainers to ACK/NAK this patch,
> and Andrew to act accordingly.

the Blackfin piece is just one line and shouldnt be a problem from our
side.  thanks.

btw, arch maintainers have an alias "linux-arch@vger.kernel.org" ...
but it doesnt appear to be in MAINTAINERS ?
-mike
