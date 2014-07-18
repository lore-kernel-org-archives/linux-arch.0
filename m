From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v3] arm64,ia64,ppc,s390,sh,tile,um,x86,mm: Remove default
 gate area
Date: Fri, 18 Jul 2014 12:20:15 +0200
Message-ID: <53C8F4DF.8020103@nod.at>
References: <70f331f59e620dc4e66bd3fa095e6f6b744b532b.1405281639.git.luto@amacapital.net> <CALCETrXG6nL4K=Er+kv5-CXBDVa0TLg9yR6iePnMyE2ufXgKkw@mail.gmail.com> <20140718101416.GB1818@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20140718101416.GB1818@arm.com>
Sender: owner-linux-mm@kvack.org
To: Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@amacapital.net>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, Chris Metcalf <cmetcalf@tilera.com>, Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Nathan Lynch <Nathan_Lynch@mentor.com>, X86 ML <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: linux-arch.vger.kernel.org

Am 18.07.2014 12:14, schrieb Will Deacon:
> On Tue, Jul 15, 2014 at 03:47:26PM +0100, Andy Lutomirski wrote:
>> On Sun, Jul 13, 2014 at 1:01 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>> The core mm code will provide a default gate area based on
>>> FIXADDR_USER_START and FIXADDR_USER_END if
>>> !defined(__HAVE_ARCH_GATE_AREA) && defined(AT_SYSINFO_EHDR).
>>>
>>> This default is only useful for ia64.  arm64, ppc, s390, sh, tile,
>>> 64-bit UML, and x86_32 have their own code just to disable it.  arm,
>>> 32-bit UML, and x86_64 have gate areas, but they have their own
>>> implementations.
>>>
>>> This gets rid of the default and moves the code into ia64.
>>>
>>> This should save some code on architectures without a gate area: it's
>>> now possible to inline the gate_area functions in the default case.
>>
>> Can one of you pull this somewhere?  Otherwise I can put it somewhere
>> stable and ask for -next inclusion, but that seems like overkill for a
>> single patch.

For the um bits:
Acked-by: Richard Weinberger <richard@nod.at>

> I'd be happy to take the arm64 part, but it doesn't feel right for mm/*
> changes (or changes to other archs) to go via our tree.
> 
> I'm not sure what the best approach is if you want to send this via a single
> tree. Maybe you could ask akpm nicely?

Going though Andrew's tree sounds sane to me.

Thanks,
//richard

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
