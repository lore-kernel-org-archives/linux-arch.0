From: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [PATCH v2 08/25] arch: introduce memremap()
Date: Thu, 21 Apr 2016 13:47:36 +0100
Message-ID: <CAB=NE6XDh4kss+qq35tjkjVcsU1m1jny2U7PUWV6Lx1OXb739A@mail.gmail.com>
References: <20150726172527.GA29513@lst.de> <CAPcyv4igoopDPpcCRU1TNYdwPhiYdcDiRA7L9Jdian=0rtexRg@mail.gmail.com>
 <20150727051258.GB15836@lst.de> <CAPcyv4jN6jYzw11qOOR-xd_w6s5dguQSoHyvmPFSWtL9S+tz3w@mail.gmail.com>
 <20150729065004.GA17162@lst.de> <20150729182712.GI30479@wotan.suse.de>
 <CAPcyv4iAeMAmU1QRZ1=WTav0cg2=-gqzzrt3nMC1QoD1+hOeBg@mail.gmail.com>
 <1438203638.3214.418.camel@hp.com> <20150729214358.GK30479@wotan.suse.de>
 <1438214404.3214.438.camel@hp.com> <20150811213021.GD30479@wotan.suse.de>
 <1439332857.24434.37.camel@hp.com> <CAB=NE6U+k5mucfGOhuFoayZB48YMJ0d6o0o8Xe4jH=3ZNgrf-g@mail.gmail.com>
 <CAPcyv4g0-CcFRCWPBdKB7h0zZEO5qzT-N9YLYJw9sb=_HYnXiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:35649 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbcDUMr4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 Apr 2016 08:47:56 -0400
In-Reply-To: <CAPcyv4g0-CcFRCWPBdKB7h0zZEO5qzT-N9YLYJw9sb=_HYnXiA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Daniel Vetter <daniel.vetter@intel.com>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Geert Uytterhoeven <geert@linux-m68k.org>, "H. Peter Anvin" <hpa@zytor.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Wilson <chris@chris-wilson.co.uk>

On Wed, Aug 12, 2015 at 12:13 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Tue, Aug 11, 2015 at 3:52 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
>> On Tue, Aug 11, 2015 at 3:40 PM, Toshi Kani <toshi.kani@hp.com> wrote:
>>> On Tue, 2015-08-11 at 23:30 +0200, Luis R. Rodriguez wrote:
>>>> On Wed, Jul 29, 2015 at 06:00:04PM -0600, Toshi Kani wrote:
>>>> > On Wed, 2015-07-29 at 23:43 +0200, Luis R. Rodriguez wrote:
>>>> > > On Wed, Jul 29, 2015 at 03:00:38PM -0600, Toshi Kani wrote:
>>>> > > > On Wed, 2015-07-29 at 11:33 -0700, Dan Williams wrote:
>>>   :
>>>> > > That would depend on the purpose of the region and the driver
>>>> > > developer should in theory know best. One issue with this of course is
>>>> > > that, as we've discovered, the semantics of on the ioremap*() variant
>>>> > > front regarding cache types is not clearly well defined, or at least
>>>> > > it may be only well defined implicitly on x86 only, so the driver
>>>> > > developer can only *hope* for the best across architectures. Our
>>>> > > ambiguity on our semantics on ioremap*() variants therefore means
>>>> > > driver developers can resonably be puzzled by what fallbacks to use.
>>>> > > That also means architectures maintainers should not whip driver
>>>> > > developers for any misuse. Such considerations are why although we're
>>>> > > now revisiting semantics for ioremap*() variants I was in hopes we
>>>> > > could be at least somewhat pedantic about memremap() semantics.
>>>> >
>>>> > I agree.  However, there are a few exceptions like /dev/mem, which can
>>>> > map a target range without knowledge.
>>>>
>>>> Still, the expectation to require support for overlapping ioremap() calls
>>>> would seem to be more of an exception than the norm, so I'd argue that
>>>> requiring callers who know they do need overlapping support to be explicit
>>>> about it may help us simplify expecations on semantics in other areas of
>>>> the kernel.
>>>
>>> Again, I agree.  I am simply saying that the fallback in an overlapping case
>>> may need to remain supported for such exceptional cases, possibly with a
>>> separate interface.
>>
>> Great.
>>
>>>> > > For instance since memremap() only has 2 types right now can a
>>>> > > respective fallback be documented as an alternative to help with this
>>>> > > ? Or can we not generalize this ?  One for MEMREMAP_WB and one for
>>>> > > MEMREMAP_WT ?
>>>> >
>>>> > Yes, if a target range can be only mapped by memremap().  However, there
>>>> > is no restriction that a range can be mapped with a single interface
>>>> > alone.  For example, a range can be mapped with remap_pfn_range() to
>>>> > user space with any cache type.  So, in theory, memremap() can overlap
>>>> > with any other types.
>>>>
>>>> Shouldn't that be an issue or area of concern ? It seems the flakiness on
>>>> ioremap() and its wide array flexibility would spill over the any
>>>> semantics which folks would be trying to set out with memremap(). That
>>>> should not stop the evolution of memremap() though, just pointing out that
>>>> perhaps we should be a bit more restrictive over how things can criss
>>>> -cross and who areas can do it.
>>>
>>> reserve_pfn_range() allows the caller to specify if the fallback needs to be
>>> enabled or disabled with 'strict_prot'.  track_pfn_remap() called from
>>> remap_pfn_range() enables it, and track_pfn_copy() disables it.  I think we
>>> can do similar for the memremap and ioremap families as well.  The fallback
>>> could be set disabled in the regular interfaces, and enabled in some
>>> interface as necessary.  This also allows gradual transition, ex. disable in
>>> memremap while ioremap remains enabled for now.
>>
>> Sounds sexy to me.
>
> Cool, sounds like something we can tackle in 4.4 along with the
> ioremap_cache removal cleanups.

Just a reminder that we should expect some of these changes soon :D

 Luis
