Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:36507 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932372AbcJUQsq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Oct 2016 12:48:46 -0400
Date: Fri, 21 Oct 2016 16:48:36 +0000
From: Joseph Myers <joseph@codesourcery.com>
Subject: Re: [PATCH 2/3] ARM: convert to generated system call tables
In-Reply-To: <20161021154856.GC1041@n2100.armlinux.org.uk>
Message-ID: <alpine.DEB.2.20.1610211641430.27636@digraph.polyomino.org.uk>
References: <E1bwa6s-0004ZY-4k@rmk-PC.armlinux.org.uk> <3851270.xZRcP9hae0@wuerfel> <20161021133708.GA1041@n2100.armlinux.org.uk> <4337157.Eff9E2riVH@wuerfel> <20161021154856.GC1041@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-arch <linux-arch@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>
Message-ID: <20161021164836.B9aXf59jN36P-2iDuZJQ45zCjoZ17ZDiVtaDzJ7YgR0@z>

On Fri, 21 Oct 2016, Russell King - ARM Linux wrote:

> To stop adding OABI syscalls altogether.  I'm sure that there will
> come a point (if it hasn't already) that glibc no longer supports
> OABI, and at that point it probably becomes rather silly to keep
> adding OABI syscalls.

glibc hasn't supported OABI since 2012 (support removed in version 2.16 
released 2012-06-30).  GCC support was also removed in 2012 (removal 
released in version 4.8, released 2013-03-22).

-- 
Joseph S. Myers
joseph@codesourcery.com
