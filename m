From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 2/6] seqno-fence: Hardware dma-buf implementation of
 fencing (v4)
Date: Mon, 3 Mar 2014 22:01:04 +0100
Message-ID: <20140303210104.GJ17001@phenom.ffwll.local>
References: <20140217155056.20337.25254.stgit@patser>
 <20140217155556.20337.37589.stgit@patser>
 <53023F3E.3080107@vodafone.de>
 <CAF6AEGtHSg=qESbGE8LZsQPrRfHnrSQOjpEAVKeZ5o9k07ZNcA@mail.gmail.com>
 <530248B1.2090405@vodafone.de>
 <CAF6AEGtk1dGdFg2wk-ofRQmaxEnnEOQBOg=JNaPRVapQqsML+w@mail.gmail.com>
 <530257E3.2060508@vodafone.de>
 <5304B0E7.4000802@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ea0-f175.google.com ([209.85.215.175]:35439 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbaCCVBJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 Mar 2014 16:01:09 -0500
Received: by mail-ea0-f175.google.com with SMTP id d10so1651164eaj.34
        for <linux-arch@vger.kernel.org>; Mon, 03 Mar 2014 13:01:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5304B0E7.4000802@canonical.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@canonical.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple@vodafone.de>, Rob Clark <robdclark@gmail.com>, linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, Colin Cross <ccross@google.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>

On Wed, Feb 19, 2014 at 02:25:59PM +0100, Maarten Lankhorst wrote:
> op 17-02-14 19:41, Christian K=F6nig schreef:
> >Am 17.02.2014 19:24, schrieb Rob Clark:
> >>On Mon, Feb 17, 2014 at 12:36 PM, Christian K=F6nig
> >><deathsimple@vodafone.de> wrote:
> >>>Am 17.02.2014 18:27, schrieb Rob Clark:
> >>>
> >>>>On Mon, Feb 17, 2014 at 11:56 AM, Christian K=F6nig
> >>>><deathsimple@vodafone.de> wrote:
> >>>>>Am 17.02.2014 16:56, schrieb Maarten Lankhorst:
> >>>>>
> >>>>>>This type of fence can be used with hardware synchronization fo=
r simple
> >>>>>>hardware that can block execution until the condition
> >>>>>>(dma_buf[offset] - value) >=3D 0 has been met.
> >>>>>
> >>>>>Can't we make that just "dma_buf[offset] !=3D 0" instead? As far=
 as I know
> >>>>>this way it would match the definition M$ uses in their WDDM
> >>>>>specification
> >>>>>and so make it much more likely that hardware supports it.
> >>>>well 'buf[offset] >=3D value' at least means the same slot can be=
 used
> >>>>for multiple operations (with increasing values of 'value').. not=
 sure
> >>>>if that is something people care about.
> >>>>
> >>>>>=3Dvalue seems to be possible with adreno and radeon.  I'm not r=
eally sure
> >>>>>about others (although I presume it as least supported for nv de=
sktop
> >>>>>stuff).  For hw that cannot do >=3Dvalue, we can either have a d=
ifferent fence
> >>>>>implementation which uses the !=3D0 approach.  Or change seqno-f=
ence
> >>>>>implementation later if needed.  But if someone has hw that can =
do !=3D0 but
> >>>>>not >=3Dvalue, speak up now ;-)
> >>>
> >>>Here! Radeon can only do >=3Dvalue on the DMA and 3D engine, but n=
ot with UVD
> >>>or VCE. And for the 3D engine it means draining the pipe, which is=
n't really
> >>>a good idea.
> >>hmm, ok.. forgot you have a few extra rings compared to me.  Is UVD
> >>re-ordering from decode-order to display-order for you in hw? If no=
t,
> >>I guess you need sw intervention anyways when a frame is done for
> >>frame re-ordering, so maybe hw->hw sync doesn't really matter as mu=
ch
> >>as compared to gpu/3d->display.  For dma<->3d interactions, seems l=
ike
> >>you would care more about hw<->hw sync, but I guess you aren't like=
ly
> >>to use GPU A to do a resolve blit for GPU B..
> >
> >No UVD isn't reordering, but since frame reordering is predictable y=
ou usually end up with pipelining everything to the hardware. E.g. you =
send the decode commands in decode order to the UVD block and if you ha=
ve overlay active one of the frames are going to be the first to displa=
y and then you want to wait for it on the display side.
> >
> >>For 3D ring, I assume you probably want a CP_WAIT_FOR_IDLE before a
> >>CP_MEM_WRITE to update fence value in memory (for the one signallin=
g
> >>the fence).  But why would you need that before a CP_WAIT_REG_MEM (=
for
> >>the one waiting for the fence)?  I don't exactly have documentation
> >>for adreno version of CP_WAIT_REG_{MEM,EQ,GTE}..  but PFP and ME
> >>appear to be same instruction set as r600, so I'm pretty sure they
> >>should have similar capabilities.. CP_WAIT_REG_MEM appears to be sa=
me
> >>but with 32bit gpu addresses vs 64b.
> >
> >You shouldn't use any of the CP commands for engine synchronization =
(neither for wait nor for signal). The PFP and ME are just the top of a=
 quite deep pipeline and when you use any of the CP_WAIT functions you =
block them for something and that's draining the pipeline.
> >
> >With the semaphore and fence commands the values are just attached a=
s prerequisite to the draw command, e.g. the CP setups the draw environ=
ment and issues the command, but the actual execution of it is delayed =
until the "!=3D 0" condition hits. And in the meantime the CP already p=
repares the next draw operation.
> >
> >But at least for compute queues wait semaphore aren't the perfect so=
lution either. What you need then is a GPU scheduler that uses a kernel=
 task for setting up the command submission for you when all prerequisi=
tes are meet.
> nouveau has sort of a scheduler in hardware. It can yield when waitin=
g
> on a semaphore. And each process gets their own context and the
> timeslices can be adjusted. ;-) But I don't mind changing this patch
> when an actual user pops up. Nouveau can do a  wait for (*sema & mask=
)
> !=3D 0 only on nvc0 and newer, where mask can be chosen. But it can d=
o =3D=3D
> somevalue and >=3D somevalue on older relevant optimus hardware, so i=
f we
> know that it was zero before and we know the sign of the new value th=
at
> could work too.
>=20
> Adding ops and a separate mask later on when users pop up is fine wit=
h
> me, the original design here was chosen so I could map the intel stat=
us
> page read-only into the process specific nvidia vm.

Yeah, I guess in the end we might end up having a pile of different
memory-based (shared through dma-bufs) based fences. But imo getting th=
is
thing of the ground is more important, and you can always do crazy
per-platform/generation/whatever hacks and match on that specific fence
type in the interim. That'll cut it for the SoC madness, which also see=
ms
to be what google does with the android syncpoint stuff.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
