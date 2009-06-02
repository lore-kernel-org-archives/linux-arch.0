From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Wed, 3 Jun 2009 00:21:32 +0200
Message-ID: <20090602222132.GK6399@game.jcrosoft.org>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <20090602172941.GL3095@hansolo.jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 42.mail-out.ovh.net ([213.251.189.42]:52164 "HELO
	42.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753050AbZFBWlg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jun 2009 18:41:36 -0400
Content-Disposition: inline
In-Reply-To: <20090602172941.GL3095@hansolo.jdub.homelinux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org

On 13:29 Tue 02 Jun     , Josh Boyer wrote:
> On Tue, Jun 02, 2009 at 03:22:20PM +0000, James Bottomley wrote:
> >Hi All,
> >
> >We've got to the point where there are simply too many embedded
> >architectures to invite all the arch maintainers to the kernel summit.
> >So, this year, we thought we'd do embedded via topic driven invitations
> >instead.  So what we're looking for is a proposal to discuss the issues
> >most affecting embedded architectures, or preview any features affecting
> >the main kernel which embedded architectures might need ... or any other
> >topics from embedded architectures which might need discussion or
> >debate.  If you'd like to do this, could you either reply to this email,
> >or send proposals to:
> >
> >ksummit-2009-discuss@lists.linux-foundation.org
> 
> For those not following the ksummit list, below is the current list of
> suggested topics:
> 
> PROPOSER        TOPIC
> 
> Jon Corbet      How much do we owe sloppy application writers
> Jon Corbet      The containers end game and how we get there
> Balbir Singh    The Hacking Hour
> Rafael Wysocki  Regression tracking and kernel quality
> Jon Corbet      Criteria for acceptance of kernel tracepoints
> Jesse Barnes    Profiling and performance counters
> Eric Biederman  Procedures for dealing with patent problems
> John Linville   Patch review checklist
> Matthew Wilcox  How to handle style-only patches
> Dan Williams    RAID unification / stacked block devices
> Jiri Kosina     User-space drivers - worth encouraging?
> Sam Ravnborg    Shipping user-space components in the kernel
> Kay Sievers     Establishment/maintenance of per-subsystem todo lists
> Steve Rostedt   Improving changelogs
> Jon Corbet      I/O bandwidth controllers (maybe minisummit report)
> Ted Ts'o        PulseAudio and kernel interface issues
> Greg KH         Generic architecture support and arch layer cleanup
>                 (Josh Boyer: add device tree discussion?)
> Dave Jones      cpumasks, churn, and unending API changes
> Dirk Hohndel    Issues related to wireless technologies
> Jon Corbet      Tracing:
>                         Merging utrace
>                         Ftrace mainline v. private debugging tools
>                         Non-ftrace visibility infrastructure
>                         Systemtap for kernel developers
> Marcel Holtmann         Tracing and protocol dumping
I'd like to propose AMP and kernel relocate
as more and SoC will came with multiple core with or without the same arch

Best Regards,
J.
