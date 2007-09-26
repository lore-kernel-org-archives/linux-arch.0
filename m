Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:48975 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753483AbXIZSSx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 26 Sep 2007 14:18:53 -0400
Date: Wed, 26 Sep 2007 20:18:51 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch 1/7] Extended crashkernel command line
Message-ID: <20070926181851.GA29815@suse.de>
References: <20070925182257.900701776@strauss.suse.de> <20070925182258.175348676@strauss.suse.de> <E1IaHPU-00089b-Bc@flower> <20070926161602.GA26909@suse.de> <20070926181843.GB24301@flower.upol.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070926181843.GB24301@flower.upol.cz>
Sender: linux-arch-owner@vger.kernel.org
To: Oleg Verych <olecom@flower.upol.cz>
Cc: "Bernhard Walle (in kexec list)" <kexec@lists.infradead.org>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

* Oleg Verych <olecom@flower.upol.cz> [2007-09-26 20:18]:
> 
> I was thinking about errors in YaST or typos in bootloader config, that
> may appear sometimes. And kernel must tolerate this kind of userspace
> input to be more reliable. But you know better, i just am waving hands.

Of course the kernel must be able to handle them -- outputting an
error message that can be read by the user and not crashing. But I
don't expect that the kernel then reservate crash memory by guessing
of values.



Thanks,
   Bernhard
