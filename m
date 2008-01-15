Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout1.freenet.de ([195.4.92.91]:36681 "EHLO mout1.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326AbYAOJSl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Jan 2008 04:18:41 -0500
Message-ID: <478C7A63.9060108@de.ibm.com>
Date: Tue, 15 Jan 2008 10:18:27 +0100
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: carsteno@de.ibm.com
MIME-Version: 1.0
Subject: Re: [rfc][patch 2/2] mm: introduce optional pte_special pte bit
References: <20080113030810.GB22285@wotan.suse.de> <20080113031013.GD22285@wotan.suse.de> <alpine.LFD.1.00.0801121925330.2806@woody.linux-foundation.org> <20080113043922.GA22345@wotan.suse.de> <alpine.LFD.1.00.0801122042220.2806@woody.linux-foundation.org> <20080113050605.GA1340@wotan.suse.de> <alpine.LFD.1.00.0801130846000.2806@woody.linux-foundation.org> <6934efce0801141304q2987801dr7534fbc657d91061@mail.gmail.com>
In-Reply-To: <6934efce0801141304q2987801dr7534fbc657d91061@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jared Hulbert <jaredeh@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Nick Piggin <npiggin@suse.de>, Hugh Dickins <hugh@veritas.com>, mschwid2@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com, linux-arch@vger.kernel.org

Jared Hulbert wrote:
> Seems
> like the result is a reasonable compromise to me, I'm surprised Nicks
> patch is as clean as it is.  Many of the other proposed solutions are
> very awkward for one or the other.
I second that. It looks way cleaner then all other attempts to solve 
the problem.
