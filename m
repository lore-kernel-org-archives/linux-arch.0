From: Michal Marek <mmarek@suse.cz>
Subject: Re: ARC build -O3 (was Re: subtle side effect of commit a1c48bb160f836)
Date: Thu, 02 Jul 2015 21:50:37 +0200
Message-ID: <5595960D.8040208@suse.cz>
References: <55826966.6050202@synopsys.com> <CAMuHMdXWHYF8hEEgeFxLTrhvmEDBVS2=VmKykfOtDkGjqODQbA@mail.gmail.com> <20150618081329.GA9434@pobox.suse.cz> <55828527.8050901@synopsys.com> <55829A0B.8070804@suse.cz> <55829E51.3060007@synopsys.com> <558AA080.7070801@synopsys.com> <20150701151930.GB6743@sepie.suse.cz> <5594CBBE.2030302@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35863 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753886AbbGBTuk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 2 Jul 2015 15:50:40 -0400
In-Reply-To: <5594CBBE.2030302@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

Dne 2.7.2015 v 07:27 Vineet Gupta napsal(a):
> On Wednesday 01 July 2015 08:49 PM, Michal Marek wrote:
>> On Wed, Jun 24, 2015 at 05:50:16PM +0530, Vineet Gupta wrote:
>>> On Thursday 18 June 2015 04:02 PM, Vineet Gupta wrote:
>>>> On Thursday 18 June 2015 03:44 PM, Michal Marek wrote:
>>>>> Uh, this is not what I meant. KCFLAGS is a *user* setting. It's meant to
>>>>> be set in the environment or command line.
>>>>
>>>> Well I don't want to rely on external settings whatsoever to enforce this. If this
>>>> is not the right way, what do u suggest I do to help fix this.
>>>
>>>
>>> Can I keep this seeming abuse of KCFLAGS or do u suggest alternate approach I can
>>> code up !
>>
>> Hi Vineet, sorry for the late reply.
> 
> NP !
> 
>> I had something like the below
>> patch in mind, simply allow arc to specify -O3 in ARCH_CFLAGS (that part
>> I'm leaving up to you).
> 
> See below !
> 
>> From e458fdf4ae37e1adce81b58d96b1075b4f0656e6 Mon Sep 17 00:00:00 2001
>> From: Michal Marek <mmarek@suse.com>
>> Date: Wed, 1 Jul 2015 17:13:16 +0200
>> Subject: [PATCH] kbuild: Allow arch Makefiles to override {cpp,ld,c}flags
>>
>> Since commit a1c48bb1 (Makefile: Fix unrecognized cross-compiler command
>> line options), the arch Makefile is included earlier by the main
>> Makefile, preventing the arc architecture to set its -O3 compiler
>> option. Since there might be more use cases for an arch Makefile to
>> fine-tune the options, add support for ARCH_CPPFLAGS, ARCH_AFLAGS and
>> ARCH_CFLAGS variables that are appended to the respective kbuild
>> variables. The user still has the final say via the KCPPFLAGS, KAFLAGS
>> and KCFLAGS variables.
>>
>> Reported-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
>> Signed-off-by: Michal Marek <mmarek@suse.com>
> 
> Sweet, that works for me with the following patch below.
> 
> Some logistics things:
> - It would be nice to keep both of these patches together - do u want to do
>   that or want me to pick this one up

Feel free to pick up my patch.


> - For ARC this fixes a regression starting 3.16 - so I'll need a stable backport
>   which but obviously requires above to go to stable. Do u have any issues with
>   that. Shall we do the stable request after these hit the mainline...

Or just add

  Cc: stable@vger.kernel.org # 3.16+

to the patches.

Michal
