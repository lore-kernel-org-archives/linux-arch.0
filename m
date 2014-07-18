From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3] arm64,ia64,ppc,s390,sh,tile,um,x86,mm: Remove default
 gate area
Date: Fri, 18 Jul 2014 11:36:54 -0700
Message-ID: <53C96946.4090304@zytor.com>
References: <70f331f59e620dc4e66bd3fa095e6f6b744b532b.1405281639.git.luto@amacapital.net> <CALCETrXG6nL4K=Er+kv5-CXBDVa0TLg9yR6iePnMyE2ufXgKkw@mail.gmail.com> <20140718101416.GB1818@arm.com> <53C8F4DF.8020103@nod.at> <CALCETrXve-=N5yzqDw2YQee4BmC6sb8GYWYJcV2780V38OuJiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <CALCETrXve-=N5yzqDw2YQee4BmC6sb8GYWYJcV2780V38OuJiQ@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Andy Lutomirski <luto@amacapital.net>, Richard Weinberger <richard@nod.at>, Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, linuxppc-dev@lists.ozlabs.org, Fenghua Yu <fenghua.yu@intel.com>, X86 ML <x86@kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Nathan Lynch <Nathan_Lynch@mentor.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Chris Metcalf <cmetcalf@t>
List-Id: linux-arch.vger.kernel.org

On 07/18/2014 09:53 AM, Andy Lutomirski wrote:
> 
> Splitting this will be annoying: I'd probably have to add a flag asking for
> the new behavior, update all the arches, then remove the flag.  The chance
> of screwing up bisectability in the process seems pretty high.  This seems
> like overkill for a patch that mostly deletes code.
> 
> Akpm, can you take this?
> 

I'm fine with it as-is.

Acked-by: H. Peter Anvin <hpa@linux.intel.com>


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
