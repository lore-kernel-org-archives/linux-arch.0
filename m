Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58319 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752260AbYB1Mxa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 28 Feb 2008 07:53:30 -0500
Message-ID: <47C6AF31.9080604@suse.de>
Date: Thu, 28 Feb 2008 13:55:13 +0100
From: Andi Kleen <ak@suse.de>
MIME-Version: 1.0
Subject: Re: [rfc][patch] x86-64 new smp_call_function design
References: <20080227124217.GA1340@wotan.suse.de> <20080227132713.GA13681@elte.hu> <20080227135041.GC1340@wotan.suse.de> <20080227150210.GA21610@elte.hu> <20080227221407.GA26067@wotan.suse.de> <20080228084558.GA32631@elte.hu>
In-Reply-To: <20080228084558.GA32631@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <npiggin@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org


>>> The vector duplication is really ugly and feels wrong.
>> Why?
> 
> it's ~0.5% of our irq vector space? :-)

Since there per CPU vectors vectors are not really a precious resource
anymore.

-Andi
