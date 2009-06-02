From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Tue, 2 Jun 2009 13:29:41 -0400
Message-ID: <20090602172941.GL3095@hansolo.jdub.homelinux.org>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:44986 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754875AbZFBRf0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jun 2009 13:35:26 -0400
Content-Disposition: inline
In-Reply-To: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org

On Tue, Jun 02, 2009 at 03:22:20PM +0000, James Bottomley wrote:
>Hi All,
>
>We've got to the point where there are simply too many embedded
>architectures to invite all the arch maintainers to the kernel summit.
>So, this year, we thought we'd do embedded via topic driven invitations
>instead.  So what we're looking for is a proposal to discuss the issues
>most affecting embedded architectures, or preview any features affecting
>the main kernel which embedded architectures might need ... or any other
>topics from embedded architectures which might need discussion or
>debate.  If you'd like to do this, could you either reply to this email,
>or send proposals to:
>
>ksummit-2009-discuss@lists.linux-foundation.org

For those not following the ksummit list, below is the current list of
suggested topics:

PROPOSER        TOPIC

Jon Corbet      How much do we owe sloppy application writers
Jon Corbet      The containers end game and how we get there
Balbir Singh    The Hacking Hour
Rafael Wysocki  Regression tracking and kernel quality
Jon Corbet      Criteria for acceptance of kernel tracepoints
Jesse Barnes    Profiling and performance counters
Eric Biederman  Procedures for dealing with patent problems
John Linville   Patch review checklist
Matthew Wilcox  How to handle style-only patches
Dan Williams    RAID unification / stacked block devices
Jiri Kosina     User-space drivers - worth encouraging?
Sam Ravnborg    Shipping user-space components in the kernel
Kay Sievers     Establishment/maintenance of per-subsystem todo lists
Steve Rostedt   Improving changelogs
Jon Corbet      I/O bandwidth controllers (maybe minisummit report)
Ted Ts'o        PulseAudio and kernel interface issues
Greg KH         Generic architecture support and arch layer cleanup
                (Josh Boyer: add device tree discussion?)
Dave Jones      cpumasks, churn, and unending API changes
Dirk Hohndel    Issues related to wireless technologies
Jon Corbet      Tracing:
                        Merging utrace
                        Ftrace mainline v. private debugging tools
                        Non-ftrace visibility infrastructure
                        Systemtap for kernel developers
Marcel Holtmann         Tracing and protocol dumping



Some of these certainly impact embedded architectures and workloads.  Examples
would be "Generic architecture support, arch layer cleanup", tracing, profiling
and performance counters, userspace drivers, etc.

Which leads me to suggest that it is at least worth having someone with an
embedded focus at KS to simply keep an eye out for impacts of generic changes.
"Feature parity" is something I often deal with in trying to keep ppc4xx up to
speed with the rest of the archs in the kernel.

josh
