Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbeFVGHp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Jun 2018 02:07:45 -0400
Date: Fri, 22 Jun 2018 15:07:40 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH -tip v6 26/27] Documentation: kprobes: Add how to change
 the execution path
Message-ID: <20180622150740.bd26241032c972d86e23bf73@kernel.org>
In-Reply-To: <20180621103546.GA9212@gmail.com>
References: <152942424698.15209.15245996287444292393.stgit@devbox>
        <152942500680.15209.12374262914863044775.stgit@devbox>
        <706832c5-dab4-f806-96d6-2cdc37203d9d@infradead.org>
        <20180620172637.35916da482442b6ab139c7dc@kernel.org>
        <20180621103546.GA9212@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Message-ID: <20180622060740.oAdod-YBYmDZEtBMGkutTtJPp7hH-apffW2iF9Cu0TI@z>

On Thu, 21 Jun 2018 12:35:46 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Tue, 19 Jun 2018 09:31:49 -0700
> > Randy Dunlap <rdunlap@infradead.org> wrote:
> > 
> > > On 06/19/2018 09:16 AM, Masami Hiramatsu wrote:
> > > > Add a section that explaining how to change the execution
> > > > path with kprobes and warnings for some arch.
> > > > 
> > > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > > Cc: linux-doc@vger.kernel.org
> > > > ---
> > > >  Documentation/kprobes.txt |   20 ++++++++++++++++++++
> > > >  1 file changed, 20 insertions(+)
> > > > 
> > > > diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
> > > > index 3e9e99ea751b..8a98eed1521b 100644
> > > > --- a/Documentation/kprobes.txt
> > > > +++ b/Documentation/kprobes.txt
> > > > @@ -80,6 +80,26 @@ After the instruction is single-stepped, Kprobes executes the
> > > >  "post_handler," if any, that is associated with the kprobe.
> > > >  Execution then continues with the instruction following the probepoint.
> > > >  
> > > 
> > > Hi,
> > > I have a few small suggestions...
> > 
> > Hi Randy,
> > 
> > Thank you for your suggestions!
> > All of those are good to me. I'll fix it:)
> 
> Could you please send a delta patch on top of your v6 series, with Randy credited, 
> etc?

Ok, Here's the delta patch.


> 
> I've applied your series and will push it out once it passes all testing.

Thanks!
