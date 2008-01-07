Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:28332 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339AbYAGSt6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jan 2008 13:49:58 -0500
Received: by wa-out-1112.google.com with SMTP id v27so12680310wah.23
        for <linux-arch@vger.kernel.org>; Mon, 07 Jan 2008 10:49:57 -0800 (PST)
Message-ID: <6934efce0801071049u546005e7t7da4311cc0611ccd@mail.gmail.com>
Date: Mon, 7 Jan 2008 10:49:57 -0800
From: "Jared Hulbert" <jaredeh@gmail.com>
Subject: Re: [rfc][patch] mm: use a pte bit to flag normal pages
In-Reply-To: <20080107103028.GA9325@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20071221104701.GE28484@wotan.suse.de>
	 <OFEC52C590.33A28896-ONC12573B8.0069F07E-C12573B8.006B1A41@de.ibm.com>
	 <20080107044355.GA11222@wotan.suse.de>
	 <20080107103028.GA9325@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>, Martin Schwidefsky <martin.schwidefsky@de.ibm.com>, carsteno@linux.vnet.ibm.com, Heiko Carstens <h.carstens@de.ibm.com>, Jared Hulbert <jaredeh@gmail.com>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org

> ARM is going to have to use the three remaining bits we have in the PTE
> to store the memory type to resolve bugs on later platforms.  Once they're
> used, ARM will no longer have any room for any further PTE expansion.

Russell,

Can you explain this a little more.
