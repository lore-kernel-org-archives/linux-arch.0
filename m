Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53033 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751203AbbGAPTc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 1 Jul 2015 11:19:32 -0400
Date: Wed, 1 Jul 2015 17:19:30 +0200
From: Michal Marek <mmarek@suse.cz>
Subject: Re: subtle side effect of commit a1c48bb160f836
Message-ID: <20150701151930.GB6743@sepie.suse.cz>
References: <55826966.6050202@synopsys.com>
 <CAMuHMdXWHYF8hEEgeFxLTrhvmEDBVS2=VmKykfOtDkGjqODQbA@mail.gmail.com>
 <20150618081329.GA9434@pobox.suse.cz>
 <55828527.8050901@synopsys.com>
 <55829A0B.8070804@suse.cz>
 <55829E51.3060007@synopsys.com>
 <558AA080.7070801@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <558AA080.7070801@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Message-ID: <20150701151930.2Lx29_MmylAuobQvW2U1Gx1IjhISz-8rKMXTzw9BjYU@z>

On Wed, Jun 24, 2015 at 05:50:16PM +0530, Vineet Gupta wrote:
> On Thursday 18 June 2015 04:02 PM, Vineet Gupta wrote:
> > On Thursday 18 June 2015 03:44 PM, Michal Marek wrote:
> >> Uh, this is not what I meant. KCFLAGS is a *user* setting. It's meant to
> >> be set in the environment or command line.
> > 
> > Well I don't want to rely on external settings whatsoever to enforce this. If this
> > is not the right way, what do u suggest I do to help fix this.
> 
> 
> Can I keep this seeming abuse of KCFLAGS or do u suggest alternate approach I can
> code up !

Hi Vineet, sorry for the late reply. I had something like the below
patch in mind, simply allow arc to specify -O3 in ARCH_CFLAGS (that part
I'm leaving up to you).
