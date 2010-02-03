From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/14] avr32: use generic ptrace_resume code
Date: Wed, 3 Feb 2010 20:28:35 +0100
Message-ID: <20100203192835.GA25603@lst.de>
References: <20100202185755.GA3630@lst.de> <20100202185857.GD3630@lst.de> <20100203084737.6e01247b@siona> <20100203083611.GA29025@lst.de> <20100203192223.GA12039@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:53242 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757095Ab0BCT3e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 3 Feb 2010 14:29:34 -0500
Content-Disposition: inline
In-Reply-To: <20100203192223.GA12039@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, roland@redhat.com, akpm@linux-foundation.org, hskinnemoen@atmel.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, Feb 03, 2010 at 08:22:23PM +0100, Oleg Nesterov wrote:
> On 02/03, Christoph Hellwig wrote:
> >
> > I don't think the flag clearing on PTRACE_KILL matters as the process
> > is a zombie and almost gone anyway, it's more an artefact of the
> > generic implementation that I wanted to mention.
> 
> Well, PTRACE_KILL doesn't necessarily kill the tracee. Only if the
> tracee reported the signal or syscall, otherwise ->exit_code is
> ignored.
> 
> OTOH I agree, probably the flag clearing on PTRACE_KILL doesn't
> really matter beause PTRACE_KILL shouldn't be used at all.

You're right of course.  When writing the above I somehow had a mental
picture of only the EXIT_ZOMBIE case, but we're not even clearing the
flag in that case.
