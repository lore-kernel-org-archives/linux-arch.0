Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:2185
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750775AbWATJ4T (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Jan 2006 04:56:19 -0500
Date: Fri, 20 Jan 2006 01:49:45 -0800 (PST)
Message-Id: <20060120.014945.107064207.davem@davemloft.net>
Subject: Re: new syscalls
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060120094309.GA9349@osiris.boeblingen.de.ibm.com>
References: <20060117192949.625f246b.akpm@osdl.org>
	<200601180438.03957.ak@suse.de>
	<20060120094309.GA9349@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: heiko.carstens@de.ibm.com
Cc: ak@suse.de, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Fri, 20 Jan 2006 10:43:09 +0100

> Any reason why arch/x86_64/ia32/ia32entry.S has sys_futimesat in its syscall
> table instead of compat_sys_futimesat? Looks wrong to me...

I made the same mistake on sparc64 (because I used the x86_64 code as
a guide), thanks for pointing it out :)
