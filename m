From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Fri, 31 Mar 2017 00:21:47 +0100
Message-ID: <20170330232147.GL7909@n2100.armlinux.org.uk>
References: <20170329055706.GH29622@ZenIV.linux.org.uk>
 <3399faa9-795e-39db-42f5-7d1e10bbff9c@synopsys.com>
 <20170329202939.GI29622@ZenIV.linux.org.uk>
 <32129bc4-0e0a-c21d-0e94-67f73a09ac6e@synopsys.com>
 <20170329234246.GL29622@ZenIV.linux.org.uk>
 <09ead054-f62a-76e2-88e0-8d18592d2604@synopsys.com>
 <CA+55aFyGwYwdk8i7-GbXV7NLTn38e-bow3VD-hHcQmTr9ebAjw@mail.gmail.com>
 <efb7aaa4-7d25-0c68-ebf8-cdd7eb1297dc@synopsys.com>
 <CA+55aFyQL75SOyx=zn1zWvy+TS-Ockv=O9Q59b_ZQwSeCh7WnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFyQL75SOyx=zn1zWvy+TS-Ockv=O9Q59b_ZQwSeCh7WnQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Al Viro <viro@zeniv.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <Jonas.Nilsson@syno>
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 30, 2017 at 01:59:58PM -0700, Linus Torvalds wrote:
> On Thu, Mar 30, 2017 at 1:40 PM, Vineet Gupta
> <Vineet.Gupta1@synopsys.com> wrote:
> >
> > So it's a mix bag really. Maybe we need some better directed test to really drill
> > it down.
> 
> As mentioned inn the discussion about ARM, I seriously doubt that the
> inlining will even be noticeable compared to other effects here.

(Sorry to switch sub-threads.)

I'm running tests on that point, concentrating on hdparm -T and perfing
that.  You're right in so far as perf identifies the hotspot as the
copy_to_user() function for that workload, rather than the inlined bits
- the top hits in perf of hdparm -T are:

+   66.52%  hdparm  [k] __copy_to_user_std
+    8.49%  hdparm  [k] generic_file_read_iter
+    3.82%  hdparm  [k] lock_acquire
+    2.80%  hdparm  [k] copy_page_to_iter
+    2.49%  hdparm  [k] find_get_entry
+    1.19%  hdparm  [k] lock_release

Note: perf on ARM does is affected by IRQ-disabled regions, so hotspots
can be off.

The generic_file_read_iter() one is definitely affected by an IRQ-
disabled region in there.

Here's the average hdparm -T transfer rates and standard deviation over
20 samples:

Unpatched:        Average=320.42 MB/s sigma=0.878657
Uaccess+inline:   Average=318.77 MB/s sigma=1.003332
Uaccess+noinline: Average=319.40 MB/s sigma=1.088354

This pattern - where the noinline version sits between the inlined
version and unpatched version seems to be a pattern in all the
measurements I've done so far, and it points to inlining that code
having a slight detrimental effect.  What we don't know is whether
uninlining the code without Al's patch would see a slight boost,
but I'm not about to go there.

However, this all points towards there being a very slight advantage
to dropping the INLINE_COPY_TO_USER and INLINE_COPY_FROM_USER for
ARM, but I'd say it's really down in the noise - I'm not concerned.

> (On ARM, hopefully the UAO bit is faster to set, but it's still
> "another instruction before and after", so even if it's not as
> expensive as clac/stac are on current x86 chips, it's an argument
> against inlining)

The UAO set/clear does show up as a hotspot within copy_page_to_iter(),
but as we can see, overall its about 3% of the workload.  Within
copy_page_to_iter(), it's the __put_user() based loop inside
fault_in_pages_writeable() which has the hotspot, due to the repeated
enable+disable sequence (more the instruction barriers that we need.)

Perf reports that the barriers account for 8.33 and 17.59% of the
time spent within that function, so we're actually talking about
maybe .25% and .5% of this workload spent doing the UAO thing.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
