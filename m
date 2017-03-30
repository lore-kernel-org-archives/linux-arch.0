From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Thu, 30 Mar 2017 13:40:31 -0700
Message-ID: <efb7aaa4-7d25-0c68-ebf8-cdd7eb1297dc@synopsys.com>
References: <20170329055706.GH29622@ZenIV.linux.org.uk>
 <3399faa9-795e-39db-42f5-7d1e10bbff9c@synopsys.com>
 <20170329202939.GI29622@ZenIV.linux.org.uk>
 <32129bc4-0e0a-c21d-0e94-67f73a09ac6e@synopsys.com>
 <20170329234246.GL29622@ZenIV.linux.org.uk>
 <09ead054-f62a-76e2-88e0-8d18592d2604@synopsys.com>
 <CA+55aFyGwYwdk8i7-GbXV7NLTn38e-bow3VD-hHcQmTr9ebAjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:54107 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbdC3Ull (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2017 16:41:41 -0400
In-Reply-To: <CA+55aFyGwYwdk8i7-GbXV7NLTn38e-bow3VD-hHcQmTr9ebAjw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <Jonas.Nilsson@syn>

On 03/29/2017 05:27 PM, Linus Torvalds wrote:
> On Wed, Mar 29, 2017 at 5:02 PM, Vineet Gupta
> <Vineet.Gupta1@synopsys.com> wrote:
>>
>> I guess I can in next day or two - but mind you the inline version for ARC is kind
>> of special vs. other arches. We have this "manual" constant propagation to elide
>> the unrolled LD/ST for 1-15 byte stragglers, when @sz is constant.
> 
> I don't think that's special. We do that on x86 too, and I suspect ARC
> copied it from there (or from somebody else who did it).

No, I (re)wrote that code and AFAIKR didn't copy from anyone and AFAICS it is
certainly different from others if not special. If you look closely at
arc:access.h it is not the trivial check for 1-2-4 conversion as in the commit you
referred to. It actually tries to compile time eliminate hunks from inline
assembly, for constant @sz (so is designed purely for inlined variants, whether
that matters or  not is a different story). Thing is from the hardware POV, 4
LD/ST in flight is good (atleast for ARC700 cores) so we wrap it up in a Zero
delay loop. This takes care of multiples of 16 bytes, the last 15 bytes are the
killer which requires bunch of conditionals which is what I try to eliminate.

FWIW, I experimented with uaccess inlining on ARC
1. pristine 4.11-rc1 (all inline)
2. Inline + disabling the "smart" const propagation
3. Out of line only variants (which already existed/default on ARC for -Os, but
hacked for current -O3)

Numbers for LMBench FS latency (off of tmpfs to avoid any device related
perturbation). Note that LMBench already runs them several times itself and each
of below is obviously with a fresh reboot since kernels were different.

So it seems 0k file create/del gets worse without the smart inline, while 10k gets
better. mmap (16k) got worse as well. With out of line some got better while some
worse.


   File & VM system latencies in microseconds - smaller is better
   -------------------------------------------------------------------------------
   Host                 OS   0K File      10K File     Mmap    Prot   Page   100fd
                           Create Delete Create Delete Latency Fault  Fault  selct
   --------- ------------- ------ ------ ------ ------ ------- ----- ------- -----
   170329-v4 Linux 4.11.0-  124.3   75.3  734.2  147.8  2200.0 6.205    10.9  87.6
   170330-v4 Linux 4.11.0-  154.9   88.3  709.2  131.2  2494.0 4.056    11.0  91.1
   170330-v4 Linux 4.11.0-  157.7   69.8  622.7  140.8  2168.0 5.654    10.8  91.0

Compare that to data against

1. pristine 4.11-rc1 (all inline)
2. Al's series + ARC forced inline
3. Al's series + ARC forced NOT inline

   File & VM system latencies in microseconds - smaller is better
   -------------------------------------------------------------------------------
   Host                 OS   0K File      10K File     Mmap    Prot   Page   100fd
                           Create Delete Create Delete Latency Fault  Fault  selct
   --------- ------------- ------ ------ ------ ------ ------- ----- ------- -----
   170329-v4 Linux 4.11.0-  124.3   75.3  734.2  147.8  2200.0 6.205    10.9  87.6
   170329-v4 Linux 4.11.0-  141.2   63.4  629.7  130.0  2172.0 5.796    10.8  90.0
   170329-v4 Linux 4.11.0-  154.9   89.2  691.6  147.7  2323.0 4.922    10.8  92.3

So it's a mix bag really. Maybe we need some better directed test to really drill
it down.


> But at least on x86 is is limited entirely to the "__" versions, and
> it's almost entirely pointless. We actually removed some of that kind
> of code because it was *do* pointless, and it had just been copied
> around into the "atomic" versions too.
> 
> See for example commit bd28b14591b9 ("x86: remove more uaccess_32.h
> complexity"), which did that.
> 
> The basic "__" versions still do that constant-size thing, but they
> really are questionable. 

Perhaps because the scope of constant usage was pretty narrow - it would only
benefit if *copy_from_user() were called with 1,2,4 which is relatively unlikely
as we have __get_user and friends for that already.

> Exactly because it's just the "__" versions -
> the *regular* "copy_to/from_user()" is an unconditional function call,
> because inlining it isn't just the access operations, it's the size
> check, and on modern x86 it's also the "set AC to mark the user access
> as safe".

So what you are saying is it is relatively costly on x86 because of SMAP which may
not be true for arches w/o hardware support.
Note that I'm not arguing for/against inlining per-se, it seems it doesn't matter

-Vineet
