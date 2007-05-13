Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:55341 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755793AbXEMVvx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 13 May 2007 17:51:53 -0400
Date: Sun, 13 May 2007 23:52:49 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] consolidate .text section definition in asm-generic
Message-ID: <20070513215249.GB4967@uranus.ravnborg.org>
References: <20070512223133.GA9813@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070512223133.GA9813@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

> +++ b/arch/alpha/kernel/vmlinux.lds.S
> @@ -15,7 +15,7 @@ SECTIONS
>  
>    _text = .;					/* Text and read-only data */
>    .text : { 
> -	*(.text) 
> +	TEXT_TEXT
>  	SCHED_TEXT
>  	LOCK_TEXT
>  	*(.fixup)

It was in private mail suggested to improve naming a bit.
Originally I thought of CODE_TEXT but ended up with TEXT_TEXT.

Any better ideas?

As time permits I will try to do a bit more consolidation
of the lds files. But nothing earthshaking.

	Sam
