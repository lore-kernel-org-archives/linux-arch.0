Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:52189 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbZAYVol (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 25 Jan 2009 16:44:41 -0500
Received: by nf-out-0910.google.com with SMTP id d3so970212nfc.21
        for <linux-arch@vger.kernel.org>; Sun, 25 Jan 2009 13:44:39 -0800 (PST)
Message-ID: <497CDC06.3030900@gmail.com>
Date: Sun, 25 Jan 2009 22:39:18 +0100
From: Andrea Righi <righi.andrea@gmail.com>
Reply-To: righi.andrea@gmail.com
MIME-Version: 1.0
Subject: Re: [PATCH -mmotm] mm: unify some pmd_*() functions
References: <1232919337-21434-1-git-send-email-righi.andrea@gmail.com>
In-Reply-To: <1232919337-21434-1-git-send-email-righi.andrea@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20090125213918.gxKtWpF0FzGBT3kyKcq__Y7B27huEZyK3xOK5nhv6-M@z>

On 2009-01-25 22:35, Andrea Righi wrote:
> Unify all the identical implementations of pmd_free(), __pmd_free_tlb(),
> pmd_alloc_one(), pmd_addr_end() in include/asm-generic/pgtable-nopmd.h
> 

BTW, I only tested this on x86 and x86_64. This needs more testing because it
touches also a lot of other architectures.

-Andrea
