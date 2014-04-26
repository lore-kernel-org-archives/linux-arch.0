From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Dirty/Access bits vs. page content
Date: Fri, 25 Apr 2014 20:48:13 -0700
Message-ID: <CA+55aFw_iOw83ntoHJa6pq5ec9JuGjXEt7d9+jDdKGYM2t9V0g@mail.gmail.com>
References: <53558507.9050703@zytor.com>
	<CA+55aFzM+NpE-EzJdDeYX=cqWRzkGv9o-vybDR=oFtDLMRK-mA@mail.gmail.com>
	<alpine.LSU.2.11.1404221847120.1759@eggly.anvils>
	<20140423184145.GH17824@quack.suse.cz>
	<CA+55aFwm9BT4ecXF7dD+OM0-+1Wz5vd4ts44hOkS8JdQ74SLZQ@mail.gmail.com>
	<20140424065133.GX26782@laptop.programming.kicks-ass.net>
	<alpine.LSU.2.11.1404241110160.2443@eggly.anvils>
	<CA+55aFwVgCshsVHNqr2EA1aFY18A2L17gNj0wtgHB39qLErTrg@mail.gmail.com>
	<alpine.LSU.2.11.1404241252520.3455@eggly.anvils>
	<CA+55aFyUyD_BASjhig9OPerYcMrUgYJUfRLA9JyB_x7anV1d7Q@mail.gmail.com>
	<1398389846.8437.6.camel@pasglop>
	<1398393700.8437.22.camel@pasglop>
	<CA+55aFyO+-GehPiOAPy7-N0ejFrsNupWHG+j5hAs=R=RuPQtDg@mail.gmail.com>
	<5359CD7C.5020604@zytor.com>
	<CA+55aFzktDDr5zNh-7gDhXW6-7_BP_MvKHEoLi9=td6XvwzaUA@mail.gmail.com>
	<alpine.LSU.2.11.1404250414590.5198@eggly.anvils>
	<535A9356.8060608@intel.com>
	<alpine.LSU.2.11.1404251138050.5909@eggly.anvils>
	<535ADAFD.9040308@intel.com>
	<alpine.LSU.2.11.1404251956570.990@eggly.anvils>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <alpine.LSU.2.11.1404251956570.990@eggly.anvils>
Sender: owner-linux-mm@kvack.org
To: Hugh Dickins <hughd@google.com>
Cc: Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Apr 25, 2014 at 8:11 PM, Hugh Dickins <hughd@google.com> wrote:
>
> So here is my alternative to Linus's "split 'tlb_flush_mmu()'" patch.
> I don't really have a preference between the two approaches, and it
> looks like Linus is now happy with his, so I don't expect this one to
> go anywhere; unless someone else can see a significant advantage to it.

Hmm. I like that it's smaller and doesn't need any arch support.

I really dislike that 'details.mutex_is_held' flag, though. I dislike
pretty much *all* of details, but that one just bugs me extra much,
because it's basically static call chain information, and it really
smells like it should be possible to just do this all in the (few)
callers instead of having a flag about the one caller that did it.

In general, I hate conditional locking.  And here the conditionals are
getting pretty odd and complex.

             Linus

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
