From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: [PATCH 5/23] make section names compatible with -ffunction-sections -fdata-sections: blackfin
Date: Tue, 1 Jul 2008 22:09:20 -0400
Message-ID: <8bd0f97a0807011909i53a347f5me4410a24dd27d5ab@mail.gmail.com>
References: <200807020235.08025.vda.linux@googlemail.com>
	 <8bd0f97a0807011558u2c02f6fcre2f3af3d5cced936@mail.gmail.com>
	 <200807020208.33302.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <200807020208.33302.vda.linux@googlemail.com>
Content-Disposition: inline
Sender: linux-embedded-owner@vger.kernel.org
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Lennert Buytenhek <kernel@wantstofly.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>, Andi Kleen <andi@firstfloor.org>, torvalds@linux-foundation.org, akpm@linux-foundation.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Miller <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 1, 2008 at 8:08 PM, Denys Vlasenko wrote:
> On Wednesday 02 July 2008 00:58, Mike Frysinger wrote:
>> On Tue, Jul 1, 2008 at 8:35 PM, Denys Vlasenko wrote:
>> > The purpose of this patch is to make kernel buildable
>> > with "gcc -ffunction-sections -fdata-sections".
>> > This patch fixes blackfin architecture.
>>
>> the comment right above what you changed says it already works for
>> Blackfin.  so you arent fixing it at all.
>> >                /* This gets done first, so the glob doesn't suck it in */
>> >                . = ALIGN(32);
>> > -               *(.data.cacheline_aligned)
>> > +               *(.cacheline_aligned.data)
>
> This may pull in an unrelated data object named "cacheline_aligned"
> (say, a static variable in a driver). If that variable is not
> itself aligned to the cacheline size, it will mess up alignment of all
> objects in .data.cacheline_aligned which follow. Not good.
>
> To be safe from such weird and hard to debug problems
> it's better to not use names like .data.XXXX at all.
> I just uniformly renamed al such "special sections"
> in the kernel to .XXXXX.data

you're right of course ... i obviously hadnt thought of this.  please
however still abstract this stuff into the common header.

i just tested the current Blackfin kernel and it does build/link/run
fine with -ffunction-sections/-fdata-sections.  however, --gc-sections
still causes crashes (but this is because all of the .init.setup
sections are flagged as unused).
-mike
