From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Minimal linker script
Date: Sun, 10 May 2009 10:53:57 -0700
Message-ID: <4A0714B5.40402@zytor.com>
References: <20090509080006.GA22617@uranus.ravnborg.org> <4A061158.3010604@zytor.com> <20090510085504.GA18719@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:60958 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbZEJRyI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 10 May 2009 13:54:08 -0400
In-Reply-To: <20090510085504.GA18719@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Tim Abbott <tabbott@mit.edu>

Sam Ravnborg wrote:
> 
> Do you then say that i386 could allow us to use absolute symbols,
> and we could adjust in the code instead?
> 
> That would make the linker script nicer but with added
> complexity in the code..
> 

Correct.  The key, obviously, is to make sure we don't end up having to
adjust in multiple places all the time.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
