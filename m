From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
Date: Fri, 3 Aug 2018 17:09:45 +0200
Message-ID: <20180803150945.GC9297@kroah.com>
References: <cover.1529507994.git.andreyknvl@google.com>
 <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
 <20180626172900.ufclp2pfrhwkxjco@armageddon.cambridge.arm.com>
 <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com>
 <CAAeHK+wJbbCZd+-X=9oeJgsqQJiq8h+Aagz3SQMPaAzCD+pvFw@mail.gmail.com>
 <CAAeHK+yWF05XoU+0iuJoXAL3cWgdtxbeLoBz169yP12W4LkcQw@mail.gmail.com>
 <20180801174256.5mbyf33eszml4nmu@armageddon.cambridge.arm.com>
 <CAAeHK+zb7vcehuX9=oxLUJVJr1ZcgmRTODQz7wsPy+rJb=3kbQ@mail.gmail.com>
 <CAAeHK+xTxPhfbVTNxcbsx7VdwQ21Bt-vo2ZU1tEM1_JX7uKnng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAeHK+xTxPhfbVTNxcbsx7VdwQ21Bt-vo2ZU1tEM1_JX7uKnng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kate Stewart <kstewart@linuxfoundation.org>, linux-doc@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Kostya Serebryany <kcc@google.com>, linux-kselftest@vger.kernel.org, Chintan Pandya <cpandya@codeaurora.org>, Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, Jacob Bramley <Jacob.Bramley@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Evgeniy Stepanov <eugenis@google.com>, Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Al Viro <viro@zeniv.linux.org.uk>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Memory Management List <linux-mm@kvack.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Aug 03, 2018 at 04:59:18PM +0200, Andrey Konovalov wrote:
> On Thu, Aug 2, 2018 at 5:00 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> > On Wed, Aug 1, 2018 at 7:42 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> On Mon, Jul 16, 2018 at 01:25:59PM +0200, Andrey Konovalov wrote:
> >>> On Thu, Jun 28, 2018 at 9:30 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> >>> So the checker reports ~100 different places where a __user pointer
> >>> being casted. I've looked through them and found 3 places where we
> >>> need to add untagging. Source code lines below come from 4.18-rc2+
> >>> (6f0d349d).
> >> [...]
> >>> I'll add the 3 patches with fixes to v5 of this patchset.
> >>
> >> Thanks for investigating. You can fix those three places in your code
> >
> > OK, will do.
> >
> >> but I was rather looking for a way to check such casting in the future
> >> for newly added code. While for the khwasan we can assume it's a debug
> >> option, the tagged user pointers are ABI and we need to keep it stable.
> >>
> >> We could we actually add some macros for explicit conversion between
> >> __user ptr and long and silence the warning there (I guess this would
> >> work better for sparse). We can then detect new ptr to long casts as
> >> they appear. I just hope that's not too intrusive.
> >>
> >> (I haven't tried the sparse patch yet, hopefully sometime this week)
> >
> > Haven't look at that sparse patch yet myself, but sounds doable.
> > Should these macros go into this patchset or should they go
> > separately?
> 
> Started looking at this. When I run sparse with default checks enabled
> (make C=1) I get countless warnings. Does anybody actually use it?

Try using a more up-to-date version of sparse.  Odds are you are using
an old one, there is a newer version in a different branch on kernel.org
somewhere...

greg k-h
